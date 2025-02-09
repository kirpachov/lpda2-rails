# frozen_string_literal: true

require "rails_helper"

RSpec.shared_examples "failed request /v1/admin/reservation_turn_messages" do
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

  it { expect { req }.not_to(change { ReservationTurnMessage.count }) }
end

RSpec.shared_examples "successful request /v1/admin/reservation_turn_messages" do
  it do
    req
    expect(response).to have_http_status(:ok)
  end

  it do
    req
    expect(json).not_to include(message: String)
  end

  it { expect { req }.to(change { ReservationTurnMessage.count }) }
end

RSpec.describe "POST /v1/admin/reservation_turn_messages" do
  include_context REQUEST_AUTHENTICATION_CONTEXT

  let(:default_headers) { auth_headers }
  let(:default_params) do
    { from_date:, to_date:, message: }
  end

  let(:from_date) { nil }
  let(:to_date) { nil }
  let(:message) { { it: Faker::Lorem.sentence, en: Faker::Lorem.sentence } }

  let!(:reservation_turn) do
    create(:reservation_turn)
  end

  def req(params: default_params, headers: default_headers)
    post "/v1/admin/reservation_turn_messages", headers:, params:
  end

  context "when not authenticated" do
    let(:default_headers) { {} }

    it { expect { req }.not_to(change { ReservationTurnMessage.all.as_json }) }

    it_behaves_like "failed request /v1/admin/reservation_turn_messages"

    it do
      req
      expect(response).to have_http_status(:unauthorized)
    end
  end

  context "when creating a basic message" do
    it_behaves_like "successful request /v1/admin/reservation_turn_messages"
  end

  pending "when providing turn_ids"
  pending "when providing invalid turn_ids, all changes will be reverted and 422 returned."

  context "when checking message" do
    let(:message) do
      { it: "message it", en: "message en" }
    end

    it_behaves_like "successful request /v1/admin/reservation_turn_messages"

    it do
      req
      expect(ReservationTurnMessage.last.message_it).to eq("message it")
    end

    it do
      req
      expect(ReservationTurnMessage.last.message_en).to eq("message en")
    end
  end

  context "checking from_date" do
    let(:from_date) { "2024-12-12" }

    it_behaves_like "successful request /v1/admin/reservation_turn_messages"

    it { expect { req }.to(change { ReservationTurnMessage.where(from_date:).count }.by(1)) }
  end

  context "checking to_date" do
    let(:to_date) { "2024-12-12" }

    it_behaves_like "successful request /v1/admin/reservation_turn_messages"

    it { expect { req }.to(change { ReservationTurnMessage.where(to_date:).count }.by(1)) }
  end

  context "when providing both from_date and to_date" do
    let(:to_date) { "2024-12-12" }
    let(:from_date) { "2024-12-12" }

    it_behaves_like "successful request /v1/admin/reservation_turn_messages"

    it { expect { req }.to(change { ReservationTurnMessage.where(to_date:).count }.by(1)) }
    it { expect { req }.to(change { ReservationTurnMessage.where(from_date:).count }.by(1)) }
    it { expect { req }.to(change { ReservationTurnMessage.where(from_date:, to_date:).count }.by(1)) }
  end

  context "when from_date > to_date" do
    let(:to_date) { "2024-12-12" }
    let(:from_date) { "2024-12-13" }

    it_behaves_like "failed request /v1/admin/reservation_turn_messages"
  end
end
