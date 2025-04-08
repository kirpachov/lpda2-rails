# frozen_string_literal: true

require "rails_helper"

RSpec.shared_examples "failed request POST /v1/admin/reservations/<id>/payment" do

  it { expect { req }.not_to(change { Reservation.all.as_json }) }
  it { expect { req }.not_to(change { ReservationPayment.all.as_json }) }

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

RSpec.shared_examples "successful request POST /v1/admin/reservations/<id>/payment" do
  it do
    req
    expect(response).to have_http_status(:ok)
  end

  it do
    req
    expect(json).not_to include(message: String)
  end

  it { expect { req }.to(change { Reservation.all.as_json }) }
  it { expect { req }.to(change { ReservationPayment.all.as_json }) }

  it { expect { req }.not_to(change { Reservation.count }) }
end

RSpec.describe "POST /v1/admin/reservations/<id>/payment" do
  include_context REQUEST_AUTHENTICATION_CONTEXT

  let(:current_user_root_at) { Time.zone.now }
  let(:default_headers) { auth_headers }
  let(:amount) { 15.2 }

  let(:table_type) { create(:table_type) }

  let(:table_type_id) { table_type.id }

  let(:default_params) do
    {
      amount:,
      # table_type_id:,
    }
  end

  let!(:reservation) { create(:reservation) }
  let(:reservation_id) { reservation.id }

  before do
    stub_request(:post,
                  "#{Config.app.dig!(:nexi_api_url)}/#{Config.app.dig!(:nexi_simple_payment_path)}").to_return do |_request|
      {
        body: File.read(Rails.root.join("spec", "fixtures", "nexi-simple-payment-success-page.html"))
      }
    end
  end

  def req(id: reservation_id, params: default_params, headers: default_headers)
    post "/v1/admin/reservations/#{id}/payment", headers:, params:
  end

  context "when not authenticated" do
    let(:default_headers) { {} }

    include_context "failed request POST /v1/admin/reservations/<id>/payment"

    it do
      req
      expect(response).to have_http_status(:unauthorized)
    end
  end

  context "when current user is not root" do
    let(:current_user_root_at) { nil }

    include_context "failed request POST /v1/admin/reservations/<id>/payment"

    it do
      req
      expect(response).to have_http_status(403)
    end
  end

  context "when creating a basic payment" do

    it { expect { req }.to(change { ReservationPayment.all.pluck(:value) }.from([]).to([15.2])) }
    it { expect { req }.to(change { reservation.reload.payment }.from(nil)) }

    include_context "successful request POST /v1/admin/reservations/<id>/payment"
  end

  context "when setting deferred: true, will include 'tcontab'='D' in request" do
    let(:default_params) { { amount:, deferred: [true, "true"].sample } }

    include_context "successful request POST /v1/admin/reservations/<id>/payment"

    it do
      req
      expect(Nexi::HttpRequest.last.request_body.dig!("TCONTAB")).to eq("D")
    end
  end

  context "when setting deferred: false (or nil), will include 'tcontab'='C' in request" do
    let(:default_params) { { amount:, deferred: [false, "false", nil].sample } }

    include_context "successful request POST /v1/admin/reservations/<id>/payment"

    it do
      req
      expect(Nexi::HttpRequest.last.request_body.dig!("TCONTAB")).to eq("C")
    end
  end

  context "when setting amount to 0" do
    let(:amount) { 0 }

    include_context "failed request POST /v1/admin/reservations/<id>/payment"
  end

  context "when not providing table_type_id (default)" do
    let(:default_params) { { amount: } }

    include_context "successful request POST /v1/admin/reservations/<id>/payment"

    it { expect { req }.not_to(change { reservation.reload.table_type }.from(nil)) }
  end

  context "when providing table_type_id" do
    let(:default_params) { { amount:, table_type_id: } }

    include_context "successful request POST /v1/admin/reservations/<id>/payment"

    it { expect { req }.to(change { reservation.reload.table_type }.from(nil)) }
  end

  context "when providing table_type_id but it's not valid" do
    let(:table_type_id) { ["mannaggia", 999_999_999].sample }
    let(:default_params) { { amount:, table_type_id: } }

    include_context "failed request POST /v1/admin/reservations/<id>/payment"

    it { expect { req }.not_to(change { reservation.reload.table_type }.from(nil)) }
  end

  context "when providing table_type_id but it's not visible" do
    before { table_type.deleted! }

    let(:default_params) { { amount:, table_type_id: } }

    include_context "failed request POST /v1/admin/reservations/<id>/payment"

    it { expect { req }.not_to(change { reservation.reload.table_type }.from(nil)) }
  end

  context "when nexi APIs return some kind of error" do
    before do
      stub_request(:post,
                   "#{Config.app.dig!(:nexi_api_url)}/#{Config.app.dig!(:nexi_simple_payment_path)}").to_return do |_request|
        {
          status: 200,
          body: File.read(Rails.root.join("spec", "fixtures", "nexi-error-page.html"))
        }
      end
    end

    include_context "failed request POST /v1/admin/reservations/<id>/payment"
  end

  context "when nexi APIs return just a comment" do
    before do
      stub_request(:post,
                   "#{Config.app.dig!(:nexi_api_url)}/#{Config.app.dig!(:nexi_simple_payment_path)}").to_return do |_request|
        {
          status: 200,
          body: "<!-- some useless comment -->"
        }
      end
    end

    include_context "failed request POST /v1/admin/reservations/<id>/payment"
  end

  context "when we're not authorized to use nexi APIs" do
    before do
      stub_request(:post,
                   "#{Config.app.dig!(:nexi_api_url)}/#{Config.app.dig!(:nexi_simple_payment_path)}").to_return do |_request|
        {
          body: File.read(Rails.root.join("spec", "fixtures", "nexi-unauthorized-page.html"))
        }
      end
    end

    include_context "failed request POST /v1/admin/reservations/<id>/payment"
  end
end
