# frozen_string_literal: true

# Customer tries to cancel a reservation.
# Will do refund and send confirmation email.
class PublicCancelReservation < ActiveInteraction::Base
  record :reservation, class: Reservation

  validate :reservation_is_active
  validate :reservation_datetime_is_next
  validate :reservation_datetime_is_not_too_close

  attr_reader :refund

  def execute
    reservation.cancelled!

    errors.merge!(reservation.errors) if reservation.errors.any? || reservation.invalid?

    return reservation if errors.any?

    refund_reservation

    ReservationsChannel.notify_cancellation(reservation_id: reservation.id)

    notify_customer

    reservation.reload
  end

  def notify_customer
    return if reservation.email.blank?

    ReservationMailer.with(reservation_id: reservation.id).cancelled.deliver_later
  end

  def refund_reservation
    return unless reservation.payment&.paid?
    return unless Setting[:nexi_auto_refund_cancelled_reservations] == "true"

    @refund = RefundReservationPayment.run(reservation:)
    errors.merge!(@refund.errors) if @refund.errors.any? || @refund.invalid?
  end

  def reservation_is_active
    return if reservation.active?

    errors.add(:reservation, :not_active)
  end

  def reservation_datetime_is_next
    return if reservation.datetime > Time.zone.now

    errors.add(:reservation, :not_next)
  end

  def reservation_datetime_is_not_too_close
    return unless %w[paid authorized].include?(reservation.payment&.status)

    return if Setting[:reservation_min_hours_advance_cancel].blank?
    return if reservation.datetime > Setting[:reservation_min_hours_advance_cancel].to_f.hours.from_now

    errors.add(:reservation, :too_close_to_date)
  end
end
