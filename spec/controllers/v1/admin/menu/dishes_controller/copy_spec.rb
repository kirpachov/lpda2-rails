# frozen_string_literal: true

require "rails_helper"

RSpec.describe V1::Admin::Menu::DishesController do
  include_context CONTROLLER_UTILS_CONTEXT
  include_context CONTROLLER_AUTHENTICATION_CONTEXT
  include_context TESTS_OPTIMIZATIONS_CONTEXT

  let(:instance) { described_class.new }

  describe "#copy" do
    subject { req(dish.id) }

    let!(:dish) { create(:menu_dish) }

    it { expect(instance).to respond_to(:copy) }

    it {
      expect(subject).to route(:post, "/v1/admin/menu/dishes/22/copy").to(format: :json, action: :copy,
                                                                          controller: "v1/admin/menu/dishes", id: 22)
    }

    def req(id, params = {})
      post :copy, params: params.merge(id:)
    end

    context "when user is not authenticated" do
      before { req(dish.id, name: Faker::Lorem.sentence) }

      it_behaves_like UNAUTHORIZED
    end

    context "[user is authenticated]" do
      before do
        authenticate_request(user: create(:user))
      end

      it { is_expected.to be_successful }

      it { expect { subject }.to change(Menu::Dish, :count).by(1) }

      context "when item does not exist" do
        subject { response }

        before { req(999_999_999) }

        it_behaves_like NOT_FOUND
      end

      context "when providing {category_id: <Menu::Category#id>}" do
        subject { req(dish.id, category_id: category.id) }

        let!(:category) { create(:menu_category) }

        it { expect { subject }.to change(Menu::DishesInCategory, :count).by(1) }
        it { expect { subject }.to change(Menu::Dish, :count).by(1) }
        it { expect { subject }.to(change { category.reload.dishes.count }.by(1)) }
        it do
          subject
          expect(parsed_response_body).not_to include(message: String)
        end

        it do
          subject
          expect(response).to have_http_status(:ok)
        end
      end

      context "when dish has images" do
        let!(:images) { create_list(:image, 3, :with_attached_image) }

        before { dish.images = images }

        it { expect(dish.images.map(&:id)).to match_array(images.map(&:id)) }
        it { expect(dish.images.count).to be_positive }

        context 'and providing {copy_images: "full"}' do
          subject { req(dish.id, { copy_images: "full" }) }

          it { is_expected.to be_successful }
          it { is_expected.to have_http_status(:ok) }

          it { expect { subject }.to change(Image, :count).by(images.count) }
          it { expect { subject }.to change(ImageToRecord, :count).by(images.count) }

          context "[after req]" do
            before { subject }

            let(:result) { Menu::Dish.find(parsed_response_body.dig(:item, :id)) }

            it { expect(parsed_response_body).to include(item: Hash) }
            it { expect(result.images.count).to eq(images.count) }
            it { expect(result.images.map(&:id)).not_to match_array(images.map(&:id)) }
          end
        end

        context 'and providing {copy_images: "link"}' do
          subject { req(dish.id, { copy_images: "link" }) }

          it { expect { subject }.not_to(change(Image, :count)) }
          it { expect { subject }.to change(ImageToRecord, :count).by(images.count) }

          context "[after req]" do
            before { subject }

            let(:result) { Menu::Dish.find(parsed_response_body.dig(:item, :id)) }

            it { expect(result.images.count).to eq(images.count) }
          end
        end

        context 'and providing {copy_images: "none"}' do
          subject { req(dish.id, { copy_images: "none" }) }

          it { expect { subject }.not_to(change(Image, :count)) }
          it { expect { subject }.not_to(change(ImageToRecord, :count)) }

          context "[after req]" do
            before { subject }

            let(:result) { Menu::Dish.find(parsed_response_body.dig(:item, :id)) }

            it { expect(result.images.count).to eq(0) }
          end
        end
      end

      context "when dish has ingredients" do
        let!(:ingredients) { create_list(:menu_ingredient, 3) }

        before { dish.ingredients = ingredients }

        it { expect(dish.ingredients.map(&:id)).to match_array(ingredients.map(&:id)) }
        it { expect(dish.ingredients.count).to be_positive }

        context 'and providing {copy_ingredients: "full"}' do
          subject { req(dish.id, { copy_ingredients: "full" }) }

          it { is_expected.to be_successful }
          it { is_expected.to have_http_status(:ok) }

          it { expect { subject }.to change(Menu::Ingredient, :count).by(ingredients.count) }
          it { expect { subject }.to change(Menu::IngredientsInDish, :count).by(ingredients.count) }

          context "[after req]" do
            before { subject }

            let(:result) { Menu::Dish.find(parsed_response_body.dig(:item, :id)) }

            it { expect(parsed_response_body).to include(item: Hash) }
            it { expect(result.ingredients.count).to eq(ingredients.count) }
            it { expect(result.ingredients.map(&:id)).not_to match_array(ingredients.map(&:id)) }
          end
        end

        context 'and providing {copy_ingredients: "link"}' do
          subject { req(dish.id, { copy_ingredients: "link" }) }

          it { expect { subject }.not_to(change(Menu::Ingredient, :count)) }
          it { expect { subject }.to change(Menu::IngredientsInDish, :count).by(ingredients.count) }

          context "[after req]" do
            before { subject }

            let(:result) { Menu::Dish.find(parsed_response_body.dig(:item, :id)) }

            it { expect(result.ingredients.count).to eq(ingredients.count) }
          end
        end

        context 'and providing {copy_ingredients: "none"}' do
          subject { req(dish.id, { copy_ingredients: "none" }) }

          it { expect { subject }.not_to(change(Menu::Ingredient, :count)) }
          it { expect { subject }.not_to(change(Menu::IngredientsInDish, :count)) }

          context "[after req]" do
            before { subject }

            let(:result) { Menu::Dish.find(parsed_response_body.dig(:item, :id)) }

            it { expect(result.ingredients.count).to eq(0) }
          end
        end
      end

      context "when dish has allergens" do
        let!(:allergens) { create_list(:menu_allergen, 3) }

        before { dish.allergens = allergens }

        it { expect(dish.allergens.map(&:id)).to match_array(allergens.map(&:id)) }
        it { expect(dish.allergens.count).to be_positive }

        context 'and providing {copy_allergens: "full"}' do
          subject { req(dish.id, { copy_allergens: "full" }) }

          it { is_expected.to be_successful }
          it { is_expected.to have_http_status(:ok) }

          it { expect { subject }.to change(Menu::Allergen, :count).by(allergens.count) }
          it { expect { subject }.to change(Menu::AllergensInDish, :count).by(allergens.count) }

          context "[after req]" do
            before { subject }

            let(:result) { Menu::Dish.find(parsed_response_body.dig(:item, :id)) }

            it { expect(parsed_response_body).to include(item: Hash) }
            it { expect(result.allergens.count).to eq(allergens.count) }
            it { expect(result.allergens.map(&:id)).not_to match_array(allergens.map(&:id)) }
          end
        end

        context 'and providing {copy_allergens: "link"}' do
          subject { req(dish.id, { copy_allergens: "link" }) }

          it { expect { subject }.not_to(change(Menu::Allergen, :count)) }
          it { expect { subject }.to change(Menu::AllergensInDish, :count).by(allergens.count) }

          context "[after req]" do
            before { subject }

            let(:result) { Menu::Dish.find(parsed_response_body.dig(:item, :id)) }

            it { expect(result.allergens.count).to eq(allergens.count) }
          end
        end

        context 'and providing {copy_allergens: "none"}' do
          subject { req(dish.id, { copy_allergens: "none" }) }

          it { expect { subject }.not_to(change(Menu::Allergen, :count)) }
          it { expect { subject }.not_to(change(Menu::AllergensInDish, :count)) }

          context "[after req]" do
            before { subject }

            let(:result) { Menu::Dish.find(parsed_response_body.dig(:item, :id)) }

            it { expect(result.allergens.count).to eq(0) }
          end
        end
      end

      context "when dish has tags" do
        let!(:tags) { create_list(:menu_tag, 3) }

        before { dish.tags = tags }

        it { expect(dish.tags.map(&:id)).to match_array(tags.map(&:id)) }
        it { expect(dish.tags.count).to be_positive }

        context 'and providing {copy_tags: "full"}' do
          subject { req(dish.id, { copy_tags: "full" }) }

          it { is_expected.to be_successful }
          it { is_expected.to have_http_status(:ok) }

          it { expect { subject }.to change(Menu::Tag, :count).by(tags.count) }
          it { expect { subject }.to change(Menu::TagsInDish, :count).by(tags.count) }

          context "[after req]" do
            before { subject }

            let(:result) { Menu::Dish.find(parsed_response_body.dig(:item, :id)) }

            it { expect(parsed_response_body).to include(item: Hash) }
            it { expect(result.tags.count).to eq(tags.count) }
            it { expect(result.tags.map(&:id)).not_to match_array(tags.map(&:id)) }
          end
        end

        context 'and providing {copy_tags: "link"}' do
          subject { req(dish.id, { copy_tags: "link" }) }

          it { expect { subject }.not_to(change(Menu::Tag, :count)) }
          it { expect { subject }.to change(Menu::TagsInDish, :count).by(tags.count) }

          context "[after req]" do
            before { subject }

            let(:result) { Menu::Dish.find(parsed_response_body.dig(:item, :id)) }

            it { expect(result.tags.count).to eq(tags.count) }
          end
        end

        context 'and providing {copy_tags: "none"}' do
          subject { req(dish.id, { copy_tags: "none" }) }

          it { expect { subject }.not_to(change(Menu::Tag, :count)) }
          it { expect { subject }.not_to(change(Menu::TagsInDish, :count)) }

          context "[after req]" do
            before { subject }

            let(:result) { Menu::Dish.find(parsed_response_body.dig(:item, :id)) }

            it { expect(result.tags.count).to eq(0) }
          end
        end
      end
    end
  end
end