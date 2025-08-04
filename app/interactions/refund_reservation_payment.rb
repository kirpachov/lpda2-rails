# frozen_string_literal: true

# Given a reservation, will refund its payment.
class RefundReservationPayment < ActiveInteraction::Base
  record :reservation, class: Reservation

  validate do
    # TODO: translate all the messages
    errors.add(:reservation, "does not have a payment") unless reservation.payment.present?
    errors.add(:reservation, "is not paid") unless reservation.payment&.status.to_s.in?(%w[paid authorized])
    errors.add(:reservation, "is already refunded") if reservation.payment&.refunded?
    errors.add(:reservation, "is deleted") if reservation.deleted?
    if reservation.payment&.value.to_f <= 0
      errors.add(:reservation,
                 "value #{reservation.payment&.value.inspect} is invalid")
    end

    if reservation.payment&.paid? && errors.empty? && reservation.datetime < 10.days.ago
      errors.add(:reservation,
                 "too much time has passed. Reservation date was more than 10 days ago. You'll need to refund the payment by Nexi graphical interface. OrderID is #{reservation.payment&.external_id}")
    end
  end

  def execute
    do_refund
    reservation.payment.refunded! if errors.empty? && valid?
  end

  def do_refund
    case reservation.payment.preorder_type
    when "html_nexi_payment", "html_nexi_authorization" then do_refund_nexi
    when "stripe_authorization", "stripe_payment" then do_refund_stripe
    else
      errors.add(:reservation, "payment type #{reservation.payment.preorder_type.inspect} not supported")
    end
  end

  def do_refund_nexi
    call = Nexi::RefundPayment.run(
      value: reservation.payment.value * 100,
      order_id: reservation.payment.external_id,
      request_purpose: "refund_reservation_payment",
      request_record: reservation
    )
    errors.merge!(call.errors) unless call.valid?
  end

  def do_refund_stripe
    call = Stripe::RefundReservationPayment.run(
      payment: reservation.payment
    )

    errors.merge!(call.errors) if call.errors.any? || call.invalid?
  end
end
