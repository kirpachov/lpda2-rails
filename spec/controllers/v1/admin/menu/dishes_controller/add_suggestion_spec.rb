# frozen_string_literal: true

require "rails_helper"

RSpec.describe V1::Admin::Menu::DishesController do
  include_context CONTROLLER_UTILS_CONTEXT
  include_context CONTROLLER_AUTHENTICATION_CONTEXT
  include_context TESTS_OPTIMIZATIONS_CONTEXT

  let(:instance) { described_class.new }

  describe "#add_suggestion" do
    subject { req }

    let!(:suggestion) { create(:menu_dish) }
    let!(:dish) { create(:menu_dish) }

    it { expect(instance).to respond_to(:add_suggestion) }

    it {
      expect(subject).to route(:post, "/v1/admin/menu/dishes/22/suggestions/55").to(format: :json, action: :add_suggestion,
                                                                                  controller: "v1/admin/menu/dishes", id: 22, suggestion_id: 55)
    }

    def req(dish_id = dish.id, suggestion_id = suggestion.id, params = {})
      post :add_suggestion, params: params.merge(id: dish_id, suggestion_id:)
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
      it { expect { subject }.to change { dish.reload.suggestions.count }.by(1) }
      it { expect { subject }.to change { Menu::DishSuggestion.count }.by(1) }
      it { expect { subject }.not_to(change { Menu::Dish.count }) }

      context "when adding suggestion to non-existing dish" do
        subject { response }

        before { req(999_999_999) }

        it_behaves_like NOT_FOUND
      end

      context "when adding non-existing suggestion to dish" do
        subject { response }

        before { req(dish.id, 999_999_999) }

        it_behaves_like NOT_FOUND
      end

      context "when adding deleted suggestion to dish" do
        subject { response }

        before do
          suggestion.deleted!
          req
        end

        it_behaves_like NOT_FOUND
      end
    end
  end
end