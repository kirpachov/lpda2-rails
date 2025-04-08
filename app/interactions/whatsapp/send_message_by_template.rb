# frozen_string_literal: true

module Whatsapp
  # Used by
  # - Whatsapp::SendReservationConfirmation
  class SendMessageByTemplate < ActiveInteraction::Base
    # International phone number
    # Example: 393515590063
    string :to
    string :request_purpose
    string :template_name
    array :components

    string :phone_number_id, default: -> { Config.whatsapp_phone_number_id.to_s }

    validates_presence_of :phone_number_id

    def execute
      compose(
        Client,
        path: "/#{phone_number_id}/messages",
        request_purpose:,
        params: {
          messaging_product: "whatsapp",
          to:,
          type: "template",
          template: {
            name: template_name,
            components:,
            language: {
              code: "en"
            }
          }
        }
      )
    end
  end
end
