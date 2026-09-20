# frozen_string_literal: true

# Send a feedback request email for all reservations that happened the previous day,
# asking the customer how their experience was.
class FeedbackReservationsMail < ActiveInteraction::Base
  def execute
    eligible.each do |reservation|
      process_reservation(reservation)
    end
  end

  def process_reservation(reservation)
    # Only record the request as "asked" once the email has actually been sent.
    # Otherwise a transient failure (e.g. SMTP hiccup) would permanently mark the
    # reservation as asked, and it would never be retried on a following run.
    ReservationMailer.with(reservation_id: reservation.id).feedback.deliver_now
    Log::ReservationEvent.create!(reservation:, event_type: "delivered_feedback_request")
    reservation.update!(fb_asked_at: Time.zone.now)
    sleep(1) # Avoid sending too many emails at the same time
  rescue StandardError => e
    manage_error(reservation, e)
  end

  def eligible
    @eligible ||= Reservation.visible.where(status: %w[active arrived]).where(
      datetime: Date.yesterday.all_day
    ).where.not(
      id: already_delivered_ids
    ).where.not(
      email: [nil, "", " "]
    ).where(fb_asked_at: nil).where(fb_open_at: nil)
  end

  private

  # Reservations that already received a feedback email.
  def already_delivered_ids
    Log::DeliveredEmail.where(
      record_type: "Reservation",
      controller_path: "reservation_mailer",
      action_name: "feedback"
    ).select(:record_id)
  end

  # Do not let a single reservation failure stop the whole batch: log it, keep going,
  # and make sure the interaction ends up invalid so the job (and Sidekiq) surface the failure.
  def manage_error(reservation, error)
    message = "Failed to send feedback email for reservation ##{reservation.id}: #{error.message}"
    Rails.logger.error("[FeedbackReservationsMail] #{message}")
    errors.add(:base, message)
  end
end
