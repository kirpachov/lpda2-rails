# frozen_string_literal: true

module Nexi
  # Nexi::Client will:
  # - send requests to Nexi API's
  # - manage authentication
  # - track http request and response
  class Client < ActiveInteraction::Base
    # Mandatory param
    object :params, class: Hash
    string :path
    string :request_purpose # Why this request is being made?

    # Optional params - use them to customize behaviour
    interface :request_record, methods: %w[id persisted? update], default: nil # Object to associate to http request
    string :http_verb, default: "post"
    object :headers, class: Hash, default: {}
    string :correlation_id, default: -> { SecureRandom.uuid }
    string :url, default: -> { Config.nexi_api_url }
    string :content_type, default: "application/json"
    string :api_key, default: -> { Config.nexi_api_key }

    validates_presence_of :path, :http_verb, :correlation_id, :api_key

    validate do
      errors.add(:params, "must be hash. got #{params.class}") if params.present? && !params.is_a?(Hash)
    end

    attr_reader :http_request

    def execute
      response
      return if errors.any?

      create_http_request

      validate_response

      @http_request.update(record: request_record) if request_record.present? && errors.empty?

      @response
    end

    def connection
      @connection ||= Faraday.new(
        url: url,
        headers: headers.stringify_keys.merge(
          "Content-Type" => content_type,
          "X-Api-Key" => api_key,
          "Correlation-Id" => correlation_id
        )
      )
    end

    def response
      return @response if defined?(@response)

      @request_started_at = Time.zone.now

      @response = send_request

      @request_ended_at = Time.zone.now

      @response
    end

    def send_request
      return connection.post(path) { |req| req.body = params.to_json } if http_verb == "post"

      raise "unknown http verb #{http_verb}"
    rescue Faraday::ConnectionFailed => e
      errors.add(:base, e.to_s)
      nil
    end

    def json
      @json ||= Oj.load(@response.body)
    rescue Oj::ParseError => e
      Rails.logger.error("Failed to parse response body: #{@response.body}: #{e}")
      {}
    end

    def validate_response
      if response.status > 299
        errors.add(:base, "something went wrong during the request, got status #{response.status}")
      end

      json_str = json.stringify_keys { |k| k.to_s.downcase }

      %w[error err failure fail].each do |error|
        ["", "-", ".", "_"].each do |separator|
          ["", "msg", "message", "spec", "code"].each do |spec|
            key = "#{error}#{separator}#{spec}"
            if json_str[key].present?
              errors.add(:base, "error, got #{key.inspect}: #{json_str[key].inspect}")
            end
          end
        end
      end
    end

    def response_json?
      response.headers.transform_keys { |k| k.to_s.downcase }["content-type"].to_s.include?("application/json")
    end

    def create_http_request
      @http_request = HttpRequest.create!(
        request_body: params,
        response_body: json,
        url: url,
        http_code: response.status,
        http_method: http_verb,
        started_at: @request_started_at,
        ended_at: @request_ended_at,
        purpose: request_purpose,
        record: request_record.persisted? ? request_record : nil
      )
    end
  end
end
