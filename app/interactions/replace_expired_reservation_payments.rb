# frozen_string_literal: true

# Will find reservation payment that are expired,
# for future reservations, and replace the expired links with valid ones.
class ReplaceExpiredReservationPayments < ActiveInteraction::Base
  def execute
    reservations.find_each do |reservation|
      ReplaceReservationPayment.run!(reservation:)
    end
  end

  def reservations
    @reservations ||= Reservation.visible.next.where(status: %w[active arrived]).where(
      id: ReservationPayment.where(status: :expired).select(:reservation_id)
    )
  end
end
