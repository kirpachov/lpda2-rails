# frozen_string_literal: true

require "rails_helper"

RSpec.describe V1::Admin::Menu::DishesController do
  include_context CONTROLLER_UTILS_CONTEXT
  include_context CONTROLLER_AUTHENTICATION_CONTEXT
  include_context TESTS_OPTIMIZATIONS_CONTEXT

  let(:instance) { described_class.new }

  describe "#add_allergen" do
    subject { req }

    let!(:allergen) { create(:menu_allergen) }
    let!(:dish) { create(:menu_dish) }

    it { expect(instance).to respond_to(:add_allergen) }

    it {
      expect(subject).to route(:post, "/v1/admin/menu/dishes/22/allergens/55").to(format: :json, action: :add_allergen,
                                                                                  controller: "v1/admin/menu/dishes", id: 22, allergen_id: 55)
    }

    def req(dish_id = dish.id, allergen_id = allergen.id, params = {})
      post :add_allergen, params: params.merge(id: dish_id, allergen_id:)
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
      it { expect { subject }.to change { dish.reload.allergens.count }.by(1) }
      it { expect { subject }.to change { Menu::AllergensInDish.count }.by(1) }
      it { expect { subject }.not_to(change { Menu::Dish.count }) }
      it { expect { subject }.not_to(change { Menu::Allergen.count }) }

      context "when adding twice same allergen" do
        before { req }

        it { expect { req }.not_to(change { dish.reload.allergens.count }) }
        it { expect { req }.not_to(change { Menu::AllergensInDish.count }) }

        context "[after second request]" do
          before { req }

          it { is_expected.to have_http_status(:unprocessable_entity) }
          it { expect(parsed_response_body).to include(message: String) }
        end
      end

      context "when adding allergen to non-existing dish" do
        subject { response }

        before { req(999_999_999) }

        it_behaves_like NOT_FOUND
      end

      context "when adding non-existing allergen to dish" do
        subject { response }

        before { req(dish.id, 999_999_999) }

        it_behaves_like NOT_FOUND
      end

      context "when adding deleted allergen to dish" do
        subject { response }

        before do
          allergen.deleted!
          req
        end

        it_behaves_like NOT_FOUND
      end

      context "when providing {copy: true}, should attach a copy of the allergen" do
        subject do
          req(dish.id, allergen.id, copy: true)
          response
        end

        it { expect { subject }.to change { dish.reload.allergens.count }.by(1) }
        it { expect { subject }.to change { Menu::AllergensInDish.count }.by(1) }
        it { expect { subject }.to change { Menu::Allergen.count }.by(1) }
        it { expect { subject }.not_to(change { Menu::Dish.count }) }

        context "[after request]" do
          before { subject }

          it { expect(parsed_response_body).not_to include(message: String) }
          it { expect(parsed_response_body).to include(item: Hash) }
          it { expect(dish.reload.allergens.count).to eq 1 }
          it { expect(dish.reload.allergens.first.id).not_to eq allergen.id }
        end

        context "when addition fails, should return 422 and not create any new record" do
          before do
            allow_any_instance_of(Menu::AllergensInDish).to receive(:valid?).and_return(false)
            req(dish.id, allergen.id, copy: true)
          end

          it { is_expected.to have_http_status(:unprocessable_entity) }
          it { expect(parsed_response_body).to include(message: String) }
          it { expect { subject }.not_to(change { dish.reload.allergens.count }) }
          it { expect { subject }.not_to(change { Menu::AllergensInDish.count }) }
          it { expect { subject }.not_to(change { Menu::Allergen.count }) }
        end
      end
    end
  end
end