# frozen_string_literal: true

require "rails_helper"

RSpec.shared_examples "when successful run CreateReservationPayment interaction" do
  it { expect(run).to be_valid }
  it { expect { run }.to(change(ReservationPayment, :count).by(1)) }
end

RSpec.describe CreateReservationPayment, type: :interaction do
  let(:reservation) { create(:reservation) }
  let(:amount) { 100.0 }
  let(:deferred) { false }

  let(:default_params) do
    {
      reservation:,
      amount:,
      deferred:
    }
  end

  let(:run) { described_class.run(default_params) }

  context "when payment gateway is stripe" do
    before do
      stub_stripe_backend
    end

    it_behaves_like "when successful run CreateReservationPayment interaction"
    it { expect { run }.to(change(Log::StripeEvent, :count).by(1)) }

    it do
      expect(run.result.external_id).to be_present.and(
        eq(Oj.load(StubStripeBackendHelper::STRIPE_RESPONSES[:checkout_session_create_setup_success])["id"])
      ).and(eq(ReservationPayment.last.external_id))
    end

    # it do
    #   expect(run.result.external_object.symbolize_keys).to be_present.and(
    #     eq(Oj.load(StubStripeBackendHelper::STRIPE_RESPONSES[:checkout_session_create_setup_success]).symbolize_keys)
    #   ).and(eq(ReservationPayment.last.external_object.symbolize_keys))
    # end
  end
end
