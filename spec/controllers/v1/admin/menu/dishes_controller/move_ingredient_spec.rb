# frozen_string_literal: true

require "rails_helper"

RSpec.describe V1::Admin::Menu::DishesController do
  include_context CONTROLLER_UTILS_CONTEXT
  include_context CONTROLLER_AUTHENTICATION_CONTEXT
  include_context TESTS_OPTIMIZATIONS_CONTEXT

  let(:instance) { described_class.new }

  describe "#move_ingredient" do
    subject { req }

    before do
      dish.ingredients << ingredient0
      dish.ingredients << ingredient1
      dish.ingredients << ingredient2
    end

    let!(:ingredient0) { create(:menu_ingredient) }
    let!(:ingredient1) { create(:menu_ingredient) }
    let!(:ingredient2) { create(:menu_ingredient) }
    let!(:dish) { create(:menu_dish) }

    it { expect(instance).to respond_to(:move_ingredient) }

    it do
      expect(subject).to route(:patch, "/v1/admin/menu/dishes/22/ingredients/55/move").to(format: :json, action: :move_ingredient,
                                                                                          controller: "v1/admin/menu/dishes", id: 22, ingredient_id: 55)
    end

    def req(dish_id = dish.id, ingredient_id = ingredient1.id, to_index = 0, params = {})
      patch :move_ingredient, params: params.merge(id: dish_id, ingredient_id:, to_index:)
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
      it { expect(parsed_response_body).not_to include(message: String) }
      it { expect { subject }.not_to(change { dish.reload.ingredients.count }) }

      context "if removing non-existing ingredient" do
        subject { response }

        before { req(dish.id, 999_999_999) }

        it_behaves_like NOT_FOUND
      end

      context "when removing ingredient from non-existing dish" do
        subject { response }

        before { req(999_999_999) }

        it_behaves_like NOT_FOUND
      end

      context "when moving from index 1 to index 0" do
        it do
          expect { req }.to change { Menu::IngredientsInDish.order(:index).pluck(:menu_ingredient_id) }.from([
                                                                                                               ingredient0.id,
                                                                                                               ingredient1.id,
                                                                                                               ingredient2.id
                                                                                                             ]).to([
                                                                                                                     ingredient1.id,
                                                                                                                     ingredient0.id,
                                                                                                                     ingredient2.id
                                                                                                                   ])
        end
      end
    end
  end
end