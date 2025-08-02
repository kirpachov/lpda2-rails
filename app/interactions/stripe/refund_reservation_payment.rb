# frozen_string_literal: true

module Stripe
  # Does complete refund of a ReservationPayment.
  # Will disable checkout sessions, and refund payment intents.
  class RefundReservationPayment < ActiveInteraction::Base
    # ################################
    # Inputs
    # ################################
    record :payment, class: ReservationPayment

    delegate :stripe_payment_details, to: :payment

    delegate :payment_intent, :payment_intent_id, :checkout_session, :checkout_session_id, :expire_checkout_session!,
             :refund_payment_intent!, to: :stripe_payment_details, allow_nil: true

    # ################################
    # Validations
    # ################################

    validate do
      errors.add(:base, "missing stripe_payment_details") if stripe_payment_details.nil?
    end

    # ################################
    # - Main -
    # ################################
    attr_reader :refund, :expire_session

    def execute
      [
        do_refund_checkout_session_payment_intent,
        do_refund_payment_intent,
        do_expire_checkout_session
      ]
    end

    private

    # ################################
    # Helpers
    # ################################

    def do_refund_checkout_session_payment_intent
      return if checkout_session.payment_intent.blank?

      compose(
        RefundPaymentIntent,
        payment:,
        payment_intent_id: checkout_session.payment_intent
      )
    end

    def do_refund_payment_intent
      return if payment_intent_id.blank?

      compose(
        RefundPaymentIntent,
        payment:,
        payment_intent_id:
      )
    end

    def do_expire_checkout_session
      return if checkout_session_id.blank?

      compose(
        ExpireCheckoutSession,
        payment:,
        checkout_session_id:
      )
    end
  end
end
