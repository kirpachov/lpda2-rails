# frozen_string_literal: true

module V1
  # Will manage /v1/stripe routes
  class StripeController < ApplicationController
    skip_before_action :authenticate_user, only: %i[receive_event]

    # Webhook for receiving events in real-time
    # POST /v1/stripe/receive_event
    # https://docs.stripe.com/api/webhook_endpoints?api-version=2025-06-30.basil
    def receive_event
      Rails.logger.warn "StripeController#receive_event: #{params.inspect}, headers: #{request.headers.inspect}"

      call = Stripe::ReceiveEvent.run(request:)

      return render_error(message: call.errors.full_messages.join(",")) if call.errors.any? || call.invalid?

      render json: {
        status: "ok",
        event_id: call.event.id,
        params: params.permit!.to_h
      }
    end
  end
end
