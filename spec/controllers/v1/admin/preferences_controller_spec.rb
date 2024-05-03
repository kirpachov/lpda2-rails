# frozen_string_literal: true

require "rails_helper"

RSpec.describe V1::Admin::PreferencesController, type: :controller do
  include_context CONTROLLER_UTILS_CONTEXT
  include_context CONTROLLER_AUTHENTICATION_CONTEXT
  include_context TESTS_OPTIMIZATIONS_CONTEXT

  let(:user) { create(:user) }

  def preference_keys
    %w[language known_languages timezone]
  end

  describe "#index" do
    before { authenticate_request(user:) }

    def req
      get :index
    end

    context "response" do
      subject { req }

      it { is_expected.to be_successful }

      context "body" do
        subject { json }

        before { req }

        let(:json) { parsed_response_body }

        it { is_expected.to be_a(Hash) }
        it { is_expected.not_to be_empty }

        it "includes all user's preferences" do
          keys = json[:items].map{ |item| item[:key].to_s }
          expect(keys).to match_array user.preferences.pluck(:key).map(&:to_s)
        end
      end
    end
  end

  describe "#show" do
    before { authenticate_request(user:) }

    let(:key) { "language" }

    def req(mkey = key)
      get :show, params: { key: mkey }
    end

    it "is successful" do
      req

      expect(response).to be_successful
    end

    context "should return the full record" do
      subject { json }

      before { req }

      let(:json) { parsed_response_body }

      it { is_expected.to be_a(Hash) }
      it { is_expected.not_to be_empty }
      it { is_expected.to include(:updated_at) }
      it { is_expected.to include(:key) }
      it { is_expected.to include(:value) }
      it { is_expected.to include(:require_root) }
      it { is_expected.not_to include(:id) }

      it { is_expected.to include(value: user.preference_value(key).to_s) }
    end
  end

  describe "#update" do
    before { authenticate_request(user:) }

    it {
      expect(subject).to route(:patch, "/v1/admin/preferences/language").to(action: :update, key: "language",
                                                                            format: :json)
    }

    def req(key, value)
      patch :update, params: { key:, value: }
    end

    it "is successful" do
      req(:language, :en)

      expect(response).to be_successful
    end

    it "is able to update the value" do
      languages = I18n.available_locales.map(&:to_s)
      5.times do
        language = languages.sample
        req(:language, language)

        expect(response).to be_successful
        expect(Preference.where(user:, key: :language).first.value.to_s).to eq language
      end
    end

    it "returns 422 with error explanation if invalid value is provided" do
      req(:language, :some_invalid_language)

      expect(response).not_to be_successful
      expect(response).to have_http_status(:unprocessable_entity)
      expect(parsed_response_body).to be_a(Hash)
      expect(parsed_response_body).to include(:message)
      expect(parsed_response_body).to include(:details)
    end

    it "returns an error if invalid key is provided" do
      req(:some_strange_invalid_key, :en)

      expect(response).not_to be_successful
      expect(response).to have_http_status(:not_found)
    end
  end
end
