# frozen_string_literal: true

# Given a deferred payment ("Autorizzazione"), will actually charge the user
# Usage:
# Nexi::RecordDeferredPayment.run!(payment: ReservationPayment.last)
class RecordDeferredPayment < ActiveInteraction::Base
  # ################################
  # Inputs
  # ################################
  record :payment, class: ReservationPayment

  delegate :reservation, to: :payment

  # ################################
  # Logic
  # ################################
  def execute
    call_payment_gateway

    return false if errors.any? || invalid?

    payment.update(status: :paid)

    reservation.touch

    event = reservation.events.create(
      event_type: :record_deferred_payment
    )

    errors.merge!(event.errors) if event.errors.any? || event.invalid?
    errors.merge!(payment.errors) if payment.errors.any? || payment.invalid?
    errors.merge!(reservation.errors) if reservation.errors.any? || reservation.invalid?

    ReservationMailer.with(reservation_id: reservation.id).payment_success.deliver_later if errors.empty?

    errors.empty?
  end

  private

  def call_payment_gateway
    case payment.preorder_type
    when "html_nexi_authorization", "html_nexi_payment" then call_payment_gateway_nexi
    when "stripe_authorization", "stripe_payment" then call_payment_gateway_stripe
    else
      errors.add(:payment, "preorder_type #{payment.preorder_type.inspect} not supported")
      false
    end
  end

  def call_payment_gateway_nexi
    compose(
      Nexi::RecordDeferredPayment,
      payment:
    )
  end

  def call_payment_gateway_stripe
    compose(
      Stripe::RecordDeferredPayment,
      payment:
    )
  end
end
