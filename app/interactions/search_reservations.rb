# frozen_string_literal: true

class SearchReservations < ActiveInteraction::Base
  record :current_user, class: User
  interface :params, methods: %i[[] merge! fetch each has_key?], default: {}

  def execute
    filter_by_query(
      filter_by_status(
        filter_by_secret(
          filter_by_date(
            items
          )
        )
      )
    )
  end

  private

  def filter_by_date(items)
    date_from, date_to = datetime_range

    return items if date_from.nil? && date_to.nil?

    items.where(datetime: date_from..date_to)
  end

  # Will parse inputs and return an array of two dates: "from" and "to".
  # Both may be nil.
  def datetime_range
    return [Time.zone.now.beginning_of_day, Time.zone.now.end_of_day] if is_true?(params[:today])

    if params[:date].is_a?(String)
      date = Date.parse(params[:date])
      return [date.beginning_of_day, date.end_of_day]
    end

    date_from = nil
    date_to = nil

    date_from = DateTime.parse(params[:date_from]).beginning_of_day if params[:date_from].is_a?(String)
    date_from = DateTime.parse(params[:datetime_from]) if params[:datetime_from].is_a?(String)

    date_to = DateTime.parse(params[:date_to]).end_of_day if params[:date_to].is_a?(String)
    date_to = DateTime.parse(params[:datetime_to]) if params[:datetime_to].is_a?(String)

    [date_from, date_to]
  end

  def is_true?(value)
    ['true', '1'].include?(value.to_s)
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

    items.where("lower(#{Reservation.table_name}.fullname) ILIKE ? OR lower(#{Reservation.table_name}.notes) ILIKE ? or lower(#{Reservation.table_name}.email) ILIKE ?", "%#{params[:query].downcase}%", "%#{params[:query].downcase}%", "%#{params[:query].downcase}%")
  end

  def filter_by_status(items)
    statuses = status_params.map(&:downcase).map(&:strip).uniq.filter { |status| Reservation.statuses.key?(status) }

    return items if statuses.empty?

    items.where(status: statuses)
  end

  # Returns array of params
  def status_params
    return params[:status].gsub(/[,;]/, ' ').split(/\s+/) if params[:status].is_a?(String)
    return params[:statuses].gsub(/[,;]/, ' ').split(/\s+/) if params[:statuses].is_a?(String)

    return params[:status] if params[:status].is_a?(Array)
    return params[:statuses] if params[:statuses].is_a?(Array)

    []
  end
end
