# frozen_string_literal: true

require "rails_helper"

RSpec.shared_examples "failed request GET /v1/admin/preorder_reservation_groups/<id>" do
  before { req }

  it do
    expect(response).not_to have_http_status(:ok)
  end

  it do
    expect(response).not_to have_http_status(:internal_server_error)
  end

  it do
    expect(json).to include(message: String)
  end
end

RSpec.shared_examples "successful request GET /v1/admin/preorder_reservation_groups/<id>" do
  before { req }

  it do
    expect(response).to have_http_status(:ok)
  end

  it do
    expect(json).not_to include(message: String)
  end

  it { expect(json[:item]).to include(id: Integer) }
  it { expect(json[:item]).to include(:min_people) }
  it { expect(json[:item]).to include(title: String) }
  it { expect(json[:item]).to include(status: String) }
  it { expect(json[:item]).to include(preorder_type: String) }
  it { expect(json[:item]).to include(payment_value: Float) }
  it { expect(json[:item]).to include(created_at: String) }
  it { expect(json[:item]).to include(updated_at: String) }
end

RSpec.describe "GET /v1/admin/preorder_reservation_groups/<id>" do
  include_context REQUEST_AUTHENTICATION_CONTEXT

  let(:default_headers) { auth_headers }
  let(:group) { create(:preorder_reservation_group, min_people: nil) }

  let(:default_params) do
    { id: group.id }
  end

  def req(params: default_params, headers: default_headers)
    get "/v1/admin/preorder_reservation_groups/#{params[:id]}", headers:, params:
  end

  context "when not authenticated" do
    let(:default_headers) { {} }

    it { expect { req }.not_to(change { ReservationTurnMessage.all.as_json }) }

    it_behaves_like "failed request GET /v1/admin/preorder_reservation_groups/<id>"

    it do
      req
      expect(response).to have_http_status(:unauthorized)
    end
  end

  context "when current user is not root" do
    let(:current_user_root_at) { nil }

    it_behaves_like "successful request GET /v1/admin/preorder_reservation_groups/<id>"
  end

  context "when basic request" do
    before { req }

    it_behaves_like "successful request GET /v1/admin/preorder_reservation_groups/<id>"

    it { expect(json).to include(item: Hash) }
    it { expect(json[:item]).to include(min_people: nil) }
  end

  context "when group has min_people" do
    before do
      group.update!(min_people: 10)
      req
    end

    it_behaves_like "successful request GET /v1/admin/preorder_reservation_groups/<id>"
    it { expect(json).to include(item: Hash) }
    it { expect(json[:item]).to include(min_people: 10) }
  end
end
