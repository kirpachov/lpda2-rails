# frozen_string_literal: true

class ReservationMailerPreview < ActionMailer::Preview
  # http://localhost:3050/rails/mailers/reservation_mailer/confirmation.html?locale=en
  def confirmation(reservation: Reservation.last)
    ReservationMailer.with(reservation.confirmation_email_params).confirmation
  end

  # http://localhost:3050/rails/mailers/reservation_mailer/payment_success.txt?locale=it
  def payment_success(reservation: ReservationPayment.paid.last.reservation)
    ReservationMailer.with(reservation_id: reservation.id).payment_success
  end

  # http://localhost:3050/rails/mailers/reservation_mailer/payment_required_to_confirm.txt?locale=it
  def payment_required_to_confirm(reservation: ReservationPayment.last.reservation)
    ReservationMailer.with(reservation_id: reservation.id).payment_required_to_confirm
  end
end
