# frozen_string_literal: true

require "rails_helper"

RSpec.describe "GET /v1/admin/public_messages/:key" do
  include_context REQUEST_AUTHENTICATION_CONTEXT

  let(:headers) { auth_headers }
  let(:params) { {} }
  let(:key) { message.key }
  let(:message) { create(:public_message) }

  def req(k = key, p = params, h = headers)
    get "/v1/admin/public_messages/#{k}", headers: h, params: p
  end

  context "when not authenticated" do
    let(:headers) {}

    before { req }

    it { expect(response).to have_http_status(:unauthorized) }

    it { expect(json).to include(message: String) }
  end

  context "when making basic request" do
    before { req }

    it { expect(response).to be_successful }
    it { expect(json).not_to include(message: String) }

    it { expect(json).to be_a(Hash) }
    it { expect(json[:item]).to include(key: String, text: String, translations: Hash) }
  end

  context "when key is not found" do
    let(:key) { "not_found" }

    before { req }

    it { expect(response).to have_http_status(:not_found) }
    it { expect(json).to include(message: String) }
  end
end
