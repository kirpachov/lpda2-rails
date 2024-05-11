# frozen_string_literal: true

require "rails_helper"

RSpec.describe V1::Admin::Menu::DishesController do
  include_context CONTROLLER_UTILS_CONTEXT
  include_context CONTROLLER_AUTHENTICATION_CONTEXT
  include_context TESTS_OPTIMIZATIONS_CONTEXT

  let(:instance) { described_class.new }

  describe "#move_tag" do
    subject { req }

    before do
      dish.tags << tag0
      dish.tags << tag1
      dish.tags << tag2
    end

    let!(:tag0) { create(:menu_tag) }
    let!(:tag1) { create(:menu_tag) }
    let!(:tag2) { create(:menu_tag) }
    let!(:dish) { create(:menu_dish) }

    it { expect(instance).to respond_to(:move_tag) }

    it do
      expect(subject).to route(:patch, "/v1/admin/menu/dishes/22/tags/55/move").to(format: :json, action: :move_tag,
                                                                                   controller: "v1/admin/menu/dishes", id: 22, tag_id: 55)
    end

    def req(dish_id = dish.id, tag_id = tag1.id, to_index = 0, params = {})
      patch :move_tag, params: params.merge(id: dish_id, tag_id:, to_index:)
    end

    it { expect(dish.tags.count).to be_positive }

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
      it { expect { subject }.not_to(change { dish.reload.tags.count }) }

      context "if removing non-existing tag" do
        subject { response }

        before { req(dish.id, 999_999_999) }

        it_behaves_like NOT_FOUND
      end

      context "when removing tag from non-existing dish" do
        subject { response }

        before { req(999_999_999) }

        it_behaves_like NOT_FOUND
      end

      context "when moving from index 1 to index 0" do
        it do
          expect { req }.to change { Menu::TagsInDish.order(:index).pluck(:menu_tag_id) }.from([
                                                                                                 tag0.id,
                                                                                                 tag1.id,
                                                                                                 tag2.id
                                                                                               ]).to([
                                                                                                       tag1.id,
                                                                                                       tag0.id,
                                                                                                       tag2.id
                                                                                                     ])
        end
      end
    end
  end
end
