# frozen_string_literal: true

require "rails_helper"

RSpec.shared_examples "successul request" do |_additions|
  it { expect { req }.not_to raise_error }

  it do
    req
    expect(response).to have_http_status(:ok)
  end

  it do
    req
    expect(json).not_to include(message: String)
  end
end

RSpec.describe "GET /v1/admin/menu/categories" do
  include_context REQUEST_AUTHENTICATION_CONTEXT

  let(:default_headers) { auth_headers }
  let(:default_params) { {} }

  def req(params: default_params, headers: default_headers)
    get "/v1/admin/menu/categories", headers:, params:
  end

  context "when not authenticated" do
    let(:default_headers) { {} }

    before { req }

    it { expect(response).to have_http_status(:unauthorized) }

    it { expect(json).to include(message: String) }
  end

  context "when there are no categories" do
    it { expect(Menu::Category.count).to eq(0) }

    it_behaves_like "successul request"
  end

  context "basic request" do
    before do
      create_list(:menu_category, 2)
    end

    it_behaves_like "successul request"
  end

  context "categories should include dishes and categories children for each status" do
    before do
      c1 = create(:menu_category)
      c1.dishes << create(:menu_dish, status: :active)
      c1.dishes << create(:menu_dish, status: :inactive)
      c1.dishes << create(:menu_dish, status: :inactive)
      c1.dishes << create(:menu_dish, status: :deleted)
      create(:menu_category, status: :active, visibility: nil, parent: c1)
      create(:menu_category, status: :deleted, visibility: nil, parent: c1)
    end

    let(:default_params) { { parent_id: nil } }

    it_behaves_like "successul request"

    it do
      req
      expect(json[:items].count).to eq(1)
    end

    it do
      req
      expect(json.dig(:items, 0, :stats)).to eq(
        "dishes" => { "active" => 1, "inactive" => 2 },
        "children" => { "active" => 1 }
      )
    end
  end
end
