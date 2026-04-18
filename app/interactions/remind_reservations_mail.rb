# frozen_string_literal: true

# Send reminder for all next reservations
class RemindReservationsMail < ActiveInteraction::Base
  def execute
    elegible.each do |reservation|
      process_reservation(reservation)
    end
  end

  def process_reservation(reservation)
    ReservationMailer.with(reservation_id: reservation.id).reminder.deliver_now
    sleep(1) # Avoid sending too many emails at the same time
  end

  def elegible
    @elegible ||= Reservation.active.next.where(
      "datetime BETWEEN ? AND ?", Time.zone.now, 1.day.from_now
    ).where.not(
      # Exclude reservations that did not pay as this
      # would create confusion if the reservations is confirmed or not
      # (until they don't pay the reservation is not confirmed.)
      id: ReservationPayment.todo.select(:reservation_id)
    ).where.not(
      # Exclude reservations that already received a reminder email
      id: Log::DeliveredEmail.where(
        record_type: "Reservation",
        controller_path: "reservation_mailer",
        action_name: "reminder"
      ).select(:record_id)
    ).where.not(
      email: [nil, "", " "]
    )
  end
end
