# frozen_string_literal: true

module Nexi
  # HPP stands for "Hosted Payment Page"
  # Call Nexi api's at "order_hpp" endpoint.
  # Nexi docs at:
  # https://developer.nexi.it/it/api/post-orders-hpp
  # Successful response will look like this:
  # {"hostedPage"=>"https://xpaysandbox.nexigroup.com/monetaweb/page/hosted/2/html?paymentid=193469235156442659", "securityToken"=>"35e06eae8cc241718478dfdd82eca9d8", "warnings"=>[]}
  class OrderHpp < ActiveInteraction::Base
    float :amount
    string :language
    string :order_id
    string :result_url
    string :cancel_url

    # Why this order is being made?
    string :request_purpose
    interface :request_record, methods: %w[id persisted? update], default: nil # Object to associate to http request

    string :currency, default: "EUR"

    attr_reader :client

    def execute
      @client = Client.run(
        params:,
        path: Config.nexi_hpp_payment_path,
        request_purpose:,
        request_record: request_record
      )

      errors.merge!(@client.errors)

      validate_response if errors.empty?

      return false if errors.any? || invalid?

      client.json
    end

    def params
      @params ||= {
        order: {
          orderId: order_id,
          amount: (amount * 100).to_i.to_s,
          currency:
        },
        paymentSession: {
          amount: (amount * 100).to_i.to_s,

          # ISO 639-2.
          language:,

          resultUrl: result_url,

          cancelUrl: cancel_url
        }
      }
    end

    def validate_response
      e = []
      e << "is blank" if client.json.blank?
      e << "is not a hash" if e.empty? && !client.json.is_a?(Hash)
      e << "field 'hostedPage' is blank" if e.empty? && client.json["hostedPage"].blank?
      e << "field 'securityToken' is blank" if e.empty? && client.json["securityToken"].blank?

      errors.add(:client, "invalid response #{client.json.inspect}: #{e.join(", ")}") if e.any?
    end
  end
end
