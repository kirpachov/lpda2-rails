# frozen_string_literal: true

require "rails_helper"

RSpec.describe V1::Admin::Menu::DishesController do
  include_context CONTROLLER_UTILS_CONTEXT
  include_context CONTROLLER_AUTHENTICATION_CONTEXT
  include_context TESTS_OPTIMIZATIONS_CONTEXT

  let(:instance) { described_class.new }

  describe "#move_allergen" do
    subject { req }

    before do
      dish.allergens << allergen0
      dish.allergens << allergen1
      dish.allergens << allergen2
    end

    let!(:allergen0) { create(:menu_allergen) }
    let!(:allergen1) { create(:menu_allergen) }
    let!(:allergen2) { create(:menu_allergen) }
    let!(:dish) { create(:menu_dish) }

    it { expect(instance).to respond_to(:move_allergen) }

    it do
      expect(subject).to route(:patch, "/v1/admin/menu/dishes/22/allergens/55/move").to(format: :json, action: :move_allergen,
                                                                                        controller: "v1/admin/menu/dishes", id: 22, allergen_id: 55)
    end

    def req(dish_id = dish.id, allergen_id = allergen1.id, to_index = 0, params = {})
      patch :move_allergen, params: params.merge(id: dish_id, allergen_id:, to_index:)
    end

    it { expect(dish.allergens.count).to be_positive }

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
      it { expect { subject }.not_to(change { dish.reload.allergens.count }) }

      context "if removing non-existing allergen" do
        subject { response }

        before { req(dish.id, 999_999_999) }

        it_behaves_like NOT_FOUND
      end

      context "when removing allergen from non-existing dish" do
        subject { response }

        before { req(999_999_999) }

        it_behaves_like NOT_FOUND
      end

      context "when moving from index 1 to index 0" do
        it do
          expect { req }.to change { Menu::AllergensInDish.order(:index).pluck(:menu_allergen_id) }.from([
                                                                                                           allergen0.id,
                                                                                                           allergen1.id,
                                                                                                           allergen2.id
                                                                                                         ]).to([
                                                                                                                 allergen1.id,
                                                                                                                 allergen0.id,
                                                                                                                 allergen2.id
                                                                                                               ])
        end
      end
    end
  end
end
