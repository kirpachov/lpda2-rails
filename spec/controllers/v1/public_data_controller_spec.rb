# frozen_string_literal: true

require "rails_helper"

RSpec.describe V1::PublicDataController, type: :controller do
  let(:instance) { described_class.new }

  include_context CONTROLLER_UTILS_CONTEXT
  include_context TESTS_OPTIMIZATIONS_CONTEXT

  context "GET /v1/public_data" do
    let(:default_params) { {} }

    def req(params: default_params)
      get :index, params:
    end

    it "does not require authentication" do
      req
      expect(response).to have_http_status(:ok)
    end

    context "when user has created a reservation previously" do
      let(:secret) { "secret#{SecureRandom.hex}" }
      let!(:reservation) { create(:reservation, secret:) }

      before do
        allow_any_instance_of(ActionDispatch::Request).to receive(:cookies).and_return(Reservation::PUBLIC_CREATE_COOKIE => secret)
        req
      end

      it { expect(response).to have_http_status(:ok) }
      it { expect(json).not_to include(message: String) }

      it { expect(json).to be_present }
      it { expect(json["reservation"]).to be_present }
      it { expect(json.dig("reservation", "secret")).to eq(secret) }

      context "when its datetime is passed" do
        before do
          reservation.update!(datetime: 1.day.ago)
          req
        end

        it { expect(response).to have_http_status(:ok) }
        it { expect(json).not_to include(message: String) }

        it { expect(json).to be_present }
        it { expect(json["reservation"]).to be_nil }
      end
    end

    context "when checking settings" do
      before do
        Setting.delete_all

        create(:setting, key: :max_people_per_reservation, value: 5)
        req
      end

      it { expect(response).to have_http_status(:ok) }
      it { expect(json).not_to include(message: String) }

      it { expect(json).to include(settings: Hash) }
      it { expect(json.dig("settings", "max_people_per_reservation").to_i).to eq 5 }
    end
  end

end
