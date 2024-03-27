# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V1::Admin::SettingsController, type: :controller do
  include_context CONTROLLER_UTILS_CONTEXT
  include_context CONTROLLER_AUTHENTICATION_CONTEXT
  include_context TESTS_OPTIMIZATIONS_CONTEXT
  before do
    authenticate_request
    Setting.create_missing
  end

  def setting_keys
    %w[default_language available_locales max_people_per_reservation email_contacts]
  end

  describe '#index' do
    def req
      get :index
    end

    context 'response' do
      subject { req }

      it { is_expected.to be_successful }

      context 'body' do
        subject { json }

        before { req }

        let(:json) { parsed_response_body }

        it { is_expected.to be_a(Hash) }
        it { is_expected.not_to be_empty }

        it 'checking values' do
          expect(subject.keys).to include(*setting_keys)
          expect(subject['default_language']).to eq Setting.default(:default_language).to_s
        end
      end
    end
  end

  describe '#value' do
    def req(key = setting_keys.sample)
      get :value, params: { key: }
    end

    it 'returns the value of the setting' do
      req

      expect(response).to be_successful
    end

    it 'returns just the value of the required setting' do
      Setting.find_or_initialize_by(key: :default_language).update(value: I18n.available_locales.sample.to_s)

      req(:default_language)

      expect(parsed_response_body.keys).to match_array(%w[value])
      expect(parsed_response_body['value']).to eq Setting.find_by(key: :default_language).value.to_s
    end

    it 'returns empty string instead of nil if value is nil' do
      Setting.find_or_initialize_by(key: :default_language).update(value: nil)

      req(:default_language)

      expect(parsed_response_body.keys).to match_array(%w[value])
      expect(parsed_response_body['value']).to eq ''
    end

    it 'returns error if invalid key is required' do
      req(:something_that_should_not_exist)

      expect(response).to have_http_status(:not_found)
      expect(parsed_response_body).not_to eq nil
      expect(parsed_response_body).to be_a(Hash)
      expect(parsed_response_body).to include(:message)
      expect(response).to have_http_status(:not_found)
    end
  end

  describe '#show' do
    let(:key) { 'default_language' }

    def req(mkey = key)
      get :show, params: { key: mkey }
    end

    it 'is successful' do
      req

      expect(response).to be_successful
    end

    context 'checking mock data' do
      it do
        expect(Setting.find_by(key:).value).not_to eq nil
      end
    end

    context 'should return the full record' do
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

      it { is_expected.to include(value: Setting.default(key).to_s) }
    end
  end

  describe '#update' do
    it {
      expect(subject).to route(:patch, '/v1/admin/settings/default_language').to(action: :update, key: 'default_language',
                                                                                 'format': :json)
    }

    def req(key, value)
      patch :update, params: { key:, value: }
    end

    it 'is successful' do
      req(:default_language, :en)

      expect(response).to be_successful
    end

    it 'is able to update the value' do
      languages = I18n.available_locales.map(&:to_s)
      5.times do
        language = languages.sample
        req(:default_language, language)

        expect(response).to be_successful
        expect(Setting.find_by(key: :default_language).value.to_s).to eq language
      end
    end

    it 'returns 422 with error explanation if invalid value is provided' do
      req(:default_language, :some_invalid_language)

      expect(response).not_to be_successful
      expect(response).to have_http_status(:unprocessable_entity)
      expect(parsed_response_body).to be_a(Hash)
      expect(parsed_response_body).to include(:message)
      expect(parsed_response_body).to include(:details)
    end

    it 'returns an error if invalid key is provided' do
      req(:some_strange_invalid_key, :en)

      expect(response).not_to be_successful
      expect(response).to have_http_status(:not_found)
    end
  end
end
