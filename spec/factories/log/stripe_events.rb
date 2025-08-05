# frozen_string_literal: true

FactoryBot.define do
  factory :log_stripe_event, class: "Log::StripeEvent" do
    duration { 1.5 }
    http_status { 200 }
    # method { "post" }
    num_retries { 0 }
    path { "/v1/checkout/sessions" }
    request_id { "req_okreOxWsDayt3u" }
    user_data { {} }
    response_header { {} }
    response_body { {} }
    request_header { {} }
    request_body { {} }
  end
end
