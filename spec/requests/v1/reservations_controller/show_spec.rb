# frozen_string_literal: true

require "rails_helper"

RSpec.describe "GET /v1/reservations/:secret" do
  def req(secret = reservation.secret, params: default_params)
    get "/v1/reservations/#{secret}", params:
  end

  let(:default_params) { {} }

  let(:reservation) { create(:reservation) }
  let(:payment) { create(:reservation_payment, :stripe_authorization, status: "todo", reservation:) }

  before do
    stub_stripe_backend(
      responses: {
        get_checkout_session: StubStripeBackendHelper::STRIPE_RESPONSES[:checkout_session_retrieve_success_authorized]
      }
    )
  end

  context "normally should not need stripe APIs" do
    it { expect { req }.not_to(change(Log::StripeEvent, :count)) }
    it { expect(req).to eq(200) }
    it { expect { req }.not_to(change { reservation.reload.as_json }) }
    it { expect { req }.not_to(change { payment.reload.as_json }) }
  end

  context "when providing ?reload_payment=true" do
    let(:default_params) { { reload_payment: true } }
    let(:payment) { create(:reservation_payment, :stripe_authorization, status: "todo", reservation:) }

    it { expect(req).to eq(200) }
    # it { expect { req }.to(change(Log::StripeEvent, :count)) }
    it { expect { req }.not_to(change { reservation.reload.as_json }) }
    it { expect { req }.to(change { payment.reload.status }.from("todo").to("authorized")) }
  end

  context "when providing ?reload_payment=true" do
    let(:default_params) { { reload_payment: true } }
    let(:payment) { create(:reservation_payment, :stripe_payment, status: "todo", reservation:) }

    before do
      stub_stripe_backend(
        responses: {
          get_checkout_session: StubStripeBackendHelper::STRIPE_RESPONSES[:checkout_session_retrieve_success_complete]
        }
      )
    end

    it { expect(req).to eq(200) }
    # it { expect { req }.to(change(Log::StripeEvent, :count)) }
    it { expect { req }.not_to(change { reservation.reload.as_json }) }
    it { expect { req }.to(change { payment.reload.status }.from("todo").to("paid")) }
  end
end
