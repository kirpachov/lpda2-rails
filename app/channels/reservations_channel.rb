# frozen_string_literal: true

# https://guides.rubyonrails.org/v7.2/action_cable_overview.html#example-2-receiving-new-web-notifications
# Notify when a reservation is created or cancelled
# Note: Channel is not authenticated, so anyone can subscribe to it. Don't put any sensitive information in the payload.
class ReservationsChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "reservations_channel"
    stream_for "reservations_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  class << self
    def notify_reservation(reservation_id:, action:)
      ReservationsChannel.broadcast_to(
        "reservations_channel",
        reservation_id:,
        action:
      )
    end

    def notify_creation(reservation_id:)
      notify_reservation(reservation_id:, action: "create")
    end

    def notify_cancellation(reservation_id:)
      notify_reservation(reservation_id:, action: "cancel")
    end

    def notify_update(reservation_id:)
      notify_reservation(reservation_id:, action: "update")
    end

    def notify_delete(reservation_id:)
      notify_reservation(reservation_id:, action: "delete")
    end
  end
end
