# frozen_string_literal: true

module Stripe
  # Download from Stripe the status of a Checkout Session.
  class FetchReservationPaymentStatus < ActiveInteraction::Base
    # ##############################
    # Inputs
    # ##############################
    record :reservation_payment, class: ReservationPayment

    # ##############################
    # Validations
    # ##############################
    validate do
      errors.add(:reservation_payment, "preorder_type must be one of 'stripe_authorization' or 'stripe_payment'. got #{reservation_payment.preorder_type.inspect}") unless %w[stripe_authorization stripe_payment].include?(reservation_payment.preorder_type)
      errors.add(:reservation_payment, "does not have an 'external_id'") if reservation_payment.external_id.blank?
    end

    validates :reservation_payment, presence: true

    # ##############################
    # - Main -
    # ##############################
    attr_reader :session

    def execute
      # return errors.merge!(session.errors) unless session.valid?
      @session = fetch_session
      return unless session

      update_reservation_payment_status

      reservation_payment.update(external_object: session.as_json) if errors.empty?

      reservation_payment.reload

      session
    end

    private

    def fetch_session
      Stripe::Checkout::Session.retrieve(reservation_payment.external_id)

      # Probably not found
    rescue Stripe::InvalidRequestError => e
      errors.add(:base, "Failed to retrieve Stripe session: #{e.message}")
    end

    # https://docs.stripe.com/api/checkout/sessions/object?api-version=2025-05-28.basil&lang=curl#checkout_session_object-status
    # Stripe documentation for "status" field:
    # complete: The checkout session is complete. Payment processing may still be in progress
    # expired: The checkout session has expired. No further processing will occur
    # open: The checkout session is still in progress. Payment processing has not started
    # Having issues with payments (not authorizations) ? check "payment_status" field.
    def update_reservation_payment_status
      # If it looks like refunded we will trust:
      # It's hard to track the transactions where the record we have on our end is a Stripe::Checkout::Session
      # and not an actual Stripe::PaymentIntent or Stripe::Charge.
      return if reservation_payment.refunded?

      return reservation_payment.todo!        if session.status == "open" || session.status == "expired"
      if session.status == "complete"
        return reservation_payment.paid! if !reservation_payment.deferred? || reservation_payment.paid?

        return reservation_payment.authorized! if reservation_payment.deferred?
      end

      errors.add(:base, "Something went wrong while updating the reservation payment status.\nSession: #{session.as_json}\nReservation payment: #{reservation_payment.as_json}")
      false
    end
  end
end
