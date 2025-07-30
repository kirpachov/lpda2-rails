# frozen_string_literal: true

module StubStripeBackendHelper
  STRIPE_RESPONSES = {
    checkout_session_create_setup_success: File.read(
      Rails.root.join("spec/fixtures/stripe/checkout_session/create_setup_success.json")
    )
  }.freeze

  def stub_stripe_backend
    allow(Config).to receive(:default_payment_gateway).and_return("stripe")

    stub_request(:post, "https://api.stripe.com/v1/checkout/sessions").to_return do |_request|

      {
        status: 200,
        headers: { "Content-Type" => "application/json" },
        body: STRIPE_RESPONSES[:checkout_session_create_setup_success]
      }
    end
  end
end
