# frozen_string_literal: true

class ReservationMailer < ApplicationMailer
  layout "public"

  # reload!; ReservationMailer.confirmation(reservation: Reservation.last).deliver_now
  def confirmation
    @reservation = params[:reservation] if params[:reservation].is_a?(Reservation)
    @reservation ||= Reservation.find_by(id: params[:reservation_id]) if params[:reservation_id].to_i.positive?

    unless @reservation.is_a?(Reservation)
      raise "Expected params[:reservation] to be a Reservation but got #{@reservation.class}"
    end

    raise "Reservation does not have an email" if @reservation.email.blank?

    @cancel_url = URI.join(
      Config.hash[:frontend_base_url],
      Mustache.render(Config.hash[:cancel_reservation_path], { secret: @reservation.secret })
    ).to_s

    mail(
      to: if @reservation.fullname.blank?
            @reservation.email
          else
            email_address_with_name(@reservation.email,
                                    @reservation.fullname)
          end,
      subject: (@title = I18n.t("reservation_mailer.confirmation.subject", fullname: @reservation.fullname))
    )
  end
end
