# frozen_string_literal: true

require "rails_helper"

RSpec.shared_examples "failed request DELETE /v1/admin/reservation_turn_messages/<message-id>" do
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

  it { expect { req }.not_to(change { ReservationTurnMessage.all.as_json }) }
end

RSpec.shared_examples "successful request DELETE /v1/admin/reservation_turn_messages/<message-id>" do
  it do
    req
    expect(response).to have_http_status(:no_content)
  end

  it do
    req
    expect(json).not_to include(message: String)
  end

  it { expect { req }.to(change { ReservationTurnMessage.count }.by(-1)) }
end

RSpec.describe "DELETE /v1/admin/reservation_turn_messages/<message-id>" do
  include_context REQUEST_AUTHENTICATION_CONTEXT

  let(:default_headers) { auth_headers }
  let(:default_params) do
    {}
  end

  let!(:turn_message) do
    create(:reservation_turn_message)
  end

  let(:turn_message_id) { turn_message.id }

  def req(message_id: turn_message_id, params: default_params, headers: default_headers)
    delete "/v1/admin/reservation_turn_messages/#{message_id}", headers:, params:
  end

  context "when not authenticated" do
    let(:default_headers) { {} }

    it { expect { req }.not_to(change { Reservation.all.as_json }) }
    it { expect { req }.not_to(change { ReservationTurnMessage.all.as_json }) }

    it_behaves_like "failed request DELETE /v1/admin/reservation_turn_messages/<message-id>"

    it do
      req
      expect(response).to have_http_status(:unauthorized)
    end
  end

  context "when creating a basic message" do
    it_behaves_like "successful request DELETE /v1/admin/reservation_turn_messages/<message-id>"
  end

  context "when providing non-existent turn message id" do
    let(:turn_message_id) { 99_999_999 }

    it_behaves_like "failed request DELETE /v1/admin/reservation_turn_messages/<message-id>"

    it do
      req
      expect(response).to have_http_status(:not_found)
    end
  end
end
