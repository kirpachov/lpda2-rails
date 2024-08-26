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

      context "when reservation has status 'cancelled', should not be returned" do
        before do
          reservation.update!(status: :cancelled)
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

    context "when checking public_messages" do
      let(:sample_message) { PublicMessage.visible.sample }

      subject(:messages) { json[:public_messages] }

      before do
        create_list(:public_message, 10)
        create_list(:public_message, 10, status: :inactive)

        req
      end

      it { expect(response).to have_http_status(:ok) }
      it { expect(json).not_to include(message: String) }
      it { expect(json).to include(public_messages: Hash) }
      it { expect(messages).to include(sample_message.key => sample_message.text) }
      it { expect(messages.keys).to match_array(PublicMessage.visible.map(&:key)) }
      it { expect(messages.values).to match_array(PublicMessage.visible.map(&:text)) }

      context "gigi when making a request with a specific locale in the params" do
        let(:locale) { (I18n.available_locales - [I18n.locale]).sample }
        let(:hex) { SecureRandom.hex }

        before do
          PublicMessage.all.map do |msg|
            Mobility.with_locale(locale) do
              msg.update!(text: "Message #{locale}")
            end
          end

          Mobility.with_locale(locale) do
            PublicMessage.all.sample.update!(text: "Secret #{hex}")
          end

          req(params: { locale: })
        end

        it { expect(response).to have_http_status(:ok) }
        it { expect(json).not_to include(message: String) }
        it { expect(json).to include(public_messages: Hash) }
        it { expect(messages).to include(sample_message.key => sample_message.text) }
        it { expect(messages.keys).to match_array(PublicMessage.visible.map(&:key)) }
        it { expect(messages.values).to match_array(PublicMessage.visible.map(&:text)) }
        it { expect(messages.values).to include("Message #{locale}") }
        it { expect(messages.values).to include("Secret #{hex}") }
      end
    end
  end
end
