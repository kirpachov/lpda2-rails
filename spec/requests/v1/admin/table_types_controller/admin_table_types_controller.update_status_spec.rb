# frozen_string_literal: true

require "rails_helper"

RSpec.shared_examples "failed request PATCH /v1/admin/table_types/<table-type-id>/update_status" do
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

RSpec.shared_examples "successful request PATCH /v1/admin/table_types/<table-type-id>/update_status" do
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

RSpec.describe "PATCH /v1/admin/table_types/<table-type-id>/update_status" do
  include_context REQUEST_AUTHENTICATION_CONTEXT

  let(:current_user_root_at) { Time.zone.now }
  let(:default_headers) { auth_headers }
  let(:default_params) do
    { status: "inactive" }
  end

  let!(:table_type) do
    create(:table_type)
  end

  let(:table_type_id) { table_type.id }

  def req(id: table_type_id, params: default_params, headers: default_headers)
    patch "/v1/admin/table_types/#{id}/update_status", headers:, params:
  end

  context "when not authenticated" do
    let(:default_headers) { {} }

    it { expect { req }.not_to(change { TableType.all.as_json }) }

    it_behaves_like "failed request PATCH /v1/admin/table_types/<table-type-id>/update_status"

    it do
      req
      expect(response).to have_http_status(:unauthorized)
    end
  end

  context "when current user is not root" do
    let(:current_user_root_at) { nil }

    it_behaves_like "failed request PATCH /v1/admin/table_types/<table-type-id>/update_status"
  end

  context "when basic req" do
    it_behaves_like "successful request PATCH /v1/admin/table_types/<table-type-id>/update_status"

    it { expect { req }.to(change { table_type.reload.status }.from("active").to("inactive")) }
  end

  [
    # { from: :active, to: :inactive },
    # { from: :inactive, to: :active },
  ].each do |scenario|
    context "when updating to #{scenario[:to].inspect} from #{scenario[:from].inspect}" do
      before { table_type.update!(status: scenario[:from]) }

      let(:default_params) { { status: scenario[:to] } }

      it_behaves_like "successful request PATCH /v1/admin/table_types/<table-type-id>/update_status"

      it {
        expect { req }.to(change do
                            table_type.reload.status.to_s
                          end.from(scenario[:from].to_s).to(scenario[:to]).to_s)
      }
    end
  end
end
