# frozen_string_literal: true

module Nexi
  # Nexi::Client will:
  # - send requests to Nexi API's
  # - manage authentication
  # - track http request and response
  class Client < ActiveInteraction::Base
    # Mandatory params
    object :params, class: Hash
    string :path
    string :request_purpose # Why this request is being made?
    string :mac_part # partial mac. Will append secret key before sending request.

    # Optional params - use them to customize behaviour
    interface :request_record, methods: %w[id persisted? update], default: nil # Object to associate to http request
    string :http_verb, default: "post"
    object :headers, class: Hash, default: {}
    string :url, default: -> { Config.nexi_api_url }

    string :mac_key, default: -> { Config.nexi_mac_key || raise("missing nexi_mac_key. update your credentials.") }
    string :alias_merchant, default: lambda {
                                       Config.nexi_alias_merchant || raise("missing nexi_alias_merchant. update your credentials.")
                                     }

    string :content_type, default: "application/x-www-form-urlencoded"

    validates_presence_of :path, :http_verb
    validates :content_type, inclusion: { in: %w[application/x-www-form-urlencoded application/json] }

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

    def final_mac
      @final_mac ||= Digest::SHA1.hexdigest("#{mac_part}#{mac_key}")
    end

    def response
      return @response if defined?(@response)

      @request_started_at = Time.zone.now

      @response = send_request

      @request_ended_at = Time.zone.now

      @response
    end

    def request_url
      @request_url ||= "#{url}/#{path}"
    end

    def connection
      @connection ||= Faraday.new(url: request_url) do |f|
        if content_type == "application/x-www-form-urlencoded"
          f.request :url_encoded
          f.adapter Faraday.default_adapter
        end
      end
    end

    def request_params
      params.merge(
        mac: final_mac
      ).merge(
        # When content type is application/json, the alias merchant key is apiKey.
        # Thanks Nexi for this inconsistency.
        content_type == "application/json" ? { apiKey: alias_merchant } : { alias: alias_merchant }
      )
    end

    def send_request
      @response = connection.post do |req|
        if content_type.to_s == "application/json"
          req.headers[:content_type] = "application/json"
          req.body = JSON.generate(request_params)
        else
          req.body = request_params
        end
      end
    rescue Faraday::ConnectionFailed => e
      errors.add(:base, e.to_s)
      nil
    end

    def json
      return {} unless response_json?

      @json ||= Oj.load(@response.body)
    rescue Oj::ParseError => e
      Rails.logger.error("Failed to parse response body: #{@response.body}: #{e}")
      {}
    end

    def html
      return "" unless response_html?

      @html ||= @response.body
    end

    def validate_response
      if response.status > 299
        errors.add(:base, "something went wrong during the request, got status #{response.status}")
      end

      if @response.body.include?("<title>Errore</title>")
        Rails.logger.error("Nexi error: #{@response.inspect}\n\nBody: #{@response.body}")
        errors.add(:base, "something went wrong during the request, got html error")
      end

      if response.body.to_s.gsub(/\s+/, "").start_with?("<!--") && response.body.gsub(/<!--.*?-->/m, "").blank?
        errors.add(:base, "empty html response")
      end

      json_str = json.stringify_keys { |k| k.to_s.downcase }

      %w[error err failure fail].each do |error|
        ["", "-", ".", "_"].each do |separator|
          ["", "msg", "message", "spec", "code"].each do |spec|
            key = "#{error}#{separator}#{spec}"
            errors.add(:base, "error, got #{key.inspect}: #{json_str[key].inspect}") if json_str[key].present?
          end
        end
      end
    end

    def response_json?
      response.body.valid_json?
      # || response.headers.transform_keys { |k| k.to_s.downcase }["content-type"].to_s.include?("application/json")
    end

    def response_html?
      return true if response.body.include?("<!DOCTYPE html>")

      response.headers.transform_keys { |k| k.to_s.downcase }["content-type"].to_s.include?("text/html")
    end

    def create_http_request
      @http_request = HttpRequest.create(
        request_body: request_params,
        response_body: json,
        html_response: html,
        url:,
        http_code: response.status,
        http_method: http_verb,
        started_at: @request_started_at,
        ended_at: @request_ended_at,
        purpose: request_purpose,
        record: request_record&.persisted? ? request_record : nil
      )

      errors.merge!(@http_request.errors)

      @http_request
    end
  end
end
