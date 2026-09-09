# frozen_string_literal: true

# Send a feedback email for all reservations that happened the previous day.
class FeedbackReservationsMailJob
  include Sidekiq::Worker
  sidekiq_options retry: 0, queue: "default"

  def perform
    FeedbackReservationsMail.run!
  end
end
