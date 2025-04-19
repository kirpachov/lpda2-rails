# frozen_string_literal: true

require "rails_helper"

RSpec.shared_examples "failed request POST /v1/admin/reservations/<id>/record_deferred_payment" do
  it { expect { req }.not_to(change { Reservation.all.as_json }) }
  it { expect { req }.not_to(change { ReservationPayment.all.as_json }) }
  it { expect { req }.not_to(change { Log::ReservationEvent.record_deferred_payment.count }) }

  it do
    Sidekiq::Testing.inline! do
      allow(ReservationMailer).to receive(:with).and_call_original

      req

      expect(ReservationMailer).not_to have_received(:with)
    end
  end

  it do
    req
    expect(response).not_to have_http_status(:ok)
  end

  it do
    req
    expect(response).not_to have_http_status(:internal_server_error)
  end

  it do
    req
    expect(json).to include(message: String)
  end
end

RSpec.shared_examples "successful request POST /v1/admin/reservations/<id>/record_deferred_payment" do
  it { expect { req }.to(change { Log::ReservationEvent.record_deferred_payment.count }.by(1)) }

  it do
    req
    expect(response).to have_http_status(:ok)
  end

  it do
    req
    expect(json).not_to include(message: String)
  end

  it do
    Sidekiq::Testing.inline! do
      allow(ReservationMailer).to receive(:with).and_call_original

      req

      expect(ReservationMailer).to have_received(:with).once
    end
  end

  it { expect { req }.to(change { Reservation.all.as_json }) }
  it { expect { req }.to(change { ReservationPayment.all.as_json }) }
  it { expect { req }.to(change { ReservationPayment.all.pluck(:status) }) }

  it { expect { req }.not_to(change(Reservation, :count)) }
  it { expect { req }.not_to(change(ReservationPayment, :count)) }
  it { expect { req }.to(change { ReservationPayment.where(status: :paid).count }.by(1)) }
  it { expect { req }.to(change { ReservationPayment.where(status: :authorized).count }.by(-1)) }
end

RSpec.describe "POST /v1/admin/reservations/<id>/record_deferred_payment" do
  include_context REQUEST_AUTHENTICATION_CONTEXT

  let(:current_user_root_at) { Time.zone.now }
  let(:response_file) { Rails.root.join("spec/fixtures/nexi-record-deferred-payment-success.json") }
  let(:reservation_payment_external_id) { "PO123321" }
  let!(:reservation) { create(:reservation) }
  let(:payment_status) { :authorized }
  let(:payment_type) { :html_nexi_authorization }
  let!(:reservation_payment) do
    create(:reservation_payment, reservation:, preorder_type: payment_type, status: payment_status,
                                 external_id: reservation_payment_external_id)
  end
  let(:stub_response) do
    {
      status: 200,
      body: File.read(response_file)
    }
  end
  let(:stub) do
    stub_request(:post,
                 "#{Config.app.dig!(:nexi_api_url)}/#{Config.app.dig!(:nexi_record_deferred_path)}").to_return do |_request|
      stub_response
    end
  end

  let(:default_headers) { auth_headers }

  let(:default_params) { {} }

  let(:reservation_id) { reservation.id }

  # before { stub }

  def req(id: reservation_id, params: default_params, headers: default_headers)
    stub

    post "/v1/admin/reservations/#{id}/record_deferred_payment", headers:, params:
  end

  context "when not authenticated" do
    let(:default_headers) { {} }

    include_context "failed request POST /v1/admin/reservations/<id>/record_deferred_payment"

    it do
      req
      expect(response).to have_http_status(:unauthorized)
    end
  end

  context "when current user is not root" do
    let(:current_user_root_at) { nil }

    include_context "failed request POST /v1/admin/reservations/<id>/record_deferred_payment"

    it do
      req
      expect(response).to have_http_status(:forbidden)
    end
  end

  context "when creating a basic payment" do
    include_context "successful request POST /v1/admin/reservations/<id>/record_deferred_payment"

    # it do
    #   Sidekiq::Testing.inline! do
    #     allow(ReservationMailer).to receive(:with).and_call_original

    #     req

    #     expect(ReservationMailer).to have_received(:with).once
    #   end
    # end
  end

  pending "when reservation does not have email it's fine but won't send email"
  pending "when status <> 'authorized', will fail."
  pending "when preorder_type is not 'html_nexi_authorization', will fail"
  # context "when reservation does not have email it's fine" do
  #   before { reservation.update!(email: nil) }

  #   it do
  #     Sidekiq::Testing.inline! do
  #       allow(ReservationMailer).to receive(:with).and_call_original

  #       req

  #       expect(ReservationMailer).not_to have_received(:with)
  #     end
  #   end

  #   it { expect { req }.to(change { ReservationPayment.all.pluck(:value) }.from([]).to([15.2])) }
  #   it { expect { req }.to(change { reservation.reload.payment }.from(nil)) }

  #   include_context "successful request POST /v1/admin/reservations/<id>/record_deferred_payment"
  # end

  [
    "nexi-record-deferred-payment-failure-invalid-content-type.json",
    "nexi-record-deferred-payment-failure.json",
    "nexi-error-page.html",
    "nexi-unauthorized-page.html"
  ].each do |nexi_response_stub_file|
    context "when nexi APIs return some kind of error" do
      let(:response_file) do
        Rails.root.join("spec", "fixtures", nexi_response_stub_file)
      end

      include_context "failed request POST /v1/admin/reservations/<id>/record_deferred_payment"
    end
  end

  context "when nexi APIs return just a comment" do
    let(:stub_response) do
      {
        status: 200,
        body: "<!-- some useless comment -->"
      }
    end

    include_context "failed request POST /v1/admin/reservations/<id>/record_deferred_payment"
  end
end
