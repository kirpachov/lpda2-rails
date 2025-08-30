# frozen_string_literal: true

# Will find all Reservations that require payment but is not paid yet,
# and send a reminder email to the user.
class RemindReservationPayments < ActiveInteraction::Base
  def execute
    reservations.find_each do |reservation|
      ReservationMailer.with(reservation_id: reservation.id).remind_payment.deliver_later
    end
  end

  private

  def reservations
    Reservation.visible.next.active.where(id: ids).where.not(email: nil)
  end

  def ids
    @ids ||= ReservationPayment.visible.todo.where(
      created_at: (3.days.ago)..(1.day.ago)
    ).select(:reservation_id)
  end
end
