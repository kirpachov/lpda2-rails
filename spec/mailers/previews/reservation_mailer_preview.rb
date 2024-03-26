# frozen_string_literal: true

class ReservationMailerPreview < ActionMailer::Preview
  # http://localhost:3050/rails/mailers/reservation_mailer/confirmation.html?locale=en
  def confirmation(reservation: Reservation.last)
    ReservationMailer.confirmation(reservation:)
  end
end
