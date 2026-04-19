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

    context "when checking default contacts" do
      before do
        req
      end

      it { expect(Contact.count).to eq 0 }
      it { expect(json).to include(contacts: Hash) }

      # Taken from Contact::DEFAULTS.keys.join(" ")
      %w[address email phone whatsapp_number facebook_url instagram_url tripadvisor_url homepage_url
         google_url].each do |key|
        it "json->contacts->#{key} should be present" do
          expect(json.dig("contacts", key)).to be_present
        end
      end
    end

    context "when email contact has been updated" do
      let(:email) { "something#{SecureRandom.hex}@example.com" }

      before do
        create(:contact, key: :email, value: email)
        req
      end

      it { expect(json.dig("contacts", "email")).to eq(email) }
    end

    3.times do
      context "when phone contact has been updated" do
        def s
          Random.rand(2).zero? ? " " : ""
        end

        let(:phone) { "#{s}+39#{s}041#{s}241#{s}2124#{s}" }

        before do
          create(:contact, key: :phone, value: phone)
          req
        end

        it { expect(json.dig("contacts", "phone")).to eq(phone.delete(" ")) }
      end
    end

    3.times do
      context "when whatsapp phone contact has been updated" do
        def s
          Random.rand(2).zero? ? " " : ""
        end

        let(:whatsapp_number) { "#{s}+39#{s}041#{s}241#{s}2124#{s}" }

        before do
          create(:contact, key: :whatsapp_number, value: whatsapp_number)
          req
        end

        it { expect(json.dig("contacts", "whatsapp_number")).to eq(whatsapp_number.delete(" ")) }
      end
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
      it { expect(json.dig("reservation", "created_at")).to be_present }

      context "when ReservationPayment associated exists" do
        before do
          payment
          req
        end

        let!(:payment) { create(:reservation_payment, reservation:, value: 10.2) }

        it { expect(json.dig("reservation", "payment", "hpp_url")).to be_present }
        it { expect(json.dig("reservation", "payment", "hpp_url")).to include(payment.reservation.secret) }
        it { expect(json.dig("reservation", "payment", "hpp_url")).to include("/do_payment") }

        it { expect(json.dig("reservation", "payment", "status")).to be_present }
        it { expect(json.dig("reservation", "payment", "status")).to eq(payment.status) }

        %w[id created_at updated_at other secret].each do |field|
          it { expect(json.dig("reservation", "payment", field)).to be_blank }
          it { expect(json.dig("reservation", "payment").keys).not_to include(field) }
        end
      end

      context "when ReservationPayment associated exists and payment is :strip_payment" do
        before do
          payment
          req
        end

        let!(:payment) { create(:reservation_payment, :stripe_payment, reservation:, value: 10.2) }

        it { expect(json.dig("reservation", "payment", "hpp_url")).to be_present }
        it { expect(json.dig("reservation", "payment", "hpp_url")).not_to include(payment.hpp_url) }
        it { expect(json.dig("reservation", "payment", "hpp_url")).to include("#{payment.reservation.secret}/do_payment") }

        it { expect(json.dig("reservation", "payment", "status")).to be_present }
        it { expect(json.dig("reservation", "payment", "status")).to eq(payment.status) }

        %w[id created_at updated_at other secret].each do |field|
          it { expect(json.dig("reservation", "payment", field)).to be_blank }
          it { expect(json.dig("reservation", "payment").keys).not_to include(field) }
        end
      end


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
      subject(:messages) { json[:public_messages] }

      let(:sample_message) { PublicMessage.visible.sample }

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

      context "when making a request with a specific locale in the params" do
        let(:locale) { (I18n.available_locales - [I18n.locale]).sample }
        let(:hex) { SecureRandom.hex }

        before do
          PublicMessage.all.map do |msg|
            Mobility.with_locale(locale) do
              msg.update!(text: "Message #{locale}")
            end
          end

          Mobility.with_locale(locale) do
            PublicMessage.visible.sample.update!(text: "Secret #{hex}")
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
