# frozen_string_literal: true

module StubStripeBackendHelper
  # Valid Checkout session id for testing purposes
  CS_ID = "cs_test_a1cnlIiQKwrVwD1CTXfJIdLHfQYUhTnxkJcm0SgWY4cyhipVv6WMD7cKqb"

  CUSTOMER_ID = "cus_SmeDlK0pWWOW4C"

  PAYMENT_METHOD_ID = "pm_1RrKKtP3aO71SSMBUbfGN7vG"

  PAYMENT_INTENT_ID = "pi_3RrKLlP3aO71SSMB0hJHU60n"

  EVENT_ID = "evt_3RrTk5P3aO71SSMB1bRozwIW"

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

    payment_intent_create_success: File.read(
      Rails.root.join("spec/fixtures/stripe/payment_intent/create_success.json")
    ),

    payment_methods_list_success: File.read(
      Rails.root.join("spec/fixtures/stripe/payment_methods/list_success.json")
    ),

    retreive_event_success: File.read(
      Rails.root.join("spec/fixtures/stripe/events/receive_event_payment_intent.json")
    )
  }.freeze

  ENDPOINT_RESPONSES_BODY = {
    create_payment_intent: StubStripeBackendHelper::STRIPE_RESPONSES[:payment_intent_create_success],
    list_customers_payment_methods: StubStripeBackendHelper::STRIPE_RESPONSES[:payment_methods_list_success],
    create_checkout_session: StubStripeBackendHelper::STRIPE_RESPONSES[:checkout_session_create_setup_success],
    get_checkout_session: StubStripeBackendHelper::STRIPE_RESPONSES[:checkout_session_retrieve_success_open],
    retreive_event: STRIPE_RESPONSES[:retreive_event_success]
  }.freeze

  def stub_stripe_backend(configs = {})
    allow(Config).to receive(:default_payment_gateway).and_return("stripe")

    configs ||= {}

    # if configs[:endpoints]
    #   configs[:endpoints].each do |endpoint|
    #     stub_request(endpoint[:method], endpoint[:url]).to_return do |_request|
    #       {
    #         status: 200,
    #         headers: { "Content-Type" => "application/json" },
    #         body: endpoint[:response_body]
    #       }
    #     end
    #   end
    # end

    response_body = ENDPOINT_RESPONSES_BODY.merge(configs[:responses] || {})

    stub_request(:get, "https://api.stripe.com/v1/events/#{StubStripeBackendHelper::EVENT_ID}").to_return do |_request|
      {
        status: 200,
        headers: { "Content-Type" => "application/json" },
        body: response_body[:retreive_event]
      }
    end

    stub_request(:post, "https://api.stripe.com/v1/payment_intents").to_return do |_request|
      {
        status: 200,
        headers: { "Content-Type" => "application/json" },
        body: response_body[:create_payment_intent]
      }
    end

    # ?customer=cus_SmeDlK0pWWOW4C
    stub_request(:get, "https://api.stripe.com/v1/payment_methods?customer=#{CUSTOMER_ID}").to_return do |_request|
      {
        status: 200,
        headers: { "Content-Type" => "application/json" },
        body: response_body[:list_customers_payment_methods]
      }
    end

    # Create session
    stub_request(:post, "https://api.stripe.com/v1/checkout/sessions").to_return do |_request|
      {
        status: 200,
        headers: { "Content-Type" => "application/json" },
        body: response_body[:create_checkout_session]
      }
    end

    # Retrieve session
    stub_request(:get, "https://api.stripe.com/v1/checkout/sessions/#{CS_ID}").to_return do |_request|
      {
        status: 200,
        headers: { "Content-Type" => "application/json" },
        body: response_body[:get_checkout_session]
      }
    end
  end
end
