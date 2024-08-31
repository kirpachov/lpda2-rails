# frozen_string_literal: true

require "rails_helper"

RSpec.context "POST /v1/reservations/:secret/resend_confirmation_email", type: :request do
  let(:reservation) { create(:reservation) }
  let(:default_secret) { reservation.secret }
  let(:default_params) { {} }
  let(:default_headers) { {} }

  def req(params: default_params, headers: default_headers, secret: default_secret)
    post "/v1/reservations/#{secret}/resend_confirmation_email", headers:, params:
  end

  context "basic request" do
    before { req }

    it { expect(response).to have_http_status(:ok) }
    it { expect(json).to include(success: true) }

    it "does enqueue email to reservation email" do
      expect(ActionMailer::MailDeliveryJob).to have_been_enqueued.with("ReservationMailer", "confirmation",
                                                                       "deliver_now", params: anything, args: anything)
    end

    it "can deliver email" do
      Sidekiq::Testing.inline! do
        allow(ReservationMailer).to receive(:with).and_call_original

        req

        expect(ReservationMailer).to have_received(:with).once
      end
    end
  end

  context "when reservation is not found" do
    let(:default_secret) { "not-found" }

    before { req }

    it { expect(response).to have_http_status(:not_found) }
    it { expect(json).to include(message: /Unable to find/) }
  end

  context "when reservation is in the past" do
    before do
      reservation.update!(datetime: 1.day.ago)
      req
    end

    it { expect(response).to have_http_status(:not_found) }
    it { expect(json).to include(message: /Unable to find/) }
  end

  %w[cancelled deleted noshow].each do |status|
    context "when reservation has status #{status}" do
      before do
        reservation.update!(status:)
        req
      end

      it { expect(response).to have_http_status(:not_found) }
      it { expect(json).to include(message: /Unable to find/) }
    end
  end
end
