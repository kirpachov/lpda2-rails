# frozen_string_literal: true

module Stats
  # Get reservations count by created_at: when the reservations has been created.
  class ReservationsCreation < ActiveInteraction::Base
    interface :params, methods: %i[keys []], default: {}

    def execute
      calc_stats
    end

    def calc_stats
      {
        count_by_month:,
        count_by_year:,
        count_by_day_current_month:,
        count_by_day_current_week:,
        current: {
          day: reservations.where(created_at: Date.current.all_day).count,
          week: current_week_reservations.count,
          month: current_month_reservations.count,
          year: current_year_reservations.count
        }
      }.with_indifferent_access
    end

    private

    # {
    #   "YYYY-MM" => <count>,
    #   ...
    # }
    def count_by_month
      @count_by_month ||= group_by(reservations, "'YYYY-MM'")
    end

    # {
    #   "YYYY" => <count>,
    #   ...
    # }
    def count_by_year
      @count_by_year ||= group_by(reservations, "'YYYY'")
    end

    # For current month, each day count.
    # {
    #   "YYYY-MM-DD" => <count>,
    #   ...
    # }
    def count_by_day_current_month
      @count_by_day_current_month ||= group_by(current_month_reservations, "'YYYY-MM-DD'")
    end

    # For current week, each day count.
    # Current week is from Monday to Sunday.
    # {
    #   "YYYY-MM-DD" => <count>,
    #   ...
    # }
    def count_by_day_current_week
      @count_by_day_current_week ||= group_by(current_week_reservations, "'YYYY-MM-DD'")
    end

    # #########
    # Utils
    # #########

    def group_by(reservations, format)
      sql(
        reservations.select("COUNT(*), to_char(created_at, #{format}) as time").group("to_char(created_at, #{format})").to_sql
      ).as_json.index_by { |j| j["time"] }.transform_values { |j| j["count"] }
    end

    def sql(query)
      ActiveRecord::Base.connection.execute(query)
    end

    def reservations
      @reservations ||= Reservation.all.visible
    end

    def current_week_reservations
      @current_week_reservations ||= reservations.where("created_at >= ? AND created_at <= ?", Date.current.beginning_of_week.beginning_of_day, Date.current.end_of_week.end_of_day)
    end

    def current_month_reservations
      @current_month_reservations ||= reservations.where("created_at >= ? AND created_at <= ?", Date.current.beginning_of_month.beginning_of_day, Date.current.end_of_month.end_of_day)
    end

    def current_year_reservations
      @current_year_reservations ||= reservations.where("created_at >= ? AND created_at <= ?", Date.current.beginning_of_year.beginning_of_day, Date.current.end_of_year.end_of_day)
    end
  end
end
