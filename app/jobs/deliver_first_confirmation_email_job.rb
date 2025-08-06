# frozen_string_literal: true

# see DeliverFirstConfirmationEmail docs
class DeliverFirstConfirmationEmailJob
  include Sidekiq::Worker
  sidekiq_options retry: 5, queue: "default"

  def perform(reservation_id)
    DeliverFirstConfirmationEmail.run!(reservation: Reservation.find(reservation_id))
  end
end
