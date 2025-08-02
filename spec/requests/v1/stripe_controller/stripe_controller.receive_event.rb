# frozen_string_literal: true

require "rails_helper"

RSpec.context "POST /v1/stripe/receive_event", type: :request do
  let(:reservation) { create(:reservation) }
  let!(:payment) { create(:reservation_payment, :stripe_authorization, status: "todo", reservation:) }

  let(:default_params) do
    {
      id: StubStripeBackendHelper::EVENT_ID
    }
  end

  before do
    stub_stripe_backend(
      responses: {
        get_checkout_session: StubStripeBackendHelper::STRIPE_RESPONSES[:checkout_session_retrieve_success_complete]
      }
    )
  end

  def req(params: default_params)
    post "/v1/stripe/receive_event", params:
  end

  it do
    req
    expect(response).to have_http_status(:ok)
  end

  it do
    expect { req }.to(change { payment.reload.status }.from("todo").to("authorized"))
  end
end
