# frozen_string_literal: true

require "rails_helper"

RSpec.describe FetchReservationPaymentStatus, type: :interaction do
  subject(:call) do
    stub
    described_class.run(reservation_payment:)
  end

  let(:response_file) { Rails.root.join("spec/fixtures/nexi-order-status-success.json") }
  let(:reservation_payment_external_id) { "PO123321" }
  let!(:reservation) { create(:reservation) }
  let(:preorder_type) { :html_nexi_authorization }
  let!(:reservation_payment) do
    create(:reservation_payment, preorder_type:, reservation:, external_id: reservation_payment_external_id)
  end

  let(:stub_response) do
    {
      status: 200,
      body: File.read(
        response_file
      ).gsub("CODICE_TRANSAZIONE", reservation_payment_external_id)
    }
  end

  let(:stub) do
    stub_request(:post,
                 "#{Config.app.dig!(:nexi_api_url)}/#{Config.app.dig!(:nexi_order_status_path)}").to_return do |_request|
      stub_response
    end
  end

  include_context TESTS_OPTIMIZATIONS_CONTEXT

  it { expect(reservation_payment).to be_valid }
  it { expect(call.errors).to be_empty }

  context "when payment_gateway is stripe" do
    let(:stub) do
      stub_stripe_backend
    end

    let(:preorder_type) { :stripe_payment }
    let(:reservation_payment_external_id) { StubStripeBackendHelper::CS_ID }

    context "when reservation_payment has status 'todo' and stripe session has status 'complete' for stripe_payment" do
      let(:preorder_type) { :stripe_payment }
      let(:stub) do
        stub_request(:get,
                     "https://api.stripe.com/v1/checkout/sessions/#{StubStripeBackendHelper::CS_ID}").to_return do |_request|
          {
            status: 200,
            headers: { "Content-Type" => "application/json" },
            body: StubStripeBackendHelper::STRIPE_RESPONSES[:checkout_session_retrieve_success_complete]
          }
        end
      end

      before do
        reservation_payment.update!(status: "todo")
      end

      it { expect(call).to be_valid }
      it { expect(call.errors).to be_empty }
      it { expect { call }.to(change { reservation_payment.reload.status }.from("todo").to("paid")) }
      it { expect { call }.to(change { Log::StripeEvent.count }.by(1)) }
    end

    context "when reservation_payment has status 'todo' and stripe session has status 'complete' for stripe_authorization" do
      let(:preorder_type) { :stripe_authorization }
      let(:stub) do
        stub_request(:get,
                     "https://api.stripe.com/v1/checkout/sessions/#{StubStripeBackendHelper::CS_ID}").to_return do |_request|
          {
            status: 200,
            headers: { "Content-Type" => "application/json" },
            body: StubStripeBackendHelper::STRIPE_RESPONSES[:checkout_session_retrieve_success_complete]
          }
        end
      end

      before do
        reservation_payment.update!(status: "todo")
      end

      it { expect(call).to be_valid }
      it { expect(call.errors).to be_empty }
      it { expect { call }.to(change { reservation_payment.reload.status }.from("todo").to("authorized")) }
      it { expect { call }.to(change { Log::StripeEvent.count }.by(1)) }
    end

    context "when reservation_payment has status 'paid' and stripe session has status 'complete' for stripe_payment" do
      let(:preorder_type) { :stripe_payment }
      let(:stub) do
        stub_request(:get,
                     "https://api.stripe.com/v1/checkout/sessions/#{StubStripeBackendHelper::CS_ID}").to_return do |_request|
          {
            status: 200,
            headers: { "Content-Type" => "application/json" },
            body: StubStripeBackendHelper::STRIPE_RESPONSES[:checkout_session_retrieve_success_complete]
          }
        end
      end

      before do
        reservation_payment.update!(status: "paid")
      end

      it { expect(call).to be_valid }
      it { expect(call.errors).to be_empty }
      it { expect { call }.not_to(change { reservation_payment.reload.status }.from("paid")) }
      it { expect { call }.to(change { Log::StripeEvent.count }.by(1)) }
    end

    context "when reservation_payment has status 'authorized' and stripe session has status 'complete' for stripe_authorization" do
      let(:preorder_type) { :stripe_authorization }
      let(:stub) do
        stub_request(:get,
                     "https://api.stripe.com/v1/checkout/sessions/#{StubStripeBackendHelper::CS_ID}").to_return do |_request|
          {
            status: 200,
            headers: { "Content-Type" => "application/json" },
            body: StubStripeBackendHelper::STRIPE_RESPONSES[:checkout_session_retrieve_success_complete]
          }
        end
      end

      before do
        reservation_payment.update!(status: "authorized")
      end

      it { expect(call).to be_valid }
      it { expect(call.errors).to be_empty }
      it { expect { call }.not_to(change { reservation_payment.reload.status }.from("authorized")) }
      it { expect { call }.to(change { Log::StripeEvent.count }.by(1)) }
    end

    context "when reservation_payment has status 'paid' and stripe session has status 'complete' for stripe_authorization" do
      let(:preorder_type) { :stripe_authorization }
      let(:stub) do
        stub_request(:get,
                     "https://api.stripe.com/v1/checkout/sessions/#{StubStripeBackendHelper::CS_ID}").to_return do |_request|
          {
            status: 200,
            headers: { "Content-Type" => "application/json" },
            body: StubStripeBackendHelper::STRIPE_RESPONSES[:checkout_session_retrieve_success_complete]
          }
        end
      end

      before do
        reservation_payment.update!(status: "paid")
      end

      it { expect(call).to be_valid }
      it { expect(call.errors).to be_empty }
      it { expect { call }.not_to(change { reservation_payment.reload.status }.from("paid")) }
      it { expect { call }.to(change { Log::StripeEvent.count }.by(1)) }
    end

    [
      "todo"
    ].each do |reservation_payment_status|
      context "when reservation_payment has status #{reservation_payment_status.inspect} and stripe session has status 'complete' for stripe_authorization" do
        let(:preorder_type) { :stripe_authorization }
        let(:stub) do
          stub_request(:get,
                       "https://api.stripe.com/v1/checkout/sessions/#{StubStripeBackendHelper::CS_ID}").to_return do |_request|
            {
              status: 200,
              headers: { "Content-Type" => "application/json" },
              body: StubStripeBackendHelper::STRIPE_RESPONSES[:checkout_session_retrieve_success_complete]
            }
          end
        end

        before do
          reservation_payment.update!(status: reservation_payment_status)
        end

        it { expect(call).to be_valid }
        it { expect(call.errors).to be_empty }

        it {
          expect { call }.to(change do
                               reservation_payment.reload.status
                             end.from(reservation_payment_status).to("authorized"))
        }

        it { expect { call }.to(change { Log::StripeEvent.count }.by(1)) }
      end
    end

    %w[
      todo authorized
    ].each do |reservation_payment_status|
      context "when reservation_payment has status #{reservation_payment_status.inspect} and stripe session has status 'complete' for stripe_payment" do
        let(:preorder_type) { :stripe_payment }
        let(:stub) do
          stub_request(:get,
                       "https://api.stripe.com/v1/checkout/sessions/#{StubStripeBackendHelper::CS_ID}").to_return do |_request|
            {
              status: 200,
              headers: { "Content-Type" => "application/json" },
              body: StubStripeBackendHelper::STRIPE_RESPONSES[:checkout_session_retrieve_success_complete]
            }
          end
        end

        before do
          reservation_payment.update!(status: reservation_payment_status)
        end

        it { expect(call).to be_valid }
        it { expect(call.errors).to be_empty }

        it {
          expect { call }.to(change do
                               reservation_payment.reload.status
                             end.from(reservation_payment_status).to("paid"))
        }

        it { expect { call }.to(change { Log::StripeEvent.count }.by(1)) }
      end
    end

    # matrix between reservation_payment status and stripe session status
    # reservation_payment status is between todo, paid, refunded, authorized
    # stripe session status is between open, complete, expired
    %w[
      todo paid authorized
    ].each do |reservation_payment_status|
      %w[
        open complete expired
      ].each do |stripe_session_status|
        context "when reservation_payment status is '#{reservation_payment_status}' and stripe session status is '#{stripe_session_status}'" do
          before do
            reservation_payment.update!(status: reservation_payment_status)
            stub
          end

          let(:stub) do
            stub_request(:get,
                         "https://api.stripe.com/v1/checkout/sessions/#{StubStripeBackendHelper::CS_ID}").to_return do |_request|
              {
                status: 200,
                headers: { "Content-Type" => "application/json" },
                body: StubStripeBackendHelper::STRIPE_RESPONSES[:"checkout_session_retrieve_success_#{stripe_session_status}"]
              }
            end
          end

          it { expect(call).to be_valid }
          it { expect(call.errors).to be_empty }
          it { expect { call }.to(change { Log::StripeEvent.count }.by(1)) }
        end
      end
    end
  end

  context "when authorization, and its already in status 'paid' (user already charged)" do
    let(:preorder_type) { :html_nexi_authorization }

    before do
      reservation_payment.update(status: "paid")
    end

    it { expect { subject }.not_to(change { reservation_payment.reload.status }) }
    it { expect { subject }.not_to(change { reservation_payment.reload.as_json }) }
  end

  %w[html_nexi_payment html_nexi_authorization].each do |preorder_type|
    context "when preorder_type is #{preorder_type.inspect}" do
      let(:preorder_type) { preorder_type }

      context "when nexi returns success" do
        let(:response_file) { Rails.root.join("spec/fixtures/nexi-order-status-success.json") }

        it { expect(reservation_payment).to be_valid }
        it { expect(call.errors).to be_empty }

        it do
          if preorder_type == "html_nexi_payment"
            expect { subject }.to(change do
                                    reservation_payment.reload.status
                                  end.from("todo").to("paid"))
          end
          if preorder_type == "html_nexi_authorization"
            expect { subject }.to(change do
                                    reservation_payment.reload.status
                                  end.from("todo").to("authorized"))
          end
          expect { described_class.run(reservation_payment:) }.not_to(change { reservation_payment.reload.status })
        end
      end

      context "when nexi returns not paid" do
        let(:response_file) { Rails.root.join("spec/fixtures/nexi-order-status-not-paid.json") }

        it { expect(reservation_payment).to be_valid }
        it { expect(call.errors).to be_empty }

        it do
          expect { subject }.not_to(change { reservation_payment.reload.status }.from("todo"))
          expect { described_class.run(reservation_payment:) }.not_to(change { reservation_payment.reload.status })
        end
      end

      context "when nexi returns refunded" do
        let(:response_file) { Rails.root.join("spec/fixtures/nexi-order-status-refunded.json") }

        it { expect(reservation_payment).to be_valid }
        it { expect(call.errors).to be_empty }

        it do
          expect { subject }.to(change { reservation_payment.reload.status }.from("todo").to("refunded"))
          expect { described_class.run(reservation_payment:) }.not_to(change { reservation_payment.reload.status })
        end
      end
    end
  end
end
