# frozen_string_literal: true

# Will format and add Icalendar event information to the email.
class ReservationIcs < ActiveInteraction::Base
  record :reservation, class: Reservation

  def execute
    cal = Icalendar::Calendar.new

    # .in_time_zone(Config.app[:restaurant_location_time_zone])
    event_start = reservation.datetime.utc
    event_end = event_start + 90.minutes

    cal.event do |e|
      e.dtstart = Icalendar::Values::DateTime.new event_start, "tzid" => "UTC"
      e.dtend   = Icalendar::Values::DateTime.new event_end, "tzid" => "UTC"

      e.attendee = ["mailto:#{organization_email}", "mailto:#{reservation.email}"] # one or more email recipients (required)
      e.summary = I18n.t("reservation_mailer.confirmation.subject", fullname: reservation.fullname)
      e.location = address if address.present?
      e.status = "CONFIRMED"
      if organization_email.present?
        e.organizer = Icalendar::Values::CalAddress.new("mailto:#{organization_email}",
                                                        cn: %(La Porta d'Acqua))
      end
    end

    cal.to_ical
  end

  private

  def address
    @address ||= contacts.dig("address", "value")
  end

  def organization_email
    @organization_email ||= contacts.dig("email", "value")
  end

  def contacts
    @contacts ||= Contact.all_hash
  end
end
