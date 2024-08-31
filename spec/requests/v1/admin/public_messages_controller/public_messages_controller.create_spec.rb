# frozen_string_literal: true

require "rails_helper"

RSpec.describe "POST /v1/admin/public_messages" do
  include_context REQUEST_AUTHENTICATION_CONTEXT

  let(:headers) { auth_headers }
  let(:params) { { key:, text: } }
  let(:key) { "position#{SecureRandom.hex}" }
  let(:text) { { it: text_it, en: text_en } }
  let(:text_it) { "Ciao" }
  let(:text_en) { "Hello" }

  def req(p = params, h = headers)
    post "/v1/admin/public_messages", headers: h, params: p
  end

  context "when not authenticated" do
    let(:headers) {}

    before { req }

    it { expect(response).to have_http_status(:unauthorized) }

    it { expect(json).to include(message: String) }
  end

  context "when making basic request" do
    it { expect { req }.to(change(PublicMessage, :count).by(1)) }
    it { expect { req }.to(change { PublicMessage.where(key:).count }.by(1)) }

    context "when checking response" do
      before { req }

      it { expect(response).to be_successful }
      it { expect(json).not_to include(message: String) }
      it { expect(json).to be_a(Hash) }
      it { expect(json[:item]).to include(key: String, text: String, translations: Hash) }
      it { expect(json[:item][:translations]).to include(text: Hash) }
      it { expect(json[:item][:id]).to be_blank }
      it { expect(json[:item]["id"]).to be_blank }
    end
  end

  context "when same key already exists" do
    let!(:message) { create(:public_message, key:) }

    it { expect { req }.not_to(change(PublicMessage, :count)) }
    it { expect { req }.to(change { message.reload.text }) }

    context "when checking response" do
      before { req }

      it { expect(response).to be_successful }
      it { expect(json).not_to include(message: String) }
      it { expect(json).to be_a(Hash) }
      it { expect(json[:item]).to include(key: String, text: String, translations: Hash) }
      it { expect(json[:item][:translations]).to include(text: Hash) }
      it { expect(json[:item][:id]).to be_blank }
      it { expect(json[:item]["id"]).to be_blank }
    end
  end

  context "after request, the message will be available in the public endpoint" do
    before do
      req
      get "/v1/public_data"
    end

    it { expect(response).to be_successful }
    it { expect(json).to include(public_messages: Hash) }
    it { expect(json[:public_messages]).to include(key) }
    it { expect(json[:public_messages][key]).to be_a(String) }
  end
end
