# frozen_string_literal: true

require "rails_helper"

RSpec.describe "GET /v1/admin/public_messages" do
  include_context REQUEST_AUTHENTICATION_CONTEXT

  let(:headers) { auth_headers }
  let(:params) { {} }

  def req(p = params, h = headers)
    get "/v1/admin/public_messages", headers: h, params: p
  end

  context "when not authenticated" do
    let(:headers) {}
    before { req }

    it { expect(response).to have_http_status(:unauthorized) }

    it { expect(json).to include(message: String) }
  end

  context "when making basic request" do
    let(:messages) do
      create_list(:public_message, 3)
    end

    before do
      messages
      req
    end

    it { expect(response).to be_successful }
    it { expect(json).not_to include(message: String) }

    it { expect(json).to be_a(Hash) }
    it { expect(json).to include(items: Array) }
    it { expect(json[:items].size).to eq(3) }
    it { expect(json[:items]).to all(include(key: String, text: String, translations: Hash)) }
    it { expect(json[:items].sample[:translations]).to include(text: Hash) }
    it { expect(json[:items].sample[:id]).to be_blank }
    it { expect(json[:items].sample["id"]).to be_blank }
  end

  [nil, "", " "].each do |blank|
    context "when text is #{blank.inspect}, message should not be returned" do
      let(:messages) do
        create_list(:public_message, 3).sample.update!(text: blank)
      end

      before do
        messages
        req
      end

      it { expect(response).to be_successful }
      it { expect(json).not_to include(message: String) }

      it { expect(json).to be_a(Hash) }
      it { expect(json).to include(items: Array) }
      it { expect(json[:items].size).to eq(3) }
    end
  end

  context "when filtering by key" do
    let(:messages) do
      create_list(:public_message, 3)
    end

    let(:key) { messages.sample.key }

    before do
      messages
      req(key: key)
    end

    it { expect(response).to be_successful }
    it { expect(json).not_to include(message: String) }

    it { expect(json).to be_a(Hash) }
    it { expect(json).to include(items: Array) }
    it { expect(json[:items].size).to eq(1) }
    it { expect(json[:items].first).to include(key: key) }
  end
end
