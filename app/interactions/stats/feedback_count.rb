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
          always: open_feedback_reservations.count.to_f / asked_feedback_reservations.count,
          current_month: open_feedback_reservations.where(datetime: Time.zone.now.beginning_of_month..Time.zone.now.end_of_month).count.to_f / asked_feedback_reservations.where(datetime: Time.zone.now.beginning_of_month..Time.zone.now.end_of_month).count.to_f,
          last_30_days: open_feedback_reservations.where(datetime: 30.days.ago..Time.zone.now).count.to_f / asked_feedback_reservations.where(datetime: 30.days.ago..Time.zone.now).count.to_f,
          # last_12_months_by_month: asked_feedback_reservations.where(datetime: 12.months.ago..Time.zone.now).group("to_char(datetime, 'YYYY-MM')").count / open_feedback_reservations.where(datetime: 12.months.ago..Time.zone.now).group("to_char(datetime, 'YYYY-MM')").count,
        },
      }
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
