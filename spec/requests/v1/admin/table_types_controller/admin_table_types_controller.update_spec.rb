# frozen_string_literal: true

require "rails_helper"

RSpec.shared_examples "failed request PATCH /v1/admin/table_types/<table-type-id>" do
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

  it { expect { req }.not_to(change { TableType.all.as_json }) }
end

RSpec.shared_examples "successful request PATCH /v1/admin/table_types/<table-type-id>" do
  it do
    req
    expect(response).to have_http_status(:ok)
  end

  it do
    req
    expect(json).not_to include(message: String)
  end

  it { expect { req }.to(change { TableType.all.as_json }) }
  it { expect { req }.not_to(change { TableType.count }) }
end

RSpec.describe "PATCH /v1/admin/table_types/<table-type-id>" do
  include_context REQUEST_AUTHENTICATION_CONTEXT

  let(:current_user_root_at) { Time.zone.now }
  let(:default_headers) { auth_headers }
  let(:default_params) do
    { default_people_per_turn: 51, default_price: 91, notes: "Gigi", name: "Luxury 1", description: "Super luxe table" }
  end

  let!(:table_type) do
    create(:table_type)
  end

  let(:table_type_id) { table_type.id }

  def req(id: table_type_id, params: default_params, headers: default_headers)
    patch "/v1/admin/table_types/#{id}", headers:, params:
  end

  context "when not authenticated" do
    let(:default_headers) { {} }

    it { expect { req }.not_to(change { TableType.all.as_json }) }

    it_behaves_like "failed request PATCH /v1/admin/table_types/<table-type-id>"

    it do
      req
      expect(response).to have_http_status(:unauthorized)
    end
  end

  context "when current user is not root" do
    let(:current_user_root_at) { nil }

    it_behaves_like "failed request PATCH /v1/admin/table_types/<table-type-id>"
  end

  context "when creating a basic table type" do
    it_behaves_like "successful request PATCH /v1/admin/table_types/<table-type-id>"
  end

  context "when setting the default_people_per_turn to 0" do
    let(:default_params) { { default_people_per_turn: 0 } }

    it_behaves_like "failed request PATCH /v1/admin/table_types/<table-type-id>"

    it { expect { req }.not_to(change { TableType.all.as_json }) }
  end

  context "when setting the default_people_per_turn to 101" do
    let(:default_params) { { default_people_per_turn: 101 } }

    it_behaves_like "successful request PATCH /v1/admin/table_types/<table-type-id>"

    it { expect { req }.to(change { TableType.where(default_people_per_turn: 101).count }.from(0).to(1)) }
  end

  context "when setting the default_price to 0" do
    let(:default_params) { { default_price: 0 } }

    it_behaves_like "successful request PATCH /v1/admin/table_types/<table-type-id>"

    it { expect { req }.to(change { TableType.where(default_price: 0).count }.from(0).to(1)) }
  end

  context "when setting the default_price to 101" do
    let(:default_params) { { default_price: 101 } }

    it_behaves_like "successful request PATCH /v1/admin/table_types/<table-type-id>"

    it { expect { req }.to(change { TableType.where(default_price: 101).count }.from(0).to(1)) }
  end
end
