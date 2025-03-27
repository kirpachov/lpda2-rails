# frozen_string_literal: true

require "rails_helper"

RSpec.shared_examples "failed request DELETE /v1/admin/table_types/<table-type-id>" do
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

RSpec.shared_examples "successful request DELETE /v1/admin/table_types/<table-type-id>" do
  it do
    req
    expect(response).to have_http_status(:no_content)
  end

  it do
    req
    expect(json).not_to include(message: String)
  end

  it { expect { req }.to(change(TableType, :count).by(-1)) }
end

RSpec.describe "DELETE /v1/admin/table_types/<table-type-id>" do
  include_context REQUEST_AUTHENTICATION_CONTEXT

  let(:current_user_root_at) { Time.zone.now }
  let(:default_headers) { auth_headers }
  let(:default_params) do
    {}
  end

  let!(:table_type) do
    create(:table_type, name: nil, description: nil)
  end

  let(:table_type_id) { table_type.id }

  def req(id: table_type_id, params: default_params, headers: default_headers)
    delete "/v1/admin/table_types/#{id}", headers:, params:
  end

  context "when not authenticated" do
    let(:default_headers) { {} }

    it { expect { req }.not_to(change { TableType.all.as_json }) }

    it_behaves_like "failed request DELETE /v1/admin/table_types/<table-type-id>"

    it do
      req
      expect(response).to have_http_status(:unauthorized)
    end
  end

  context "when current user is not root" do
    let(:current_user_root_at) { nil }

    it_behaves_like "failed request DELETE /v1/admin/table_types/<table-type-id>"
  end

  context "when creating a basic table type" do
    it_behaves_like "successful request DELETE /v1/admin/table_types/<table-type-id>"
  end

  context "when providing non-existent table type id" do
    let(:table_type_id) { 99_999_999 }

    it_behaves_like "failed request DELETE /v1/admin/table_types/<table-type-id>"

    it do
      req
      expect(response).to have_http_status(:not_found)
    end
  end

  context "when table type is assigned to some preorder reservation groups" do
    let!(:preorder_reservation_group) do
      create(:preorder_reservation_group).tap do |prg|
        prg.add_table_type!(
          table_type: table_type,
          price: 10,
          people_per_turn: 200
        )
      end
    end

    it_behaves_like "failed request DELETE /v1/admin/table_types/<table-type-id>"

    it { expect { req }.not_to(change { TableType.all.as_json }) }
    it { expect { req }.not_to(change { TableTypeToPreorderReservationGroup.all.as_json }) }
  end
end
