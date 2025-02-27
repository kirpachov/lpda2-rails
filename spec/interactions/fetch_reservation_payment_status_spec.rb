# frozen_string_literal: true

require "rails_helper"

RSpec.describe FetchReservationPaymentStatus, type: :interaction do
  let(:response_file) { Rails.root.join("spec/fixtures/nexi-order-status-success.json") }

  let(:stub_response) do
    {
      status: 200,
      body: File.read(
        response_file
      ).gsub(/CODICE_TRANSAZIONE/, reservation_payment_external_id)
    }
  end

  let(:stub) do
    stub_request(:post,
                 "#{Config.app.dig!(:nexi_api_url)}/#{Config.app.dig!(:nexi_order_status_path)}").to_return do |_request|
      stub_response
    end
  end

  include_context TESTS_OPTIMIZATIONS_CONTEXT

  let(:reservation_payment_external_id) { "PO123321" }
  let!(:reservation) { create(:reservation) }
  let!(:reservation_payment) { create(:reservation_payment, reservation:, external_id: reservation_payment_external_id) }
  subject(:call) do
    stub
    described_class.run(reservation_payment:)
  end

  it { expect(reservation_payment).to be_valid }
  it { expect(call.errors).to be_empty }

  %w[html_nexi_payment html_nexi_authorization].each do |preorder_type|
    context "when preorder_type is #{preorder_type.inspect}" do
      context "when nexi returns success" do
        let(:response_file) { Rails.root.join("spec/fixtures/nexi-order-status-success.json") }

        it { expect(reservation_payment).to be_valid }
        it { expect(call.errors).to be_empty }
        it do
          expect { subject }.to(change { reservation_payment.reload.status }.from("todo").to("paid"))
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
