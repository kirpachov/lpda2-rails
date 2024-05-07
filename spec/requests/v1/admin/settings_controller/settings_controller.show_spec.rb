# frozen_string_literal: true

require "rails_helper"

RSpec.describe "GET /v1/admin/settings/:key" do
  include_context REQUEST_AUTHENTICATION_CONTEXT

  let(:headers) { auth_headers }
  let(:params) { {} }
  let(:key) { "default_language" }

  def req(k = key, p = params, h = headers)
    get "#{settings_path}/#{k}", headers: h, params: p
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

  context "when authenticated" do
    context "when user has any settings" do
      subject { json }

      before { req }

      it do
        expect(response).to be_successful
      end

      it { is_expected.to be_a(Hash) }
      it { is_expected.not_to be_empty }

      it { expect(json).to include(:key, :value, :require_root, :updated_at, :updated_at) }
    end

    context "when setting { default_language: :en }" do
      before do
        Setting.find_by(key: :default_language).update!(value: :en)
        req(:default_language)
      end

      it { expect(json["value"]).to eq("en") }
    end

    context "when setting { default_language: :it }" do
      before do
        Setting.find_by(key: :default_language).update!(value: :it)
        req(:default_language)
      end

      it { expect(json["value"]).to eq("it") }
    end

    context "when setting { available_locales: 'it,en' }" do
      before do
        Setting.find_by(key: :available_locales).update!(value: "it,en")
        req(:available_locales)
      end

      it { expect(json["value"]).to eq("it,en") }
    end

    context "when setting { available_locales: 'en,it' }" do
      before do
        Setting.find_by(key: :available_locales).update!(value: "en,it")
        req(:available_locales)
      end

      it { expect(json["value"]).to eq("en,it") }
    end
  end
end
