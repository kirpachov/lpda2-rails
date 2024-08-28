# frozen_string_literal: true

require "rails_helper"

RSpec.describe V1::Menu::IngredientsController, type: :controller do
  include_context CONTROLLER_UTILS_CONTEXT
  include_context TESTS_OPTIMIZATIONS_CONTEXT

  let(:instance) { described_class.new }

  describe "#index" do
    it { expect(instance).to respond_to(:index) }

    it do
      expect(subject).to route(:get, "/v1/menu/ingredients").to(format: :json, action: :index,
                                                                controller: "v1/menu/ingredients")
    end

    def req(params = {})
      get :index, params:
    end

    it { expect(req).to be_successful }

    context "when there are no ingredients" do
      before { req }

      it { expect(parsed_response_body).to include(items: []) }
      it { expect(parsed_response_body).to include(metadata: Hash) }
    end

    context "when there are some ingredients" do
      before do
        create_list(:menu_ingredient, 5)
        req
      end

      it { expect(parsed_response_body).to include(items: Array) }
      it { expect(parsed_response_body).to include(metadata: Hash) }
      it { expect(parsed_response_body[:items].size).to eq(5) }

      context "checking items structure" do
        subject { parsed_response_body[:items].sample }

        it { is_expected.to include(id: Integer) }
        it { is_expected.to include(name: String) }
        it { is_expected.to include(description: String) }
      end
    end

    context "when ingredients have image" do
      before do
        create(:menu_ingredient).image = create(:image, :with_attached_image)
        req
      end

      context "checking image structure" do
        subject { parsed_response_body[:items].sample[:image] }

        it { is_expected.to include(id: Integer) }
        it { is_expected.to include(url: String) }
        it { is_expected.to include(filename: String) }
      end
    end

    context "when filtering by name" do
      let(:name) { "first" }
      let!(:menu_ingredient) { create(:menu_ingredient, name:, description: nil) }

      before do
        create(:menu_ingredient, name: "second", description: nil)
      end

      context "checking mock data" do
        it { expect(Menu::Ingredient.count).to eq(2) }
        it { expect(Menu::Ingredient.where_name(name).count).to eq(1) }
      end

      context "when filtering by name {query: <name>}" do
        subject { parsed_response_body[:items] }

        before { req(query: name) }

        it { is_expected.to be_an(Array) }
        it { is_expected.to include(include(id: menu_ingredient.id)) }
        it { expect(subject.size).to eq 1 }
      end
    end

    context "when filtering by description" do
      let(:description) { "first" }
      let!(:menu_ingredient) { create(:menu_ingredient, name: nil, description:) }

      before do
        create(:menu_ingredient, name: nil, description: "second")
      end

      context "checking mock data" do
        it { expect(Menu::Ingredient.count).to eq(2) }
        it { expect(Menu::Ingredient.where_description(description).count).to eq(1) }
      end

      context "when filtering by description {query: <description>}" do
        subject { parsed_response_body[:items] }

        before { req(query: description) }

        it { is_expected.to be_an(Array) }
        it { is_expected.to include(include(id: menu_ingredient.id)) }
        it { expect(subject.size).to eq 1 }
      end
    end

    context "when not filtering by status" do
      subject do
        req
        parsed_response_body[:items]
      end

      before do
        Menu::Ingredient.delete_all
        create(:menu_ingredient, status: :active)
        create(:menu_ingredient, status: :deleted)
      end

      it { expect(Menu::Ingredient.count).to eq 2 }
      it { expect(Menu::Ingredient.visible.count).to eq 1 }
      it { expect(subject.size).to eq 1 }
      it { expect(subject).to all(include(status: "active")) }
      it { expect(response).to be_successful }
    end

    context "when filtering by status {status: :active}" do
      subject do
        req(status: :active)
        parsed_response_body[:items]
      end

      before do
        Menu::Ingredient.delete_all
        create(:menu_ingredient, status: :active)
        create(:menu_ingredient, status: :deleted)
      end

      it { expect(Menu::Ingredient.count).to eq 2 }
      it { expect(Menu::Ingredient.visible.count).to eq 1 }
      it { expect(subject.size).to eq 1 }
      it { expect(subject.first[:status]).to eq "active" }
    end

    context "when filtering by status {status: :deleted}" do
      subject do
        req(status: :deleted)
        parsed_response_body[:items]
      end

      before do
        Menu::Ingredient.delete_all
        create(:menu_ingredient, status: :active)
        create(:menu_ingredient, status: :deleted)
      end

      it { expect(Menu::Ingredient.count).to eq 2 }
      it { expect(Menu::Ingredient.visible.count).to eq 1 }
      it { is_expected.to be_empty }
    end

    context "when providing {avoid_associated_dish_id: <DishId>}" do
      let(:dish) { create(:menu_dish) }

      before do
        create_list(:menu_ingredient, 3)
        dish.ingredients = [Menu::Ingredient.all.sample]
        req(avoid_associated_dish_id: dish.id)
        create(:menu_dish).ingredients = Menu::Ingredient.all
      end

      it { expect(response).to have_http_status(:ok) }
      it { expect(parsed_response_body).not_to include(message: String) }
      it { expect(parsed_response_body[:items].count).to eq 2 }
    end

    context "when providing {associated_dish_id: <DishId>}" do
      let(:dish) { create(:menu_dish) }

      before do
        create_list(:menu_ingredient, 3)
        dish.ingredients = [Menu::Ingredient.all.sample]
        req(associated_dish_id: dish.id)
        create(:menu_dish).ingredients = Menu::Ingredient.all
      end

      it { expect(response).to have_http_status(:ok) }
      it { expect(parsed_response_body).not_to include(message: String) }
      it { expect(parsed_response_body[:items].count).to eq 1 }
      it { expect(parsed_response_body.dig(:items, 0, :id)).to eq dish.ingredients.first.id }
    end
  end

  describe "#show" do
    let(:menu_ingredient) { create(:menu_ingredient) }

    it { expect(instance).to respond_to(:show) }

    it {
      expect(subject).to route(:get, "/v1/menu/ingredients/1").to(format: :json, action: :show,
                                                                  controller: "v1/menu/ingredients", id: 1)
    }

    def req(id, params = {})
      get :show, params: params.merge(id:)
    end

    it { expect(req(menu_ingredient.id)).to be_successful }

    context "when item does not exist" do
      subject { response }

      before { req(999_999_999) }

      it_behaves_like NOT_FOUND
    end

    context "when item exists" do
      subject { parsed_response_body[:item] }

      before { req(menu_ingredient.id) }

      it { is_expected.to include(id: menu_ingredient.id) }
      it { is_expected.to include(name: menu_ingredient.name) }
      it { is_expected.to include(description: menu_ingredient.description) }
    end
  end
end
