# frozen_string_literal: true

require "rails_helper"

RSpec.describe V1::Admin::Menu::DishesController do
  include_context CONTROLLER_UTILS_CONTEXT
  include_context CONTROLLER_AUTHENTICATION_CONTEXT
  include_context TESTS_OPTIMIZATIONS_CONTEXT

  let(:instance) { described_class.new }

  describe "#add_ingredient" do
    subject { req }

    let!(:ingredient) { create(:menu_ingredient) }
    let!(:dish) { create(:menu_dish) }

    it { expect(instance).to respond_to(:add_ingredient) }

    it {
      expect(subject).to route(:post, "/v1/admin/menu/dishes/22/ingredients/55").to(format: :json, action: :add_ingredient,
                                                                                    controller: "v1/admin/menu/dishes", id: 22, ingredient_id: 55)
    }

    def req(dish_id = dish.id, ingredient_id = ingredient.id, params = {})
      post :add_ingredient, params: params.merge(id: dish_id, ingredient_id:)
    end

    context "when user is not authenticated" do
      before { req }

      it_behaves_like UNAUTHORIZED
    end

    context "[user is authenticated]" do
      before do
        authenticate_request(user: create(:user))
      end

      it { is_expected.to be_successful }
      it { expect { subject }.to change { dish.reload.ingredients.count }.by(1) }
      it { expect { subject }.to change { Menu::IngredientsInDish.count }.by(1) }
      it { expect { subject }.not_to(change { Menu::Dish.count }) }
      it { expect { subject }.not_to(change { Menu::Ingredient.count }) }

      context "when adding twice same ingredient" do
        before { req }

        it { expect { req }.not_to(change { dish.reload.ingredients.count }) }
        it { expect { req }.not_to(change { Menu::IngredientsInDish.count }) }

        context "[after second request]" do
          before { req }

          it { is_expected.to have_http_status(:unprocessable_entity) }
          it { expect(parsed_response_body).to include(message: String) }
        end
      end

      context "when adding ingredient to non-existing dish" do
        subject { response }

        before { req(999_999_999) }

        it_behaves_like NOT_FOUND
      end

      context "when adding non-existing ingredient to dish" do
        subject { response }

        before { req(dish.id, 999_999_999) }

        it_behaves_like NOT_FOUND
      end

      context "when adding deleted ingredient to dish" do
        subject { response }

        before do
          ingredient.deleted!
          req
        end

        it_behaves_like NOT_FOUND
      end

      context "when providing {copy: true}, should attach a copy of the ingredient" do
        subject do
          req(dish.id, ingredient.id, copy: true)
          response
        end

        it { expect { subject }.to change { dish.reload.ingredients.count }.by(1) }
        it { expect { subject }.to change { Menu::IngredientsInDish.count }.by(1) }
        it { expect { subject }.to change { Menu::Ingredient.count }.by(1) }
        it { expect { subject }.not_to(change { Menu::Dish.count }) }

        context "[after request]" do
          before { subject }

          it { expect(parsed_response_body).not_to include(message: String) }
          it { expect(parsed_response_body).to include(item: Hash) }
          it { expect(dish.reload.ingredients.count).to eq 1 }
          it { expect(dish.reload.ingredients.first.id).not_to eq ingredient.id }
        end

        context "when addition fails, should return 422 and not create any new record" do
          before do
            allow_any_instance_of(Menu::IngredientsInDish).to receive(:valid?).and_return(false)
            req(dish.id, ingredient.id, copy: true)
          end

          it { is_expected.to have_http_status(:unprocessable_entity) }
          it { expect(parsed_response_body).to include(message: String) }
          it { expect { subject }.not_to(change { dish.reload.ingredients.count }) }
          it { expect { subject }.not_to(change { Menu::IngredientsInDish.count }) }
          it { expect { subject }.not_to(change { Menu::Ingredient.count }) }
        end
      end
    end
  end
end