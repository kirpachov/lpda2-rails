# frozen_string_literal: true

require "rails_helper"

RSpec.shared_context "PATCH /v1/admin/menu/dishes/relocate FAILURE" do
  it { expect { req }.not_to(change { Menu::DishesInCategory.all.as_json }) }
  it { expect { req }.not_to(change { Menu::Dish.all.as_json }) }
  it { expect { req }.not_to(change { Menu::Category.all.as_json }) }

  it do
    req
    expect(response).to have_http_status(:unprocessable_entity)
  end

  it do
    req
    expect(json).to include(message: String)
  end
end

RSpec.shared_context "PATCH /v1/admin/menu/dishes/relocate SUCCESS" do
  it { expect { req }.to(change { Menu::DishesInCategory.all.as_json }) }
  it { expect { req }.not_to(change { Menu::Dish.all.as_json }) }
  it { expect { req }.not_to(change { Menu::Category.all.as_json }) }

  it do
    req
    expect(response).to have_http_status(:ok)
  end

  it do
    req
    expect(json).not_to include(message: String)
  end

  it do
    req
    expect(json).to include(ok: true)
  end
end

RSpec.describe "PATCH /v1/admin/menu/dishes/relocate" do
  include_context REQUEST_AUTHENTICATION_CONTEXT

  let(:default_headers) { auth_headers }
  let(:from_category) { create(:menu_category) }
  let(:to_category) { create(:menu_category) }
  let(:from_category_id) { from_category.id }
  let(:to_category_id) { to_category.id }
  let(:dishes) do
    create_list(:menu_dish, 3).tap do |dishes|
      dishes.each { |dish| from_category.dishes << dish }
    end
  end

  let(:dish_ids) { dishes.map(&:id) }
  let!(:default_params) { { from_category_id:, to_category_id:, dish_ids: } }

  def req(params: default_params, headers: default_headers)
    patch "/v1/admin/menu/dishes/relocate", headers:, params:
  end

  context "when not authenticated" do
    let(:default_headers) { {} }

    before { req }

    it { expect(response).to have_http_status(:unauthorized) }

    it { expect(json).to include(message: String) }
  end

  context "when from category is missing, will add dishes to 'to_category' without removing from 'from_category'" do
    let!(:default_params) { super().except(:from_category_id) }

    it { expect { req }.to(change { Menu::DishesInCategory.count }.by(dishes.count)) }

    include_context "PATCH /v1/admin/menu/dishes/relocate SUCCESS"
  end

  context "when to category is missing, will remove dishes from 'from_category'" do
    let!(:default_params) { super().except(:to_category_id) }

    it { expect { req }.to(change { Menu::DishesInCategory.count }.by(dishes.count * -1)) }

    include_context "PATCH /v1/admin/menu/dishes/relocate SUCCESS"
  end

  context "when dish_ids is missing" do
    let!(:default_params) { super().merge(dish_ids: nil) }

    include_context "PATCH /v1/admin/menu/dishes/relocate FAILURE"
  end

  context "when from category does not exist" do
    let!(:default_params) { super().merge(from_category_id: -1) }

    include_context "PATCH /v1/admin/menu/dishes/relocate FAILURE"
  end

  context "when to category does not exist" do
    let!(:default_params) { super().merge(to_category_id: -1) }

    include_context "PATCH /v1/admin/menu/dishes/relocate FAILURE"
  end

  context "dishes may be partially present in to_category. Avoid adding twice." do
    before do
      to_category.dishes << dishes.first
    end

    it do
      expect(dishes.first.categories.map(&:id)).to match_array([from_category.id, to_category.id])
    end

    it { expect { req }.to(change { Menu::DishesInCategory.where(dish: dishes.first).count }.by(-1)) }

    include_context "PATCH /v1/admin/menu/dishes/relocate SUCCESS"
  end

  context "when dish_ids is empty" do
    let!(:default_params) { super().merge(dish_ids: []) }

    include_context "PATCH /v1/admin/menu/dishes/relocate FAILURE"
  end

  context "when one of the dish_ids does not exist" do
    let!(:default_params) { super().merge(dish_ids: [*dish_ids, -1]) }

    include_context "PATCH /v1/admin/menu/dishes/relocate FAILURE"
  end

  context "when one of the dish_ids is not in from_category" do
    before do
      dishes.first.categories = []
    end

    let!(:default_params) { super().merge(dish_ids: [dishes.first.id]) }

    include_context "PATCH /v1/admin/menu/dishes/relocate FAILURE"
  end

  context "when instead of dish_ids, is passed a single dish_id" do
    let!(:default_params) { super().merge(dish_ids: dishes.first.id) }

    it { expect { req }.not_to(change { Menu::DishesInCategory.count }) }
    it { expect { req }.to(change { Menu::DishesInCategory.all.where(menu_dish: dishes.first).pluck(:menu_category_id) }.from([from_category.id]).to([to_category.id])) }

    include_context "PATCH /v1/admin/menu/dishes/relocate SUCCESS"
  end

  [
    { default: :dish_ids, variants: [:dish_ids, :dish_id, :dish_ids, :dishes, :dish] }
  ].each do |params_options|
    params_options[:variants].each do |variant|
      context "when #{params_options[:default]} is called #{variant}" do
        let!(:default_params) { super().merge(params_options[:default] => nil, variant => dishes.map(&:id)) }

        include_context "PATCH /v1/admin/menu/dishes/relocate SUCCESS"
      end
    end
  end
end
