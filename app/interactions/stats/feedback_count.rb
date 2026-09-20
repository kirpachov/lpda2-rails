# frozen_string_literal: true

module Stats
  class FeedbackCount < ActiveInteraction::Base
    interface :params, methods: %i[keys []], default: {}

    def execute
      {
        asked_feedback_count: {
          always: asked_feedback_reservations.count,
          current_month: asked_feedback_reservations.where(datetime: Time.zone.now.beginning_of_month..Time.zone.now.end_of_month).count,
          last_30_days: asked_feedback_reservations.where(datetime: 30.days.ago..Time.zone.now).count,
          last_12_months_by_month: asked_feedback_reservations.where(datetime: 12.months.ago..Time.zone.now).group("to_char(fb_asked_at, 'YYYY-MM')").count,
        },
        open_feedback_count: {
          always: open_feedback_reservations.count,
          current_month: open_feedback_reservations.where(datetime: Time.zone.now.beginning_of_month..Time.zone.now.end_of_month).count,
          last_30_days: open_feedback_reservations.where(datetime: 30.days.ago..Time.zone.now).count,
          last_12_months_by_month: open_feedback_reservations.where(datetime: 12.months.ago..Time.zone.now).group("to_char(fb_open_at, 'YYYY-MM')").count,
        },
        open_to_asked_ratio: {
          always: ratio(open_feedback_reservations.count, asked_feedback_reservations.count),
          current_month: ratio(
            open_feedback_reservations.where(datetime: Time.zone.now.beginning_of_month..Time.zone.now.end_of_month).count,
            asked_feedback_reservations.where(datetime: Time.zone.now.beginning_of_month..Time.zone.now.end_of_month).count
          ),
          last_30_days: ratio(
            open_feedback_reservations.where(datetime: 30.days.ago..Time.zone.now).count,
            asked_feedback_reservations.where(datetime: 30.days.ago..Time.zone.now).count
          ),
          # last_12_months_by_month: asked_feedback_reservations.where(datetime: 12.months.ago..Time.zone.now).group("to_char(datetime, 'YYYY-MM')").count / open_feedback_reservations.where(datetime: 12.months.ago..Time.zone.now).group("to_char(datetime, 'YYYY-MM')").count,
        },
      }
    end

    # Avoids NaN/Infinity (which happens when no feedback has been asked yet for the
    # given period) by returning 0 instead of dividing by zero.
    def ratio(numerator, denominator)
      return 0.0 if denominator.zero?

      numerator.to_f / denominator
    end

    def all_reservations
      @all_reservations ||= Reservation.visible
    end

    def asked_feedback_reservations
      @asked_feedback_reservations ||= all_reservations.where.not(fb_asked_at: nil)
    end

    def open_feedback_reservations
      @open_feedback_reservations ||= all_reservations.where.not(fb_open_at: nil)
    end
  end
end
