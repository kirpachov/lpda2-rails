# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V1::SettingsController, type: :controller do
  include_context CONTROLLER_UTILS_CONTEXT

  def setting_keys
    %w[default_language]
  end

  before do
    Setting.create_missing
  end

  context '#index' do
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
        it "checking values" do
          expect(subject.keys).to match_array(setting_keys)
          expect(subject['default_language']).to eq Setting.default(:default_language).to_s
        end
      end
    end
  end

  context '#value' do
    def req(key = setting_keys.sample)
      get :value, params: { key: key }
    end

    it 'should return the value of the setting' do
      req

      expect(response).to be_successful
    end

    it 'should return just the value of the required setting' do
      Setting.find_or_initialize_by(key: :default_language).update(value: I18n.available_locales.sample.to_s)

      req(:default_language)

      expect(parsed_response_body.keys).to match_array(%w[value])
      expect(parsed_response_body['value']).to eq Setting.find_by(key: :default_language).value.to_s
    end

    it 'should return empty string instead of nil if value is nil' do
      Setting.find_or_initialize_by(key: :default_language).update(value: nil)

      req(:default_language)

      expect(parsed_response_body.keys).to match_array(%w[value])
      expect(parsed_response_body['value']).to eq ''
    end

    it 'should return error if invalid key is required' do
      req(:something_that_should_not_exist)

      expect(response).to have_http_status(:not_found)
      expect(parsed_response_body).not_to eq nil
      expect(parsed_response_body).to be_a(Hash)
      expect(parsed_response_body).to include(:message)
      expect(response).to have_http_status(:not_found)
    end
  end

  context '#show' do
    let(:key) { 'default_language' }

    def req(mkey = key)
      get :show, params: { key: mkey }
    end

    it 'should be successful' do
      req

      expect(response).to be_successful
    end

    context 'checking mock data' do
      it 'setting value in database should be nil' do
        expect(Setting.find_by(key: key).value).to eq nil
      end
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

      it { should include(value: Setting.default(key).to_s) }
    end
  end

  context '#update' do
    it { should route(:patch, '/v1/settings/default_language').to(action: :update, key: 'default_language', 'format': :json) }

    def req(key, value)
      patch :update, params: { key: key, value: value }
    end

    it 'should be successful' do
      req(:default_language, :en)

      expect(response).to be_successful
    end

    it 'should be able to update the value' do
      languages = I18n.available_locales.map(&:to_s)
      5.times do
        language = languages.sample
        req(:default_language, language)

        expect(response).to be_successful
        expect(Setting.find_by(key: :default_language).value.to_s).to eq language
      end
    end

    it 'should return 422 with error explanation if invalid value is provided' do
      req(:default_language, :some_invalid_language)

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
