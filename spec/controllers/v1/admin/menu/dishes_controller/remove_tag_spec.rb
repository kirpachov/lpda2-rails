# frozen_string_literal: true

require "rails_helper"

RSpec.describe V1::Admin::Menu::DishesController do
  include_context CONTROLLER_UTILS_CONTEXT
  include_context CONTROLLER_AUTHENTICATION_CONTEXT
  include_context TESTS_OPTIMIZATIONS_CONTEXT

  let(:instance) { described_class.new }

  describe "#remove_tag" do
    subject { req }

    before { dish.tags << tag }

    let!(:tag) { create(:menu_tag) }
    let!(:dish) { create(:menu_dish) }

    it { expect(instance).to respond_to(:remove_tag) }

    it {
      expect(subject).to route(:delete, "/v1/admin/menu/dishes/22/tags/55").to(format: :json, action: :remove_tag,
                                                                               controller: "v1/admin/menu/dishes", id: 22, tag_id: 55)
    }

    def req(dish_id = dish.id, tag_id = tag.id, params = {})
      post :remove_tag, params: params.merge(id: dish_id, tag_id:)
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
      it { expect { subject }.to change { dish.reload.tags.count }.by(-1) }
      it { expect { subject }.to change { Menu::TagsInDish.count }.by(-1) }

      context "if removing non-existing tag" do
        subject { response }

        before { req(dish.id, 999_999_999) }

        it_behaves_like NOT_FOUND
      end

      context "if removing tag from non-existing dish" do
        subject { response }

        before { req(999_999_999) }

        it_behaves_like NOT_FOUND
      end

      context "when removing first tag, all next should change position to adapt." do
        let!(:tag0) { tag } # already added
        let!(:tag1) { create(:menu_tag) }
        let!(:tag2) { create(:menu_tag) }

        before do
          dish.tags << tag1
          dish.tags << tag2
        end

        context "checking mock data" do
          it { expect(dish.tags.count).to eq 3 }
        end

        it do
          req
          expect(parsed_response_body).not_to include(message: String)
          expect(response).to have_http_status(:ok)
        end

        it do
          expect { req(dish.id, tag0.id) }.to change { Menu::TagsInDish.order(:index).pluck(:menu_tag_id) }.from([tag0.id,
                                                                                                                  tag1.id,
                                                                                                                  tag2.id
                                                                                                                 ]).to([
                                                                                                                         tag1.id,
                                                                                                                         tag2.id
                                                                                                                       ])
        end

        it do
          expect { req(dish.id, tag0.id) }.to change { Menu::TagsInDish.order(:index).pluck(:index) }.from([0, 1, 2]).to([0, 1])
        end
      end
    end
  end
end