# frozen_string_literal: true

class ReservationMailer < ApplicationMailer
  layout 'public'

  # reload!; ReservationMailer.confirmation(reservation: Reservation.last).deliver_now
  def confirmation
    raise "Expected params[:reservation] to be a Reservation but got #{params[:reservation].class}" unless params[:reservation].is_a?(Reservation)
    @reservation = params[:reservation]
    raise "Reservation does not have an email" if @reservation.email.blank?

    @cancel_url = URI.join(
      Config.hash[:frontend_base_url],
      Mustache.render(Config.hash[:cancel_reservation_path], { secret: @reservation.secret })
    ).to_s

    # email_address_with_name(@user.email, @user.name)
    mail(
      to: @reservation.email,
      subject: (@title = I18n.t('reservation_mailer.confirmation.subject', fullname: @reservation.fullname))
    )
  end
end
