# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V1::Admin::PreferencesController, type: :controller do
  include_context CONTROLLER_UTILS_CONTEXT
  include_context CONTROLLER_AUTHENTICATION_CONTEXT
  include_context TESTS_OPTIMIZATIONS_CONTEXT

  let(:user) { create(:user) }

  def preference_keys
    %w[language known_languages timezone]
  end

  context '#index' do
    before { authenticate_request(user:) }

    def req
      get :index
    end

    context 'response' do
      subject { req }

      it { should be_successful }

      context 'body' do
        before { req }
        let(:json) { parsed_response_body }
        subject { json }

        it { should be_a(Hash) }
        it { should_not be_empty }
        it "should include all user's preferences" do
          expect(json.keys).to match_array user.preferences.pluck(:key)
        end
      end
    end
  end

  context '#value' do
    before { authenticate_request(user:) }

    def req(key = preference_keys.sample)
      get :value, params: { key: key }
    end

    it 'should return the value of the setting of this user' do
      req

      expect(response).to be_successful
    end

    it 'should return just the value of the required setting' do
      req(:language)

      expect(parsed_response_body).to eq user.preference_value(:language).to_s
    end

    it 'should return error if invalid key is required' do
      req(:something_that_should_not_exist)

      expect(parsed_response_body).not_to eq nil
      expect(parsed_response_body).to be_a(Hash)
      expect(parsed_response_body).to include(:message)
      expect(response).to have_http_status(:not_found)
    end
  end

  context '#show' do
    before { authenticate_request(user:) }

    let(:key) { 'language' }

    def req(mkey = key)
      get :show, params: { key: mkey }
    end

    it 'should be successful' do
      req

      expect(response).to be_successful
    end

    context 'should return the full record' do
      before { req }
      let(:json) { parsed_response_body }
      subject { json }

      it { should be_a(Hash) }
      it { should_not be_empty }
      it { should include(:updated_at) }
      it { should include(:key) }
      it { should include(:value) }
      it { should include(:require_root) }
      it { should_not include(:id) }

      it { should include(value: user.preference_value(key).to_s) }
    end
  end

  context '#update' do
    before { authenticate_request(user:) }

    it { should route(:patch, '/v1/admin/preferences/language').to(action: :update, key: 'language', 'format': :json) }

    def req(key, value)
      patch :update, params: { key: key, value: value }
    end

    it 'should be successful' do
      req(:language, :en)

      expect(response).to be_successful
    end

    it 'should be able to update the value' do
      languages = I18n.available_locales.map(&:to_s)
      5.times do
        language = languages.sample
        req(:language, language)

        expect(response).to be_successful
        expect(Preference.where(user: user, key: :language).first.value.to_s).to eq language
      end
    end

    it 'should return 422 with error explanation if invalid value is provided' do
      req(:language, :some_invalid_language)

      expect(response).not_to be_successful
      expect(response).to have_http_status(:unprocessable_entity)
      expect(parsed_response_body).to be_a(Hash)
      expect(parsed_response_body).to include(:message)
      expect(parsed_response_body).to include(:details)
    end

    it 'should return an error if invalid key is provided' do
      req(:some_strange_invalid_key, :en)

      expect(response).not_to be_successful
      expect(response).to have_http_status(:not_found)
    end
  end
end
