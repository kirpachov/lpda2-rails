# frozen_string_literal: true

require "rails_helper"

RSpec.describe "GET /v1/admin/preferences" do
  include_context REQUEST_AUTHENTICATION_CONTEXT

  let(:headers) { auth_headers }
  let(:params) { {} }

  def req(p = params, h = headers)
    get preferences_path, headers: h, params: p
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

      it { expect(json[:items]).to be_a(Array) }
      it { expect(json[:items]).not_to be_empty }
      it { expect(json[:items]).to all(be_a(Hash)) }

      it do
        expect(json[:items]).to all(include(:key, :value, :require_root, :updated_at, :updated_at))
      end
    end
  end
end
