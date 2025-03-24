# frozen_string_literal: true

require "rails_helper"

RSpec.shared_examples "failed request GET /v1/admin/table_types/<id>" do
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

RSpec.shared_examples "successful request GET /v1/admin/table_types/<id>" do
  it do
    req
    expect(response).to have_http_status(:ok)
  end

  it do
    req
    expect(json).not_to include(message: String)
  end
end

RSpec.describe "GET /v1/admin/table_types/<id>" do
  include_context REQUEST_AUTHENTICATION_CONTEXT

  let(:default_headers) { auth_headers }
  let(:default_params) do
    { id: table_type.id }
  end

  def translated_name
    { it: Faker::Lorem.sentence, en: Faker::Lorem.sentence }
  end

  def translated_description
    { it: Faker::Lorem.sentence, en: Faker::Lorem.sentence }
  end

  let(:group) { create(:preorder_reservation_group) }

  let(:table_type) do
    create(:table_type).tap do |t|
      t.assign_translation("name", translated_name)
      t.assign_translation("description", translated_description)
      t.images << create(:image, :with_attached_image)
      group.add_table_type(table_type: t, price: 5, people_per_turn: 2)
      t.save!
    end
  end

  def req(params: default_params, headers: default_headers)
    get "/v1/admin/table_types/#{params[:id]}", headers:, params:
  end

  context "when not authenticated" do
    let(:default_headers) { {} }

    it { expect { req }.not_to(change { ReservationTurnMessage.all.as_json }) }

    it_behaves_like "failed request GET /v1/admin/table_types/<id>"

    it do
      req
      expect(response).to have_http_status(:unauthorized)
    end
  end

  context "when current user is not root" do
    let(:current_user_root_at) { nil }

    it_behaves_like "successful request GET /v1/admin/table_types/<id>"
  end

  context "checking response structure" do
    before { req }

    it { expect(response).to have_http_status(:ok) }
    it { expect(json[:item]).to include(id: Integer, name: String, description: String, images: Array, table_type_to_preorder_reservation_groups: Array) }

    it do
      expect(json.dig(:item, :images)).to all(include(id: Integer, url: String))
    end

    it do
      expect(json.dig(:item, :table_type_to_preorder_reservation_groups)).to all(include(id: Integer, preorder_reservation_group_id: Integer, preorder_reservation_group: Hash))
    end
  end
end
