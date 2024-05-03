# frozen_string_literal: true

require "rails_helper"

RSpec.describe "GET /v1/admin/preferences/:key" do
  include_context REQUEST_AUTHENTICATION_CONTEXT

  let(:headers) { auth_headers }
  let(:params) { {} }
  let(:key) { "language" }

  def req(k = key, p = params, h = headers)
    get "#{preferences_path}/#{k}", headers: h, params: p
  end

  context "when not authenticated" do
    let(:headers) {}

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
    context "when user has any preferences" do
      subject { json }

      before { req }

      it do
        expect(response).to be_successful
      end

      it { is_expected.to be_a(Hash) }
      it { is_expected.not_to be_empty }

      it { expect(json).to include(:key, :value, :require_root, :updated_at, :updated_at) }
    end

    context "when user's preference { language: :en }" do
      before do
        current_user.preference(:language).update!(value: :en)
        req(:language)
      end

      it { expect(json["value"]).to eq("en") }
    end

    context "when user's preference { language: :it }" do
      before do
        current_user.preference(:language).update!(value: :it)
        req(:language)
      end

      it { expect(json["value"]).to eq("it") }
    end

    context "when user's preference { known_languages: 'it,en' }" do
      before do
        current_user.preference(:known_languages).update!(value: "it,en")
        req(:known_languages)
      end

      it { expect(json["value"]).to eq("it,en") }
    end

    context "when user's preference { known_languages: 'en,it' }" do
      before do
        current_user.preference(:known_languages).update!(value: "en,it")
        req(:known_languages)
      end

      it { expect(json["value"]).to eq("en,it") }
    end
  end
end
