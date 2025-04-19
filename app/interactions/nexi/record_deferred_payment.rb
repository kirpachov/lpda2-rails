# frozen_string_literal: true

module Nexi
  # Given a deferred payment ("Autorizzazione"), will actually charge the user
  # Usage:
  # Nexi::RecordDeferredPayment.run!(payment: ReservationPayment.last)
  class RecordDeferredPayment < ActiveInteraction::Base
    # ################################
    # Inputs
    # ################################
    record :payment, class: ReservationPayment

    string :apiKey, default: lambda {
      Config.nexi_alias_merchant || raise("missing nexi_alias_merchant. update your credentials.")
    }

    # ################################
    # Validators
    # ################################
    validate do
      errors.add(:payment, "must be a ReservationPayment") unless payment.is_a?(ReservationPayment)
      errors.add(:payment, "must be deferred") unless payment.deferred?
      errors.add(:payment, "must be authorized. got #{payment.status.inspect}") unless payment.authorized?
      errors.add(:payment, "must have a reservation") if payment.reservation.blank?
    end

    # ################################
    # Logic
    # ################################
    attr_reader :client

    def execute
      @client = Client.run(
        params:,
        content_type: "application/json",
        path: Config.nexi_record_deferred_path,
        request_purpose: "record_deferred_payment",
        request_record: payment,

        mac_part: "apiKey=#{params[:apiKey]}codiceTransazione=#{params[:codiceTransazione]}divisa=#{params[:divisa]}importo=#{params[:importo]}timeStamp=#{params[:timeStamp]}",
      )

      errors.merge!(@client.errors)

      validate_response if errors.empty?

      return false if errors.any? || invalid?

      client.json
    end

    def params
      @params ||= {
        apiKey:,
        codiceTransazione: payment.external_id,
        importo: (payment.value * 100).to_i.to_s,
        divisa: "978", # divisa 978 => EUR, the only supported rn
        timeStamp: Time.zone.now.to_i * 1000,
      }
    end

    def validate_response
      e = []
      e << "is blank" if client.json.blank? && client.html.blank?
      e << "is not a hash" if e.empty? && !client.json.is_a?(Hash)

      if client.json.is_a?(Hash) && client.json["esito"].to_s.downcase != "ok"
        e << "esito is not ok. got #{client.json["esito"]}"
        Rails.logger.error("Nexi::RecordDeferredPayment: #{client.json.inspect} per pagamento #{payment.id}")
      end

      errors.add(:client, "invalid response #{client.json.inspect}: #{e.join(", ")}") if e.any?
    end
  end
end
