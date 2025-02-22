# frozen_string_literal: true

module Nexi
  class SimplePayment < ActiveInteraction::Base
    float :amount
    string :language
    string :result_url
    string :cancel_url

    # When true, the payment is not executed immediately.
    # Restaurant will have to manually confirm the payment, in case people don't show up.
    boolean :deferred

    # Why this order is being made?
    string :request_purpose
    interface :request_record, methods: %w[id persisted? update], default: nil # Object to associate to http request

    interface :additional_params, methods: %w[each keys merge], default: {}

    attr_reader :client

    def execute
      @client = Client.run(
        params:,
        path: Config.nexi_simple_payment_path,
        request_purpose:,
        request_record:,
        mac_part:
      )

      errors.merge!(@client.errors)

      validate_response if errors.empty?

      return false if errors.any? || invalid?

      client.json
    end

    def cod_trans
      @cod_trans ||= "PS#{Time.zone.now.strftime("%Y%m%d%H%M%S")}"
    end

    def params
      @params ||= (additional_params || {}).merge(
        importo: (amount * 100).to_i.to_s,
        divisa: "EUR", # The only supported rn
        codTrans: cod_trans,
        url: result_url,
        url_back: cancel_url,
        languageId: language
      ).merge(
        deferred ? { TCONTAB: "D" } : {}
      )
    end

    def mac_part
      base = "codTrans=#{params.dig!(:codTrans)}divisa=#{params.dig!(:divisa)}importo=#{params.dig!(:importo)}"
      return base unless deferred

      "#{base}TCONTAB=D"
    end

    def validate_response
      e = []
      e << "is blank" if client.json.blank? && client.html.blank?
      e << "is not a hash" if e.empty? && !client.json.is_a?(Hash)

      errors.add(:client, "invalid response #{client.json.inspect}: #{e.join(", ")}") if e.any?
    end
  end
end
