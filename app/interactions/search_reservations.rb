# frozen_string_literal: true

class SearchReservations < ActiveInteraction::Base
  interface :params, methods: %i[[] merge! fetch each has_key?], default: {}

  validate do
    if params[:time_from].present? && !params[:time_from].match?(/\A\d{1,2}:\d{1,2}\z/)
      errors.add(:params,
                 ":time_from should have format HH:MM when present")
    end
    if params[:time_to].present? && !params[:time_to].match?(/\A\d{1,2}:\d{1,2}\z/)
      errors.add(:params,
                 ":time_to should have format HH:MM when present")
    end
  end

  def execute
    filter_by_query(
      filter_by_status(
        filter_by_secret(
          filter_by_date(
            filter_by_time(
              filter_by_people(
                filter_by_created_at(
                  order(items)
                )
              )
            )
          )
        )
      )
    )
  end

  private

  def filter_by_people(items)
    items = items.where(adults: params[:adults]) if params[:adults].present?
    items = items.where(children: params[:children]) if params[:children].present?
    items = items.where("adults + children = ?", params[:people]) if params[:people].present?

    items
  end

  def order(items)
    order_by = params[:order_by] || params[:order]
    order_by = order_by.permit!.to_h if order_by.is_a?(ActionController::Parameters)

    if order_by.blank?
      %w[attribute column field by].each do |key|
        next unless params.key?("order_by_#{key}")

        order_by ||= {}
        order_by[:attribute] = params["order_by_#{key}"]
      end

      %w[direction dir order sort].each do |key|
        next unless params.key?("order_by_#{key}")

        order_by ||= {}
        order_by[:direction] = params["order_by_#{key}"]
      end
    end

    if order_by.is_a?(String) && order_by.present? && items.column_names.include?(order_by.split(" ").first)
      return items.order(order_by)
    end

    # ALIASING
    if order_by.is_a?(Hash)
      attribute = order_by[:attribute] || order_by[:column] || order_by[:field] || order_by[:by]
      direction = order_by[:direction] || order_by[:dir] || order_by[:order] || order_by[:sort]

      if attribute.present? && items.column_names.include?(attribute)
        return items.order(attribute => direction.to_s.downcase == "desc" ? :desc : :asc)
      end
    end

    items.order(datetime: :asc)
  end

  # Filter relative to time of day
  # Filters format:
  # time_from: "HH:MM"
  # time_to: "HH:MM"
  # TODO: TEST this method
  def filter_by_time(items)
    time_from = params[:time_from].present? ? Time.zone.parse(params[:time_from]).seconds_since_midnight : nil
    time_to = params[:time_to].present? ? Time.zone.parse(params[:time_to]).seconds_since_midnight : nil

    if time_from.present?
      items.where!(
        "extract(hour from datetime) * 3600 + extract(minute from datetime) * 60 + extract(second from datetime) >= ?",
        time_from
      )
    end

    if time_to.present?
      items.where!(
        "extract(hour from datetime) * 3600 + extract(minute from datetime) * 60 + extract(second from datetime) <= ?",
        time_to
      )
    end

    items
  rescue ArgumentError
    items
  end

  def filter_by_date(items)
    date_from, date_to = datetime_range

    return items if date_from.nil? && date_to.nil?

    items.where(datetime: date_from..date_to)
  rescue Date::Error
    items
  end

  def filter_by_created_at(items)
    date_from, date_to = datetime_range(
      date_from: params[:created_at_from],
      date_to: params[:created_at_to]
    )

    return items if date_from.nil? && date_to.nil?

    items.where(created_at: date_from..date_to)
  rescue Date::Error
    items
  end

  # Will parse inputs and return an array of two dates: "from" and "to".
  # Both may be nil.
  def datetime_range(options = params)
    return [Time.zone.now.beginning_of_day, Time.zone.now.end_of_day] if is_true?(options[:today])

    if options[:date].is_a?(String)
      date = Date.parse(options[:date])
      return [date.beginning_of_day, date.end_of_day]
    end

    date_from = nil
    date_to = nil

    date_from = DateTime.parse(options[:date_from]).beginning_of_day if options[:date_from].is_a?(String)
    date_from = DateTime.parse(options[:datetime_from]) if options[:datetime_from].is_a?(String)

    date_to = DateTime.parse(options[:date_to]).end_of_day if options[:date_to].is_a?(String)
    date_to = DateTime.parse(options[:datetime_to]) if options[:datetime_to].is_a?(String)

    [date_from, date_to]
  end

  def is_true?(value)
    %w[true 1].include?(value.to_s)
  end

  def items
    Reservation.visible
  end

  def filter_by_secret(items)
    return items unless params[:secret].is_a?(String)

    items.where(secret: params[:secret])
  end

  def filter_by_query(items)
    return items unless params[:query].is_a?(String)

    items.where(
      "lower(#{Reservation.table_name}.fullname) ILIKE ? OR lower(#{Reservation.table_name}.notes) ILIKE ? or lower(#{Reservation.table_name}.email) ILIKE ?", "%#{params[:query].downcase}%", "%#{params[:query].downcase}%", "%#{params[:query].downcase}%"
    )
  end

  def filter_by_status(items)
    statuses = status_params.map(&:downcase).map(&:strip).uniq.filter { |status| Reservation.statuses.key?(status) }

    return items if statuses.empty?

    items.where(status: statuses)
  end

  # Returns array of params
  def status_params
    return params[:status].gsub(/[,;]/, " ").split(/\s+/) if params[:status].is_a?(String)
    return params[:statuses].gsub(/[,;]/, " ").split(/\s+/) if params[:statuses].is_a?(String)

    return params[:status] if params[:status].is_a?(Array)
    return params[:statuses] if params[:statuses].is_a?(Array)

    []
  end
end
