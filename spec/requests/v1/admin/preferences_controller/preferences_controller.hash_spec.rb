# frozen_string_literal: true

require "rails_helper"

RSpec.describe "GET /v1/admin/preferences/hash" do
  include_context REQUEST_AUTHENTICATION_CONTEXT

  let(:headers) { auth_headers }
  let(:params) { {} }

  def req(p = params, h = headers)
    get hash_preferences_path, headers: h, params: p
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

  context "when authorized" do
    context "when user has any preferences" do
      subject { json }

      before { req }

      it do
        expect(response).to be_successful
      end

      it { is_expected.to be_a(Hash) }
      it { is_expected.not_to be_empty }

      %w[language known_languages].each do |preference|
        it { expect(json.keys.map(&:to_s)).to include(preference) }
      end
    end

    context "when user's preference { language: :en }" do
      before do
        current_user.preference(:language).update!(value: :en)
        req
      end

      it { expect(json["language"]).to eq("en") }
    end

    context "when user's preference { language: :it }" do
      before do
        current_user.preference(:language).update!(value: :it)
        req
      end

      it { expect(json["language"]).to eq("it") }
    end

    context "when user's preference {known_languages: 'it,en'}" do
      before do
        current_user.preference(:known_languages).update!(value: "it,en")
        req
      end

      it { expect(json["known_languages"]).to eq("it,en") }
    end

    context "when user's preference {known_languages: 'it'}" do
      before do
        current_user.preference(:known_languages).update!(value: "it")
        req
      end

      it { expect(json["known_languages"]).to eq("it") }
    end

    context "when user's preference {known_languages: ''}" do
      before do
        current_user.preference(:known_languages).update!(value: "")
        req
      end

      it { expect(json["known_languages"]).to eq("") }
    end
  end
end
