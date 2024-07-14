# frozen_string_literal: true

# Get reservations summary: how many tables for each table size (size = people on the table)
class TablesSummary < ActiveInteraction::Base
  interface :params, methods: %i[[] merge! fetch each has_key?], default: {}
  record :current_user, class: User

  validate do
    errors.add(:params, "param :date is required to be in format 'YYYY-MM-DD'") if params[:date].blank?
    turns
  end

  def execute
    turns.map do |turn|
      summary = summary_for(turn)
      next nil if summary.empty?

      {
        turn: turn.as_json,
        summary:
      }
    end.filter(&:present?)
  end

  def reservations
    return @reservations if defined?(@reservations)

    call = ::SearchReservations.run(params:, current_user:)
    errors.merge!(call.errors) if call.errors.any? || call.invalid?

    @reservations = call.result
  end

  def turns
    return @turns if defined?(@turns)

    @turns = ReservationTurn.all.where(weekday: Date.parse(params[:date].to_s).wday)
    @turns = @turns.where("starts_at <= :time AND ends_at >= :time", time: params[:time]) if params[:time].present?

    @turns
  rescue Date::Error
    errors.add(:params, "param :date is required to be in format 'YYYY-MM-DD'")
  end

  def summary_for(turn)
    ActiveRecord::Base.connection.execute(<<~SQL.squish).to_a.index_by { |j| j["people"] }.transform_values { |j| j["count"] }
      SELECT COUNT(*), #{Reservation.table_name}.children + #{Reservation.table_name}.adults AS people
      FROM #{Reservation.table_name}
      WHERE #{Reservation.table_name}.datetime::time
        BETWEEN '#{turn.starts_at.strftime("%H:%M")}'::time AND '#{turn.ends_at.strftime("%H:%M")}'::time
        AND id IN (#{reservations.select(:id).to_sql})
      GROUP BY people
    SQL
  end
end
