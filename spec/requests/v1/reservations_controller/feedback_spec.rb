# frozen_string_literal: true

require "rails_helper"

RSpec.context "GET /v1/reservations/:secret/feedback", type: :request do
  let!(:reservation) { create(:reservation, datetime: 1.day.ago) }
  let(:default_secret) { reservation.secret }
  let(:default_params) { {} }
  let(:default_headers) { {} }

  def req(params: default_params, headers: default_headers, secret: default_secret)
    get "/v1/reservations/#{secret}/feedback", headers:, params:
  end

  context "basic request" do
    before { req }

    it { expect(response).to have_http_status(:found) }
    it { expect(response.headers["Location"]).to eq(Setting[:feedback_url]) }
  end

  context "when a custom feedback_url is configured" do
    before do
      Setting[:feedback_url] = "https://forms.gle/some-feedback-form"
      req
    end

    it { expect(response.headers["Location"]).to eq("https://forms.gle/some-feedback-form") }
  end

  context "when opening the feedback link, an event should be created" do
    it { expect { req }.to change { reservation.events.count }.from(0).to(1) }
    it { expect { req }.to change { Log::ReservationEvent.count }.from(0).to(1) }
    it { expect { req }.to change { reservation.events.where(event_type: "open_feedback_url").count }.from(0).to(1) }

    it do
      expect { req }.to change {
                          Log::ReservationEvent.where(reservation:, event_type: "open_feedback_url").count
                        }.from(0).to(1)
    end

    it "can be opened multiple times, tracking an event every time" do
      3.times do
        expect { req }.to change {
                            Log::ReservationEvent.where(reservation:, event_type: "open_feedback_url").count
                          }.by(1)
      end
    end
  end

  context "when reservation is not found" do
    let(:default_secret) { "not-found" }

    before { req }

    it { expect(response).to have_http_status(:not_found) }
    it { expect(response.body).to include("Unable to find") }
  end

  %w[cancelled deleted].each do |status|
    context "when reservation has status #{status}" do
      before do
        reservation.update!(status:)
        req
      end

      it { expect(response).to have_http_status(:not_found) }
    end
  end

  context "when reservation is in the future" do
    before do
      reservation.update!(datetime: 1.day.from_now)
      req
    end

    it { expect(response).to have_http_status(:found) }
    it { expect(response.headers["Location"]).to eq(Setting[:feedback_url]) }
  end
end
