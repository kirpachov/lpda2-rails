# frozen_string_literal: true

require "rails_helper"

RSpec.describe "GET /v1/admin/settings/hash" do
  include_context REQUEST_AUTHENTICATION_CONTEXT

  let(:headers) { auth_headers }
  let(:params) { {} }

  def req(p = params, h = headers)
    get hash_settings_path, headers: h, params: p
  end

  before { Setting.create_missing }

  context "when not authenticated" do
    let(:headers) { {} }

    it do
      req
      expect(response).to have_http_status(:unauthorized)
    end

    it do
      req
      expect(json).to include(message: String)
    end
  end

  context "when authorized" do
    context "when checking basic request" do
      subject { json }

      before { req }

      it do
        expect(response).to be_successful
      end

      it { is_expected.to be_a(Hash) }
      it { is_expected.not_to be_empty }

      %w[default_language available_locales].each do |setting|
        it { expect(json.keys.map(&:to_s)).to include(setting) }
      end
    end

    context "when setting { default_language: :en }" do
      before do
        Setting.find_by(key: :default_language).update!(value: :en)
        req
      end

      it { expect(json["default_language"]).to eq("en") }
    end

    context "when setting { default_language: :it }" do
      before do
        Setting.find_by(key: :default_language).update!(value: :it)
        req
      end

      it { expect(json["default_language"]).to eq("it") }
    end

    context "when setting {available_locales: 'it,en'}" do
      before do
        Setting.find_by(key: :available_locales).update!(value: "it,en")
        req
      end

      it { expect(json["available_locales"]).to eq("it,en") }
    end

    context "when setting {available_locales: 'it'}" do
      before do
        Setting.find_by(key: :available_locales).update!(value: "it")
        req
      end

      it { expect(json["available_locales"]).to eq("it") }
    end

    context "when setting {available_locales: ''}" do
      before do
        Setting.find_by(key: :available_locales).update!(value: "")
        req
      end

      it { expect(json["available_locales"]).to eq("") }
    end
  end
end
