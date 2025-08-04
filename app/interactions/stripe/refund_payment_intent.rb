# frozen_string_literal: true

module Stripe
  # Given a ReservationPayment and the id of a payment intent,
  # will refund the payment intent and update the ReservationPayment
  # with the refund id.
  #
  # Usage:
  #   RefundPaymentIntent.run!(payment: rp, payment_intent_id: rp.stripe_payment_intent_id)
  #   RefundPaymentIntent.run!(payment: rp, payment_intent_id: rp.stripe_checkout.payment_intent)
  class RefundPaymentIntent < ActiveInteraction::Base
    # ################################
    # Inputs
    # ################################
    record :payment, class: "ReservationPayment"

    string :payment_intent_id

    # ################################
    # Validations
    # ################################
    validate do
      errors.add(:payment, "cannot have a :refund_id. it looks like it has already been refunded") if payment.stripe_payment_details.refund_id.present?
    end

    # ################################
    # - Main -
    # ################################
    attr_reader :refund

    def execute
      @refund = Stripe::Refund.create(
        payment_intent: payment_intent_id
      )

      payment.stripe_payment_details.update(refund_id: @refund.id)

      @refund
    end
  end
end
