# frozen_string_literal: true

module Stripe
  # Given a deferred payment (Authorization), will actually charge the user
  # Usage:
  # Stripe::RecordDeferredPayment.run!(payment: ReservationPayment.last)
  class RecordDeferredPayment < ActiveInteraction::Base
    # ################################
    # Inputs
    # ################################
    record :payment, class: ReservationPayment

    delegate :reservation, :value, :stripe_checkout_session, :stripe_customer_id, :stripe_payment_method_id, to: :payment

    # ################################
    # Validators
    # ################################
    validate do
      errors.add(:payment, "must be a ReservationPayment") unless payment.is_a?(ReservationPayment)
      errors.add(:payment, "must be deferred") unless payment.deferred?
      errors.add(:payment, "must be authorized. got #{payment.status.inspect}") unless payment.authorized?
      errors.add(:payment, "must have a reservation") if reservation.blank?
      errors.add(:payment, "must have an external_id") if payment.external_id.blank?
      errors.add(:payment, "must have a 'complete' stripe_checkout_session. got #{stripe_checkout_session&.status.inspect}") unless stripe_checkout_session&.status == "complete"
      errors.add(:payment, "must have a stripe_customer_id") if stripe_customer_id.blank?
      errors.add(:payment, "must have a stripe_payment_method_id") if stripe_payment_method_id.blank?
    end

    def execute
      payment_intent = compose(
        CreatePaymentIntent,
        amount: value,
        customer_id: stripe_customer_id,
        payment_method_id: stripe_payment_method_id
      )

      payment.stripe_payment_details.update!(payment_intent_id: payment_intent.id)

      payment_intent
    end
  end
end
