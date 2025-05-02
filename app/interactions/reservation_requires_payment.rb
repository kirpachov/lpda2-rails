# frozen_string_literal: true

# Returns a PreorderReservationGroup if the reservation requires payment, nil otherwise.
class ReservationRequiresPayment < ActiveInteraction::Base
  record :reservation

  def execute
    compose(
      DateTimeRequiresPayment,
      date: reservation.datetime.strftime("%Y-%m-%d"),
      time: reservation.datetime.strftime("%H:%M"),
      people: reservation.people
    )
  end
end
