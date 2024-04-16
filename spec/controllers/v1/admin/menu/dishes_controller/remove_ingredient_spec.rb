# frozen_string_literal: true

require "rails_helper"

RSpec.describe V1::Admin::Menu::DishesController do
  include_context CONTROLLER_UTILS_CONTEXT
  include_context CONTROLLER_AUTHENTICATION_CONTEXT
  include_context TESTS_OPTIMIZATIONS_CONTEXT

  let(:instance) { described_class.new }

  describe "#remove_ingredient" do
    subject { req }

    before { dish.ingredients << ingredient }

    let!(:ingredient) { create(:menu_ingredient) }
    let!(:dish) { create(:menu_dish) }

    it { expect(instance).to respond_to(:remove_ingredient) }

    it {
      expect(subject).to route(:delete, "/v1/admin/menu/dishes/22/ingredients/55").to(format: :json, action: :remove_ingredient,
                                                                                      controller: "v1/admin/menu/dishes", id: 22, ingredient_id: 55)
    }

    def req(dish_id = dish.id, ingredient_id = ingredient.id, params = {})
      post :remove_ingredient, params: params.merge(id: dish_id, ingredient_id:)
    end

    it { expect(dish.ingredients.count).to be_positive }

    context "when user is not authenticated" do
      before { req }

      it_behaves_like UNAUTHORIZED
    end

    context "[user is authenticated]" do
      before do
        authenticate_request(user: create(:user))
      end

      it { is_expected.to be_successful }
      it { is_expected.to have_http_status(:ok) }
      it { expect { subject }.to change { dish.reload.ingredients.count }.by(-1) }
      it { expect { subject }.to change { Menu::IngredientsInDish.count }.by(-1) }

      context "when removing non-existing ingredient" do
        subject { response }

        before { req(dish.id, 999_999_999) }

        it_behaves_like NOT_FOUND
      end

      context "when removing ingredient from non-existing dish" do
        subject { response }

        before { req(999_999_999) }

        it_behaves_like NOT_FOUND
      end

      context "when removing first ingredient, all next should change position to adapt." do
        let!(:ingredient0) { ingredient } # already added
        let!(:ingredient1) { create(:menu_ingredient) }
        let!(:ingredient2) { create(:menu_ingredient) }

        before do
          dish.ingredients << ingredient1
          dish.ingredients << ingredient2
        end

        context "checking mock data" do
          it { expect(dish.ingredients.count).to eq 3 }
        end

        it do
          req
          expect(parsed_response_body).not_to include(message: String)
          expect(response).to have_http_status(:ok)
        end

        it do
          expect { req(dish.id, ingredient0.id) }.to change { Menu::IngredientsInDish.order(:index).pluck(:menu_ingredient_id) }.from([
                                                                                                                                        ingredient0.id,
                                                                                                                                        ingredient1.id,
                                                                                                                                        ingredient2.id
                                                                                                                                      ]).to([
                                                                                                                                              ingredient1.id,
                                                                                                                                              ingredient2.id
                                                                                                                                            ])
        end

        it do
          expect { req(dish.id, ingredient0.id) }.to change { Menu::IngredientsInDish.order(:index).pluck(:index) }.from([0, 1, 2]).to([0, 1])
        end
      end
    end
  end
end