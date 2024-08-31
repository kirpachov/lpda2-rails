# frozen_string_literal: true

require "rails_helper"

RSpec.describe V1::Menu::DishesController do
  include_context CONTROLLER_UTILS_CONTEXT
  include_context TESTS_OPTIMIZATIONS_CONTEXT

  let(:instance) { described_class.new }

  describe "#index" do
    it { expect(instance).to respond_to(:index) }

    it do
      expect(subject).to route(:get, "/v1/menu/dishes").to(format: :json, action: :index,
                                                           controller: "v1/menu/dishes")
    end

    def req(params = {})
      get :index, params:
    end

    it { expect(req).to be_successful }

    context "when requiring all informations with { include_all: true }" do
      let!(:dish) do
        create(:menu_dish, :with_name, :with_description, :with_images,
                           :with_allergens, :with_tags, :with_ingredients, :with_suggestions
                           ).tap do |d|
          image = create(:image, :with_attached_image)
          d.allergens.map{ |a| a.image = image }
          d.tags.map{ |a| a.image = image }
          d.ingredients.map{ |a| a.image = image }
        end
      end

      before { req(id: dish.id, include_all: true) }

      # Checking mock data
      it { expect(Menu::Dish.count).to eq 1 + dish.suggestions.count }
      # it { expect(Menu::Dish.first.id).to eq dish.id }
      it { expect(dish.allergens.count).to be_positive }
      it { expect(dish.ingredients.count).to be_positive }
      it { expect(dish.tags.count).to be_positive }
      it { expect(dish.images.count).to be_positive }
      it { expect(dish.suggestions.count).to be_positive }

      it { expect(response).to have_http_status(:ok) }
      it { expect(json).to include(items: Array) }
      it { expect(json).to include(metadata: Hash) }
      it { expect(json[:items].count).to eq 1 }

      context "when checking first element structure" do
        subject(:item) { json["items"].first.symbolize_keys }

        it { expect(item).to include(id: dish.id) }
        it { expect(item).to include(price: dish.price) }
        it { expect(item).to include(status: dish.status) }
        it { expect(item).to include(translations: Hash) }

        it { expect(item).to include(images: Array) }
        it { expect(item[:images]).to be_present }
        it { expect(item[:images]).to all(be_a(Hash)) }
        it { expect(item[:images].map(&:symbolize_keys)).to all(include(id: Integer, filename: String, status: String, tag: nil, original_id: nil, key: nil, url: String, updated_at: String, created_at: String)) }
        it { expect(item[:images].sample.keys.map(&:to_s)).not_to include("member_id") }
        it { expect(item[:images].sample.keys.map(&:to_s)).not_to include("other") }

        %i[allergens tags ingredients suggestions].each do |field|
          context "should include #{field} field" do
            it { expect(item).to include(field => Array) }
            it { expect(item[field]).to be_present }
            it { expect(item[field]).to all(be_a(Hash)) }
            it { expect(item[field].map(&:symbolize_keys)).to all(include(id: Integer, name: String, description: String, created_at: String, updated_at: String)) }
            it { expect(item[field].sample.keys.map(&:to_s)).not_to include("member_id") }
            it { expect(item[field].sample.keys.map(&:to_s)).not_to include("other") }
          end
        end

        it { expect(item[:allergens].map(&:symbolize_keys)).to all(include(image: Hash)) }
        it { expect(item[:ingredients].map(&:symbolize_keys)).to all(include(image: Hash)) }
        it { expect(item[:tags].map(&:symbolize_keys)).to all(include(image: Hash, color: String)) }
        it { expect(item[:suggestions].map(&:symbolize_keys)).to all(include(id: Integer, images: Array, name: String, description: String)) }
      end
    end

    context "when there are no dishes" do
      before { req }

      it { expect(parsed_response_body).to include(items: []) }
      it { expect(parsed_response_body).to include(metadata: Hash) }
    end

    context "when there are some dishes" do
      before do
        create_list(:menu_dish, 5, :with_name, :with_description)
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
        it { is_expected.to include(images: Array) }
      end
    end

    context "when filtering by category_id" do
      let!(:category) do
        create(:menu_category).tap do |cat|
          cat.dishes << create(:menu_dish)
        end
      end

      before do
        create(:menu_category).dishes << create(:menu_dish)
      end

      context "checking mock data" do
        it { expect(Menu::Dish.count).to be >= 2 }
        it { expect(Menu::Category.count).to be >= 2 }
        it { expect(category.dishes.count).to eq 1 }
      end

      context "when {category_id: <id>}" do
        subject { parsed_response_body }

        before { req(category_id: category.id) }

        it { expect(response).to have_http_status(:ok) }

        it do
          expect(subject).not_to include(message: String)
          expect(subject).to include(items: Array)
          expect(subject[:items].count).to eq 1
        end
      end
    end

    context "when dishes have images" do
      before do
        create(:menu_dish).images = [create(:image, :with_attached_image)]
        req
      end

      context "checking images structure" do
        subject { parsed_response_body[:items].sample[:images].sample }

        it { is_expected.to include(id: Integer) }
        it { is_expected.to include(url: String) }
        it { is_expected.to include(filename: String) }
      end
    end

    context "when filtering by name" do
      let(:name) { "first" }
      let!(:menu_dish) { create(:menu_dish, name:, description: nil) }

      before do
        create(:menu_dish, name: "second", description: nil)
      end

      context "checking mock data" do
        it { expect(Menu::Dish.count).to eq(2) }
        it { expect(Menu::Dish.where_name(name).count).to eq(1) }
      end

      context "when filtering by name {query: <name>}" do
        subject { parsed_response_body[:items] }

        before { req(query: name) }

        it { is_expected.to be_an(Array) }
        it { is_expected.to include(include(id: menu_dish.id)) }
        it { expect(subject.size).to eq 1 }
      end
    end

    context "when filtering by description" do
      let(:description) { "first" }
      let!(:menu_dish) { create(:menu_dish, name: nil, description:) }

      before do
        create(:menu_dish, name: nil, description: "second")
      end

      context "checking mock data" do
        it { expect(Menu::Dish.count).to eq(2) }
        it { expect(Menu::Dish.where_description(description).count).to eq(1) }
      end

      context "when filtering by description {query: <description>}" do
        subject { parsed_response_body[:items] }

        before { req(query: description) }

        it { is_expected.to be_an(Array) }
        it { is_expected.to include(include(id: menu_dish.id)) }
        it { expect(subject.size).to eq 1 }
      end
    end

    context "when filtering by status {status: :active}" do
      subject do
        req(status: :active)
        parsed_response_body[:items]
      end

      before do
        Menu::Dish.delete_all
        create(:menu_dish, status: :active)
        create(:menu_dish, status: :deleted)
      end

      it { expect(Menu::Dish.count).to eq 2 }
      it { expect(Menu::Dish.visible.count).to eq 1 }
      it { expect(subject.size).to eq 1 }
      it { expect(subject.first[:status]).to eq "active" }
    end

    context "when filtering by status {status: :deleted}" do
      subject do
        req(status: :deleted)
        parsed_response_body[:items]
      end

      before do
        Menu::Dish.delete_all
        create(:menu_dish, status: :active)
        create(:menu_dish, status: :deleted)
      end

      it { expect(Menu::Dish.count).to eq 2 }
      it { expect(Menu::Dish.visible.count).to eq 1 }
      it { is_expected.to be_empty }
    end

    context "when filtering by price {price: 15}" do
      subject do
        req(price: 15)
        parsed_response_body[:items]
      end

      before do
        Menu::Dish.delete_all
        create(:menu_dish, price: 15)
        create(:menu_dish, price: 15)
        create(:menu_dish, price: 16)
      end

      it { expect(Menu::Dish.count).to eq 3 }
      it { expect(Menu::Dish.pluck(:price).uniq).to contain_exactly(15, 16) }
      it { expect(subject.size).to eq 2 }
      it { is_expected.to all(include(price: 15)) }
    end

    context 'when filtering by price {price: "15.5"}' do
      subject do
        req(price: "15.5")
        parsed_response_body[:items]
      end

      before do
        Menu::Dish.delete_all
        create(:menu_dish, price: 15)
        create(:menu_dish, price: 15)
        create(:menu_dish, price: 16)
      end

      it { expect(Menu::Dish.count).to eq 3 }
      it { expect(Menu::Dish.pluck(:price).uniq).to contain_exactly(15, 16) }
      it { expect(subject.size).to eq 0 }
    end

    context 'when filtering by price {price: "15.5"}' do
      subject do
        req(price: "15.5")
        parsed_response_body[:items]
      end

      before do
        Menu::Dish.delete_all
        create(:menu_dish, price: 15.5)
        create(:menu_dish, price: 15)
        create(:menu_dish, price: 16)
      end

      it { expect(Menu::Dish.count).to eq 3 }
      it { expect(Menu::Dish.pluck(:price).uniq).to contain_exactly(15.5, 15, 16) }
      it { expect(subject.size).to eq 1 }
      it { is_expected.to all(include(price: 15.5)) }
    end

    context "when filtering by price {price: 15.5}" do
      subject do
        req(price: 15.5)
        parsed_response_body[:items]
      end

      before do
        Menu::Dish.delete_all
        create(:menu_dish, price: 15.5)
        create(:menu_dish, price: 15)
        create(:menu_dish, price: 16)
      end

      it { expect(Menu::Dish.count).to eq 3 }
      it { expect(Menu::Dish.pluck(:price).uniq).to contain_exactly(15, 15.5, 16) }
      it { expect(subject.size).to eq 1 }
      it { is_expected.to all(include(price: 15.5)) }
    end

    context "when filtering by price {price: {less_than: 10}" do
      subject do
        req(price: { less_than: 10 })
        parsed_response_body[:items]
      end

      before do
        Menu::Dish.delete_all
        create(:menu_dish, price: 8)
        create(:menu_dish, price: 10)
        create(:menu_dish, price: 12)
      end

      it { expect(Menu::Dish.count).to eq 3 }
      it { expect(Menu::Dish.pluck(:price).uniq).to contain_exactly(8, 10, 12) }
      it { expect(subject.size).to eq 2 }
      it { is_expected.to all(include(price: Numeric)) }
      it { expect(subject.pluck(:price)).to contain_exactly(8, 10) }
    end

    context "when filtering by price {price: {more_than: 10}" do
      subject do
        req(price: { more_than: 10 })
        parsed_response_body[:items]
      end

      before do
        Menu::Dish.delete_all
        create(:menu_dish, price: 8)
        create(:menu_dish, price: 10)
        create(:menu_dish, price: 12)
      end

      it { expect(Menu::Dish.count).to eq 3 }
      it { expect(Menu::Dish.pluck(:price).uniq).to contain_exactly(8, 10, 12) }
      it { expect(subject.size).to eq 2 }
      it { is_expected.to all(include(price: Numeric)) }
      it { expect(subject.pluck(:price)).to contain_exactly(10, 12) }
    end

    context "when filtering by price {price: {more_than: 10.1}" do
      subject do
        req(price: { more_than: 10.1 })
        parsed_response_body[:items]
      end

      before do
        Menu::Dish.delete_all
        create(:menu_dish, price: 8)
        create(:menu_dish, price: 10)
        create(:menu_dish, price: 12)
      end

      it { expect(Menu::Dish.count).to eq 3 }
      it { expect(Menu::Dish.pluck(:price).uniq).to contain_exactly(8, 10, 12) }
      it { expect(subject.size).to eq 1 }
      it { is_expected.to all(include(price: 12)) }
    end

    context 'when filtering by price {price: {more_than: "10.1"}' do
      subject do
        req(price: { more_than: "10.1" })
        parsed_response_body[:items]
      end

      before do
        Menu::Dish.delete_all
        create(:menu_dish, price: 8)
        create(:menu_dish, price: 10)
        create(:menu_dish, price: 12)
      end

      it { expect(Menu::Dish.count).to eq 3 }
      it { expect(Menu::Dish.pluck(:price).uniq).to contain_exactly(8, 10, 12) }
      it { expect(subject.size).to eq 1 }
      it { is_expected.to all(include(price: 12)) }
    end

    context 'when filtering by price {price: {more_than: "10", less_than: "12"}' do
      subject do
        req(price: { more_than: "10", less_than: "12" })
        parsed_response_body[:items]
      end

      before do
        Menu::Dish.delete_all
        create(:menu_dish, price: 8)
        create(:menu_dish, price: 10)
        create(:menu_dish, price: 12)
        create(:menu_dish, price: 14)
      end

      it { expect(Menu::Dish.count).to eq 4 }
      it { expect(Menu::Dish.pluck(:price).uniq).to contain_exactly(8, 10, 12, 14) }
      it { expect(subject.size).to eq 2 }
      it { expect(subject.pluck(:price)).to contain_exactly(10, 12) }
    end

    context 'when filtering by price {price: {more_than: "10", less_than: 11.9}' do
      subject do
        req(price: { more_than: "10", less_than: 11.9 })
        parsed_response_body[:items]
      end

      before do
        Menu::Dish.delete_all
        create(:menu_dish, price: 8)
        create(:menu_dish, price: 10)
        create(:menu_dish, price: 12)
        create(:menu_dish, price: 14)
      end

      it { expect(Menu::Dish.count).to eq 4 }
      it { expect(Menu::Dish.pluck(:price).uniq).to contain_exactly(8, 10, 12, 14) }
      it { expect(subject.size).to eq 1 }
      it { expect(subject.pluck(:price)).to contain_exactly(10) }
    end

    context "when a dish is shared by two categories and filtering for that category_id" do
      let(:category0) { create(:menu_category) }
      let(:category1) { create(:menu_category) }
      let(:dish) { create(:menu_dish) }

      before do
        category0.dishes << dish
        category1.dishes << dish
        create(:menu_category).dishes << create(:menu_dish)
      end

      context "checking mock data" do
        it { expect(Menu::Dish.count).to eq 2 }
        it { expect(Menu::Category.count).to eq 3 }
        it { expect(category0.dishes.count).to eq 1 }
        it { expect(category1.dishes.count).to eq 1 }
      end

      it do
        req(category_id: category0.id)
        expect(parsed_response_body[:items].count).to eq 1
        expect(parsed_response_body[:items]).to all(include(id: dish.id))
      end
    end

    context "when a category has two dishes and filtering for category_id" do
      let(:category) { create(:menu_category) }
      let(:dish0) { create(:menu_dish) }
      let(:dish1) { create(:menu_dish) }

      before do
        category.dishes << dish0
        category.dishes << dish1
        create(:menu_category).dishes << create(:menu_dish)
        create(:menu_category).dishes << create(:menu_dish)
      end

      context "checking mock data" do
        it { expect(Menu::Dish.count).to eq 4 }
        it { expect(Menu::Category.count).to eq 3 }
        it { expect(category.dishes.count).to eq 2 }
      end

      it do
        req(category_id: category.id)
        expect(parsed_response_body[:items].count).to eq 2
        expect(parsed_response_body[:items].pluck(:id)).to contain_exactly(dish0.id, dish1.id)
      end
    end

    context "when filtering by {price_not: \"\"}" do
      let!(:dish0) { create(:menu_dish, price: 15) }
      let!(:dish1) { create(:menu_dish, price: nil) }
      let!(:dish2) { create(:menu_dish, price: 0) }

      before do
        req(price_not: "")
      end

      it do
        expect(parsed_response_body).not_to include(message: String)
        expect(response).to have_http_status(:ok)
      end

      it do
        expect(parsed_response_body[:items].count).to eq 2
        expect(parsed_response_body[:items].pluck(:id)).to contain_exactly(dish0.id, dish2.id)
      end
    end

    context "when filtering by {price_not: 15}" do
      let!(:dish0) { create(:menu_dish, price: 15) }
      let!(:dish2) { create(:menu_dish, price: 0) }
      let!(:dish3) { create(:menu_dish, price: 25) }
      let!(:dish4) { create(:menu_dish, price: 14.9) }

      before do
        req(price_not: 15)
      end

      it do
        expect(parsed_response_body).not_to include(message: String)
        expect(response).to have_http_status(:ok)
      end

      it do
        expect(parsed_response_body[:items].count).to eq 3
        expect(parsed_response_body[:items].pluck(:id)).to contain_exactly(dish2.id, dish3.id, dish4.id)
      end
    end

    context "when filtering by {price: \"\"}" do
      let!(:dish0) { create(:menu_dish, price: 15) }
      let!(:dish1) { create(:menu_dish, price: nil) }
      let!(:dish2) { create(:menu_dish, price: 0) }

      before do
        req(price: "")
      end

      it do
        expect(parsed_response_body).not_to include(message: String)
        expect(response).to have_http_status(:ok)
      end

      it do
        expect(parsed_response_body[:items].count).to eq 1
        expect(parsed_response_body[:items].first[:id]).to eq dish1.id
      end
    end

    context "when filtering by {price: 15}" do
      let!(:dish0) { create(:menu_dish, price: 15) }
      let!(:dish1) { create(:menu_dish, price: nil) }
      let!(:dish2) { create(:menu_dish, price: 0) }
      let!(:dish3) { create(:menu_dish, price: 25) }

      before do
        req(price: 15)
      end

      it do
        expect(parsed_response_body).not_to include(message: String)
        expect(response).to have_http_status(:ok)
      end

      it do
        expect(parsed_response_body[:items].count).to eq 1
        expect(parsed_response_body[:items].first[:id]).to eq dish0.id
      end
    end

    context "when filtering by {price_more_than: 15}" do
      let!(:dish0) { create(:menu_dish, price: 15) }
      let!(:dish1) { create(:menu_dish, price: nil) }
      let!(:dish2) { create(:menu_dish, price: 0) }
      let!(:dish3) { create(:menu_dish, price: 25) }
      let!(:dish4) { create(:menu_dish, price: 14.9) }

      before do
        req(price_more_than: 15)
      end

      it do
        expect(parsed_response_body).not_to include(message: String)
        expect(response).to have_http_status(:ok)
      end

      it do
        expect(parsed_response_body[:items].count).to eq 2
        expect(parsed_response_body[:items].pluck(:id)).to contain_exactly(dish0.id, dish3.id)
      end
    end

    context "when filtering by {price_less_than: 25}" do
      let!(:dish0) { create(:menu_dish, price: 15) }
      let!(:dish1) { create(:menu_dish, price: nil) }
      let!(:dish2) { create(:menu_dish, price: 0) }
      let!(:dish3) { create(:menu_dish, price: 25) }
      let!(:dish4) { create(:menu_dish, price: 100) }

      before do
        req(price_less_than: 25)
      end

      it do
        expect(parsed_response_body).not_to include(message: String)
        expect(response).to have_http_status(:ok)
      end

      it do
        expect(parsed_response_body[:items].count).to eq 3
        expect(parsed_response_body[:items].pluck(:id)).to contain_exactly(dish0.id, dish3.id, dish2.id)
      end
    end

    context "when filtering by {except: <dish_id>}" do
      let(:dishes) { create_list(:menu_dish, 3) }

      before do
        req(except: dishes.first.id)
      end

      it { expect(response).to have_http_status(:ok) }
      it { expect(parsed_response_body).not_to include(message: String) }
      it { expect(parsed_response_body[:items].pluck(:id)).to match_array(dishes[1..].map(&:id)) }
    end

    context "when filtering by {except: <dish_id>,<dish_id>}" do
      let(:dishes) { create_list(:menu_dish, 3) }

      before do
        req(except: "#{dishes.first.id},#{dishes.second.id}")
      end

      it { expect(response).to have_http_status(:ok) }
      it { expect(parsed_response_body).not_to include(message: String) }
      it { expect(parsed_response_body[:items].pluck(:id)).to match_array(dishes[2..].map(&:id)) }
    end

    context "when filtering by {can_suggest: <dish_id>} will return dishes that can be added as suggestions for the dish with the provided id" do
      let!(:already_suggested) { create_list(:menu_dish, 3) }
      let!(:not_suggested_yet) { create_list(:menu_dish, 3) }
      let!(:deleted_dish) { create(:menu_dish, status: :deleted) }
      let!(:dish) { create(:menu_dish).tap { |d| d.suggestions = already_suggested } }

      before { req(can_suggest: dish.id) }

      it { expect(response).to have_http_status(:ok) }
      it { expect(parsed_response_body).not_to include(message: String) }
      it { expect(parsed_response_body[:items].pluck(:id)).to match_array(not_suggested_yet.map(&:id)) }
    end

    context "when filtering by {except_in_category: <category_id>}, should return all items except those who are added in the provided category id." do
      let!(:dishes) { create_list(:menu_dish, 3) }

      let!(:category) do
        create(:menu_category).tap do |cat|
          cat.dishes << create(:menu_dish)
          cat.dishes << create(:menu_dish)
        end
      end

      before do
        req(except_in_category: category.id)
      end

      it do
        expect(parsed_response_body).not_to include(message: String)
        expect(response).to have_http_status(:ok)
        expect(parsed_response_body.dig(:metadata, :total_count)).to eq 3
      end
    end

    context "when filtering by {except_in_category: \"<category_id>,<category_id>\"}, should return all items except those who are added in the provided category id." do
      let!(:dishes) { create_list(:menu_dish, 3) }

      let!(:category0) do
        create(:menu_category).tap do |cat|
          cat.dishes << create(:menu_dish)
          cat.dishes << create(:menu_dish)
        end
      end

      let!(:category1) do
        create(:menu_category).tap do |cat|
          cat.dishes << create(:menu_dish)
          cat.dishes << create(:menu_dish)
        end
      end

      before do
        req(except_in_category: "#{category0.id},#{category1.id}")
      end

      it do
        expect(parsed_response_body).not_to include(message: String)
        expect(response).to have_http_status(:ok)
        expect(parsed_response_body.dig(:metadata, :total_count)).to eq 3
      end
    end

    context "when filtering for { id: <id> }" do
      let!(:dish) { create(:menu_dish) }
      let!(:dishes) { create_list(:menu_dish, 3) }

      before { req(id: dish.id) }

      it { expect(response).to have_http_status(:ok) }
      it { expect(json).not_to include(message: String) }
      it { expect(json[:items].count).to eq 1 }
      it { expect(json[:items].pluck(:id)).to match_array([dish.id]) }
    end
  end
end
