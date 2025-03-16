# frozen_string_literal: true

module Stats
  # Get reservations count: day, week and month.
  class ReservationsCount < ActiveInteraction::Base
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
          day: reservations.where(datetime: Date.current.all_day).pluck(:adults, :children).flatten.sum,
          week: current_week_reservations.pluck(:adults, :children).flatten.sum,
          month: current_month_reservations.pluck(:adults, :children).flatten.sum,
          year: current_year_reservations.pluck(:adults, :children).flatten.sum,
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
        reservations.select("SUM(adults + children), to_char(datetime, #{format}) as time").group("to_char(datetime, #{format})").to_sql
      ).as_json.index_by { |j| j["time"] }.transform_values { |j| j["sum"] }
    end

    def sql(query)
      ActiveRecord::Base.connection.execute(query)
    end

    def reservations
      # @reservations ||= Reservation.visible.not_cancelled
      @reservations ||= Reservation.where(id: SearchReservations.run!(params: search_params).visible.not_cancelled.select(:id))
    end

    def search_params
      return @search_params if defined?(@search_params)

      @search_params = params.keys.filter { |key| key.start_with?("reservations_count", "reservations-count") }.map do |key|
        [
          key.split("_")[1..].join("_").to_sym,
          params[key]
        ]
      end.to_h
    end

    def current_week_reservations
      @current_week_reservations ||= reservations.where(datetime: Date.current.all_week)
    end

    def current_month_reservations
      @current_month_reservations ||= reservations.where(datetime: Date.current.all_month)
    end

    def current_year_reservations
      @current_year_reservations ||= reservations.where(datetime: Date.current.all_year)
    end
  end
end
