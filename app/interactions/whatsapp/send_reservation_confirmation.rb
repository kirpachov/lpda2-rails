# frozen_string_literal: true

module Whatsapp
  # Try this in console:
  # reload!; Whatsapp::SendReservationConfirmation.run!(reservation: Reservation.last)
  class SendReservationConfirmation < ActiveInteraction::Base
    object :reservation, class: Reservation

    delegate :phone, :fullname, :datetime, :people, :secret, to: :reservation

    string :template_name, default: -> { Config.whatsapp_reservation_confirmation_template_name }

    validates_presence_of :template_name, :phone, :fullname, :datetime, :people, :secret

    def execute
      compose(
        SendMessageByTemplate,
        to: phone,
        request_purpose: "reservation_confirmation",
        template_name:,
        components:
      )
    end

    def date
      @date ||= ignore_dst(datetime).strftime("%d %B %Y")
    end

    def time
      @time ||= ignore_dst(datetime.in_time_zone(Config.restaurant_location_time_zone)).strftime("%k:%M")
    end

    def additional_message
      return @additional_message if defined?(@additional_message)

      if reservation.payment.present?
        @additional_message = I18n.t("reservation_mailer.payment_is_required", url: reservation.payment.hpp_url)
      end

      @additional_message ||= "Hope to see you soon!"
    end

    def components
      [
        {
          type: "body",
          parameters: [
            {
              type: "text",
              parameter_name: "fullname",
              text: fullname
            },
            {
              type: "text",
              parameter_name: "date",
              text: date
            },
            {
              type: "text",
              parameter_name: "time",
              text: time
            },
            {
              type: "text",
              parameter_name: "people",
              text: people
            },
            {
              type: "text",
              parameter_name: "additional_message",
              text: additional_message
            },
          ]
        },
        {
          type: "button",
          sub_type: "url",
          index: "0",
          parameters: [
            {
              type: "text",
              text: secret
            },
          ]
        },
        {
          type: "header",
          parameters: [
            {
              type: "LOCATION",
              location: {
                # TODO coordinates not accurate
                # TODO address should be by configs
                latitude: 45.437188,
                longitude: 12.3338943,
                name: "La Porta d'Acqua",
                address: "Riva del Vin, 1097, 30125 Venezia VE"
              }
            }
          ]
        }
      ]
    end
  end
end
