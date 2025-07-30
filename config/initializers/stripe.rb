# frozen_string_literal: true

Stripe.api_key = Config.stripe_api_key

Stripe.api_version = "2025-05-28.basil"

Stripe.log_level = case Rails.env.to_s
                   when "development"
                     Stripe::LEVEL_DEBUG
                   when "test"
                     Stripe::LEVEL_ERROR
                   else
                     Stripe::LEVEL_INFO
                   end

# https://github.com/stripe/stripe-ruby?tab=readme-ov-file#telemetry
Stripe.enable_telemetry = true

Stripe::Instrumentation.subscribe(:request_begin) do |event|
  Rails.logger.debug { "Stripe request begin: #{event.as_json}" }
end

Stripe::Instrumentation.subscribe(:request_end) do |event|
  Rails.logger.debug { "Stripe request end: #{event.as_json}" }

  Log::StripeEvent.create!(
    event.as_json.symbolize_keys.slice(*Log::StripeEvent.column_names.map(&:to_sym)).merge(
      raw: event.as_json
    )
  )
end
