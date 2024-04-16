# frozen_string_literal: true

require "rails_helper"

RSpec.describe V1::Admin::Menu::DishesController do
  include_context CONTROLLER_UTILS_CONTEXT
  include_context CONTROLLER_AUTHENTICATION_CONTEXT
  include_context TESTS_OPTIMIZATIONS_CONTEXT

  let(:instance) { described_class.new }

  describe "#remove_allergen" do
    subject { req }

    before { dish.allergens << allergen }

    let!(:allergen) { create(:menu_allergen) }
    let!(:dish) { create(:menu_dish) }

    it { expect(instance).to respond_to(:remove_allergen) }

    it {
      expect(subject).to route(:delete, "/v1/admin/menu/dishes/22/allergens/55").to(format: :json, action: :remove_allergen,
                                                                                    controller: "v1/admin/menu/dishes", id: 22, allergen_id: 55)
    }

    def req(dish_id = dish.id, allergen_id = allergen.id, params = {})
      post :remove_allergen, params: params.merge(id: dish_id, allergen_id:)
    end

    it { expect(dish.allergens.count).to be_positive }

    context "when user is not authenticated" do
      before { req }

      it_behaves_like UNAUTHORIZED
    end

    context "when user is authenticated" do
      before do
        authenticate_request(user: create(:user))
      end

      it { is_expected.to be_successful }
      it { is_expected.to have_http_status(:ok) }
      it { expect { subject }.to change { dish.reload.allergens.count }.by(-1) }
      it { expect { subject }.to change { Menu::AllergensInDish.count }.by(-1) }

      it do
        req
        expect(parsed_response_body).to include(item: Hash)
        expect(parsed_response_body[:item]).to include(id: Integer, created_at: String, updated_at: String)
      end

      context "when removing non-existing allergen" do
        subject { response }

        before { req(dish.id, 999_999_999) }

        it_behaves_like NOT_FOUND
      end

      context "when removing allergen from non-existing dish" do
        subject { response }

        before { req(999_999_999) }

        it_behaves_like NOT_FOUND
      end

      context "when removing first allergen, all next should change position to adapt." do
        let!(:allergen0) { allergen } # already added
        let!(:allergen1) { create(:menu_allergen) }
        let!(:allergen2) { create(:menu_allergen) }

        before do
          dish.allergens << allergen1
          dish.allergens << allergen2
        end

        context "checking mock data" do
          it { expect(dish.allergens.count).to eq 3 }
        end

        it do
          req
          expect(parsed_response_body).not_to include(message: String)
          expect(response).to have_http_status(:ok)
        end

        it do
          expect { req(dish.id, allergen0.id) }.to change { Menu::AllergensInDish.order(:index).pluck(:menu_allergen_id) }.from([allergen0.id,
                                                                                                                                 allergen1.id,
                                                                                                                                 allergen2.id
                                                                                                                                ]).to([
                                                                                                                                        allergen1.id,
                                                                                                                                        allergen2.id
                                                                                                                                      ])
        end

        it do
          expect { req(dish.id, allergen0.id) }.to change { Menu::AllergensInDish.order(:index).pluck(:index) }.from([0, 1, 2]).to([0, 1])
        end
      end
    end
  end
end