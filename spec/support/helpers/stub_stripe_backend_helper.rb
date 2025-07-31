# frozen_string_literal: true

module StubStripeBackendHelper
  # Valid Checkout session id for testing purposes
  CS_ID = "cs_test_a1cnlIiQKwrVwD1CTXfJIdLHfQYUhTnxkJcm0SgWY4cyhipVv6WMD7cKqb"

  STRIPE_RESPONSES = {
    checkout_session_create_setup_success: File.read(
      Rails.root.join("spec/fixtures/stripe/checkout_session/create_setup_success.json")
    ),

    # Checkout session, calling #retrieve method for its id, and it has status "open"
    checkout_session_retrieve_success_open: File.read(
      Rails.root.join("spec/fixtures/stripe/checkout_session/retrieve_success_open.json")
    ),

    # Checkout session, calling #retrieve method for its id, and it has status "complete"
    checkout_session_retrieve_success_complete: File.read(
      Rails.root.join("spec/fixtures/stripe/checkout_session/retrieve_success_complete.json")
    ),

    # Checkout session, calling #retrieve method for its id, and it has status "expired"
    checkout_session_retrieve_success_expired: File.read(
      Rails.root.join("spec/fixtures/stripe/checkout_session/retrieve_success_expired.json")
    ),
  }.freeze

  DEFAULT_ENDPOINTS = [
    {
      method: :post,
      url: "https://api.stripe.com/v1/checkout/sessions",
      response_body: STRIPE_RESPONSES[:checkout_session_create_setup_success]
    },
    {
      method: :get,
      url: "https://api.stripe.com/v1/checkout/sessions/#{CS_ID}",
      response_body: STRIPE_RESPONSES[:checkout_session_retrieve_success_open]
    }
  ].freeze

  def stub_stripe_backend(configs = {})
    configs ||= {}
    allow(Config).to receive(:default_payment_gateway).and_return("stripe")

    configs[:endpoints] ||= configs[:endpoint] ? [configs[:endpoint]] : DEFAULT_ENDPOINTS

    configs[:endpoints].each do |endpoint|
      stub_request(endpoint[:method], endpoint[:url]).to_return do |_request|
        {
          status: 200,
          headers: { "Content-Type" => "application/json" },
          body: endpoint[:response_body]
        }
      end
    end

    # Create session
    # stub_request(:post, "https://api.stripe.com/v1/checkout/sessions").to_return do |_request|
    #   {
    #     status: 200,
    #     headers: { "Content-Type" => "application/json" },
    #     body: STRIPE_RESPONSES[:checkout_session_create_setup_success]
    #   }
    # end

    # Retrieve session
    # stub_request(:get, "https://api.stripe.com/v1/checkout/sessions/#{CS_ID}").to_return do |_request|
    #   {
    #     status: 200,
    #     headers: { "Content-Type" => "application/json" },
    #     body: STRIPE_RESPONSES[:checkout_session_retrieve_success_open]
    #   }
    # end
  end
end
