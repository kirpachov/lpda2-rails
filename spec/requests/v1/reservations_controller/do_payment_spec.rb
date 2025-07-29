# frozen_string_literal: true

require "rails_helper"

RSpec.context "GET /v1/reservations/:secret/do_payment", type: :request do
  let!(:reservation) { create(:reservation) }
  let!(:payment) { create(:reservation_payment, reservation:) }
  let(:default_secret) { reservation.secret }
  let(:default_params) { {} }
  let(:default_headers) { {} }

  def req(params: default_params, headers: default_headers, secret: default_secret)
    get "/v1/reservations/#{secret}/do_payment", headers:, params:
  end

  it do
    expect(payment.hpp_url).to include("/v1/reservations/#{reservation.secret}/do_payment")
  end

  context "when stripe payment, will redirect to stripe payment page" do
    let!(:payment) do
      create(:reservation_payment, preorder_type: "stripe_authorization", reservation:, html: nil, hpp_url: "https://checkout.stripe.com/pay/cs_test_1234567890")

      reservation.reload.payment
    end

    it { expect(payment.hpp_url).to include("https://checkout.stripe.com") }

    context "after request" do
      before { req }

      it { expect(response).to have_http_status(:found) }
      it { expect(response.headers["Location"]).to include("https://checkout.stripe.com") }
      it { expect(response.headers["Location"]).to eq(payment.hpp_url) }
    end
  end

  context "when upening the payment page, an event should be created" do
    it { expect { req }.to change { reservation.events.count }.from(0).to(1) }
    it { expect { req }.to change { Log::ReservationEvent.count }.from(0).to(1) }
    it { expect { req }.to change { reservation.events.where(event_type: "do_payment").count }.from(0).to(1) }

    it {
      expect { req }.to change {
                          Log::ReservationEvent.where(reservation:, event_type: "do_payment").count
                        }.from(0).to(1)
    }

    it do
      payment.paid!

      5.times do
        # puts "Creating event"
        expect { req }.to change {
                            Log::ReservationEvent.where(reservation:, event_type: "redirect_payment_success").count
                          }.by(1)
      end
    end
  end

  context "basic request" do
    before { req }

    it { expect(response).to have_http_status(:ok) }
    it { expect(response.body.downcase).to include("<!doctype html>") }
    it { expect(response.headers["Content-Type"]).to start_with("text/html") }
  end

  context "when reservation is not found" do
    let(:default_secret) { "not-found" }

    before { req }

    it { expect(response).to have_http_status(:not_found) }
    it { expect(response.body).to include("Unable to find") }
  end

  context "when reservation does not have any payment" do
    before do
      payment.destroy
      req
    end

    it { expect(response).to have_http_status(:not_found) }
    it { expect(response.body).to include("Unable to find") }
  end

  context "when payment has been successful, does redirect to success page" do
    before do
      payment.update!(status: "paid")
      req
    end

    it { expect(response).to have_http_status(:found) }
    it { expect(response.headers["Location"]).to eq(payment.success_url) }
  end

  context "when authorization has been successful, does redirect to success page" do
    before do
      payment.update!(status: "authorized")
      req
    end

    it { expect(response).to have_http_status(:found) }
    it { expect(response.headers["Location"]).to eq(payment.success_url) }
  end

  context "when reservation is in the past" do
    before do
      reservation.update!(datetime: 1.day.ago)
      req
    end

    it { expect(response).to have_http_status(:not_found) }
    it { expect(response.body).to include("Unable to find") }
  end

  context "will remove comments from html" do
    before do
      reservation.payment.update!(html: "<!-- some-comment -->#{reservation.payment.html}")
      req
    end

    it { expect(response).to have_http_status(:ok) }
    it { expect(response.body).not_to include("some-comment") }
    it { expect(response.body).not_to include("<!--") }
  end

  %w[cancelled deleted noshow].each do |status|
    context "when reservation has status #{status}" do
      before do
        reservation.update!(status:)
        req
      end

      it { expect(reservation.payment).to be_present }
      it { expect(response).to have_http_status(:not_found) }
      it { expect(response.body).to include("Unable to find") }
    end
  end

  %w[html_nexi_payment html_nexi_authorization].each do |preorder_type|
    context "when reservation has preorder_type #{preorder_type}" do
      before do
        payment.update!(preorder_type:)
        req
      end

      it { expect(reservation.payment).to be_present }
      it { expect(response).to have_http_status(:ok) }
    end
  end
end
