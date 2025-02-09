# frozen_string_literal: true

class ReservationMailer < ApplicationMailer
  before_action :validate_reservation
  before_action :show_reservation_url
  before_action :set_locale_by_reservation
  layout "public"

  # reload!; ReservationMailer.confirmation(reservation: Reservation.last).deliver_now
  def confirmation
    attachments["invite.ics"] = ReservationIcs.run!(reservation:)

    mail(
      to: reservation_to,
      subject: (@title = I18n.t("reservation_mailer.confirmation.subject", fullname: reservation.fullname))
    )
  end

  def cancelled
    mail(
      to: reservation_to,
      subject: (@title = I18n.t("reservation_mailer.cancelled.subject", fullname: reservation.fullname))
    )
  end

  def reminder
    mail(
      to: reservation_to,
      subject: (@title = I18n.t("reservation_mailer.reminder.subject", fullname: reservation.fullname))
    )
  end

  def payment_received
    mail(
      to: reservation_to,
      subject: (@title = I18n.t("reservation_mailer.payment_received.subject", fullname: reservation.fullname))
    )
  end

  def remind_payment
    mail(
      to: reservation_to,
      subject: (@title = I18n.t("reservation_mailer.remind_payment.subject", fullname: reservation.fullname))
    )
  end

  private

  def detect_record
    reservation || super
  end

  def detect_locale
    reservation&.lang || super
  end

  def set_locale_by_reservation
    return if reservation.lang.blank?

    I18n.locale = reservation.lang
  end

  def show_reservation_url
    @show_reservation_url ||= URI.join(
      Config.hash[:frontend_base_url],
      Mustache.render(Config.hash[:show_reservation_url],
                      { locale: reservation.lang || I18n.default_locale, secret: reservation.secret })
    ).to_s
  end

  def reservation_to
    return reservation.email if reservation.fullname.blank?

    email_address_with_name(reservation.email, reservation.fullname)
  end

  def reservation
    return @reservation if defined?(@reservation)
    return if params.blank?

    @reservation = params[:reservation] if params[:reservation].is_a?(Reservation)
    @reservation ||= Reservation.find_by(id: params[:reservation_id]) if params[:reservation_id].to_i.positive?

    @reservation
  end

  def validate_reservation
    unless reservation.is_a?(Reservation)
      raise ArgumentError, "Expected params[:reservation] to be a Reservation but got #{reservation.class}"
    end

    raise ArgumentError, "Reservation does not have an email" if reservation.email.blank?
  end
end
