# frozen_string_literal: true

require "rails_helper"

RSpec.shared_examples "failed request GET /v1/admin/table_types" do
  it do
    req
    expect(response).not_to have_http_status(:ok)
  end

  it do
    req
    expect(response).not_to have_http_status(:internal_server_error)
  end

  it do
    req
    expect(json).to include(message: String)
  end
end

RSpec.shared_examples "successful request GET /v1/admin/table_types" do
  it do
    req
    expect(response).to have_http_status(:ok)
  end

  it do
    req
    expect(json).not_to include(message: String)
  end
end

RSpec.describe "GET /v1/admin/table_types" do
  include_context REQUEST_AUTHENTICATION_CONTEXT

  let(:default_headers) { auth_headers }
  let(:default_params) do
    {}
  end

  let(:translated_name) { { it: Faker::Lorem.sentence, en: Faker::Lorem.sentence } }
  let(:translated_description) { { it: Faker::Lorem.sentence, en: Faker::Lorem.sentence } }

  let!(:table_types) do
    create(:table_type).tap do |t|
      t.assign_translation("name", translated_name)
      t.assign_translation("description", translated_description)
      t.save!
    end
  end

  def req(params: default_params, headers: default_headers)
    get "/v1/admin/table_types", headers:, params:
  end

  context "when not authenticated" do
    let(:default_headers) { {} }

    it { expect { req }.not_to(change { ReservationTurnMessage.all.as_json }) }

    it_behaves_like "failed request GET /v1/admin/table_types"

    it do
      req
      expect(response).to have_http_status(:unauthorized)
    end
  end

  context "when current user is not root" do
    let(:current_user_root_at) { nil }

    it_behaves_like "successful request GET /v1/admin/table_types"
  end

  context "when querying" do
    it_behaves_like "successful request GET /v1/admin/table_types"
  end
end
