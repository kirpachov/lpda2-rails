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
    compose(
      Nexi::RecordDeferredPayment,
      payment:
    )

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
end
