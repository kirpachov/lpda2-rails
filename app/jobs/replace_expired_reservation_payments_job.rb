# frozen_string_literal: true

# Replacing expired payments in a background job:
# when active, will look for reservation payments that are expired and replace them with new ones.
class ReplaceExpiredReservationPaymentsJob
  include Sidekiq::Worker
  sidekiq_options retry: 0, queue: "default"

  def perform(*_data)
    ReplaceExpiredReservationPayments.run!
  end
end
