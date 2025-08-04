# frozen_string_literal: true

module Stripe
  # Used inside the webhook used by Stripe
  class ReceiveEvent < ActiveInteraction::Base
    object :request, class: ActionDispatch::Request

    delegate :params, to: :request

    attr_reader :event

    def execute
      @event = Stripe::Event.retrieve(params[:id])

      case event.data.object.object
      # when "payment_intent" then handle_payment_intent(event.data.object.id)
      when "checkout.session" then handle_checkout_session(event.data.object.id)
      end
    end

    def handle_checkout_session(session_id)
      ReservationPayment.find_by(external_id: session_id)&.fetch_status!
    end
  end
end
