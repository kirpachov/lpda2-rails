# frozen_string_literal: true

require "rails_helper"

RSpec.shared_examples "failed request GET /v1/admin/reservation_turn_messages" do
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

RSpec.shared_examples "successful request GET /v1/admin/reservation_turn_messages" do
  it do
    req
    expect(response).to have_http_status(:ok)
  end

  it do
    req
    expect(json).not_to include(message: String)
  end
end

RSpec.describe "POST /v1/admin/reservation_turn_messages" do
  include_context REQUEST_AUTHENTICATION_CONTEXT

  let(:default_headers) { auth_headers }
  let(:default_params) do
    {}
  end

  let(:translations) { { it: Faker::Lorem.sentence, en: Faker::Lorem.sentence } }

  let!(:message) do
    create(:reservation_turn_message).tap do |t|
      t.assign_translation("message", translations)
      t.turns = [create(:reservation_turn)]
      t.save!
    end
  end

  def req(params: default_params, headers: default_headers)
    get "/v1/admin/reservation_turn_messages", headers:, params:
  end

  context "when not authenticated" do
    let(:default_headers) { {} }

    it { expect { req }.not_to(change { ReservationTurnMessage.all.as_json }) }

    it_behaves_like "failed request GET /v1/admin/reservation_turn_messages"

    it do
      req
      expect(response).to have_http_status(:unauthorized)
    end
  end

  context "when creating a basic message" do
    it_behaves_like "successful request GET /v1/admin/reservation_turn_messages"
  end
end
