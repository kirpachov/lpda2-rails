# frozen_string_literal: true

require "rails_helper"

RSpec.describe "PATCH /v1/admin/preferences/:key" do
  include_context REQUEST_AUTHENTICATION_CONTEXT

  let(:headers) { auth_headers }
  let(:params) { { value: } }

  let(:value) { "en" }
  let(:key) { "language" }

  def req(k = key, p = params, h = headers)
    patch "#{preferences_path}/#{k}", headers: h, params: p
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
    end

    context "when setting language to 'en'" do
      let(:value) { "en" }
      let(:key) { "language" }

      before do
        current_user.preference(:language).update!(value: :it)
      end

      it { expect { req }.to(change { current_user.preference(:language).value }.from("it").to("en")) }
      it { expect { req }.to(change { current_user.preference(:language).updated_at }) }

      it {
        expect { req }.not_to(change do
                                current_user.preferences.where.not(key: :language).order(:id).pluck(:updated_at)
                              end)
      }

      it do
        req
        expect(json["value"]).to eq("en")
      end

      it do
        req
        expect(json["key"]).to eq("language")
      end

      it do
        req
        expect(json).to include(:key, :value, :require_root, :updated_at)
      end
    end

    context "when setting language to 'it'" do
      let(:value) { "it" }
      let(:key) { "language" }

      before do
        current_user.preference(:language).update!(value: :en)
      end

      it { expect { req }.to(change { current_user.preference(:language).value }.from("en").to("it")) }
      it { expect { req }.to(change { current_user.preference(:language).updated_at }) }

      it {
        expect { req }.not_to(change do
                                current_user.preferences.where.not(key: :language).order(:id).pluck(:updated_at)
                              end)
      }

      it do
        req
        expect(json["value"]).to eq("it")
      end

      it do
        req
        expect(json["key"]).to eq("language")
      end

      it do
        req
        expect(json).to include(:key, :value, :require_root, :updated_at)
      end
    end

    context "when unknown key" do
      let(:key) { "unknown" }

      it do
        req
        expect(response).to have_http_status(:not_found)
      end

      it do
        req
        expect(json).to include(message: String)
      end
    end
  end
end
