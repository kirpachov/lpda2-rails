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
  let(:group) { create(:preorder_reservation_group) }
  let(:default_params) do
    {}
  end

  let(:tt1) do
    create(:table_type).tap do |t|
      t.assign_translation("name", translated_name)
      t.assign_translation("description", translated_description)
      t.images << create(:image, :with_attached_image)
      t.save!
    end
  end

  let(:tt2) do
    create(:table_type).tap do |t|
      t.assign_translation("name", translated_name)
      t.assign_translation("description", translated_description)
      t.images << create(:image, :with_attached_image)
      t.images << create(:image, :with_attached_image)
      t.save!
    end
  end

  let(:tt3) do
    create(:table_type, status: :deleted)
  end

  def translated_name
    { it: Faker::Lorem.sentence, en: Faker::Lorem.sentence }
  end

  def translated_description
    { it: Faker::Lorem.sentence, en: Faker::Lorem.sentence }
  end

  before do
    group.add_table_type(table_type: tt1, price: 5, people_per_turn: 2)
    group.add_table_type(table_type: tt2, price: 10, people_per_turn: 4)
    group.add_table_type(table_type: tt3, price: 10, people_per_turn: 4)
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

  context "when filtering by name in query" do
    let(:default_params) { { query: tt1.name } }

    it_behaves_like "successful request GET /v1/admin/table_types"

    it do
      req
      expect(json[:items].pluck(:id)).to include(tt1.id)
      expect(json[:items].pluck(:id)).not_to include(tt2.id)
    end
  end

  context "when filtering by description in query" do
    let(:default_params) { { query: tt1.description } }

    it_behaves_like "successful request GET /v1/admin/table_types"

    it do
      req
      expect(json[:items].pluck(:id)).to include(tt1.id)
      expect(json[:items].pluck(:id)).not_to include(tt2.id)
    end
  end

  context "won't return deleted table types" do
    before { req }

    it do
      expect(json[:items].pluck(:id)).not_to be_empty
      expect(json[:items].pluck(:id)).not_to include(TableType.deleted.pluck(:id).sample)
    end
  end

  context "checking response structure" do
    before { req }

    it { expect(response).to have_http_status(:ok) }
    it { expect(json).to include(items: Array, metadata: Hash) }

    it {
      expect(json[:items]).to all(include(id: Integer, name: String, description: String, images: Array,
                                          table_type_to_preorder_reservation_groups: Array))
    }

    it do
      expect(json[:items].sample[:images]).to all(include(id: Integer, url: String))
    end

    it do
      expect(json[:items].sample[:table_type_to_preorder_reservation_groups]).to all(include(id: Integer,
                                                                                             preorder_reservation_group_id: Integer, preorder_reservation_group: Hash))
    end
  end
end
