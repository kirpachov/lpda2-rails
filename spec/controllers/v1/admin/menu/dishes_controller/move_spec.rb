# frozen_string_literal: true

require "rails_helper"

RSpec.describe V1::Admin::Menu::DishesController do
  include_context CONTROLLER_UTILS_CONTEXT
  include_context CONTROLLER_AUTHENTICATION_CONTEXT
  include_context TESTS_OPTIMIZATIONS_CONTEXT

  let(:instance) { described_class.new }

  describe "PATCH #move" do
    subject { req }

    let(:first) { create(:menu_dish) }
    let(:second) { create(:menu_dish) }
    let(:last) { create(:menu_dish) }
    let!(:category) do
      create(:menu_category).tap do |cat|
        cat.dishes << first
        # our dish is second. Index is 1.
        cat.dishes << second
        cat.dishes << last
      end
    end

    let(:params) { { to_index:, category_id:, id: dish_id } }
    let(:dish_id) { second.id }
    let(:category_id) { category.id }
    let(:to_index) { 0 }

    it { expect(instance).to respond_to(:move) }

    it do
      expect(subject).to route(:patch, "/v1/admin/menu/dishes/22/move").to(format: :json, action: :move,
                                                                           controller: "v1/admin/menu/dishes", id: 22)
    end

    def req(rparams = params)
      patch :move, params: rparams
    end

    def list_items
      get :index, params: { category_id: }
      parsed_response_body[:items]
    end

    context "when user is not authenticated" do
      before { req }

      it_behaves_like UNAUTHORIZED
    end

    context "when user is authenticated" do
      before do
        authenticate_request(user: create(:user))
      end

      context "when providing not-existing id" do
        subject { response }

        let(:dish_id) { 999_999_999 }

        before { req }

        it_behaves_like NOT_FOUND
      end

      context "when not providing category_id" do
        subject { response }

        let(:category_id) { nil }

        it "returns 422" do
          expect { req }.not_to(change { Menu::DishesInCategory.order(:id).pluck(:updated_at) })
          expect(parsed_response_body).to include(message: String)
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end

      context "when not providing index" do
        subject { response }

        let(:to_index) { nil }

        it "returns 422" do
          expect { req }.not_to(change { Menu::DishesInCategory.order(:id).pluck(:updated_at) })
          expect(parsed_response_body).to include(message: String)
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end

      context "when moving to position 0 from position 1" do
        let(:to_index) { 0 }

        before { params }

        it { expect { req }.to(change { Menu::DishesInCategory.order(:id).pluck(:index) }) }
        it { expect { req }.to(change { Menu::DishesInCategory.order(:id).pluck(:updated_at) }) }

        it do
          expect(list_items.pluck(:id)).to eq [first.id, second.id, last.id]
          req
          expect(list_items.pluck(:id)).to eq [second.id, first.id, last.id]
        end

        it do
          req

          expect(parsed_response_body).not_to include(message: String)
          expect(response).to have_http_status(:ok)
        end
      end

      context "when moving to position 2 from position 1" do
        let(:to_index) { 2 }

        before { params }

        it { expect { req }.to(change { Menu::DishesInCategory.order(:id).pluck(:index) }) }
        it { expect { req }.to(change { Menu::DishesInCategory.order(:id).pluck(:updated_at) }) }

        it do
          expect(list_items.pluck(:id)).to eq [first.id, second.id, last.id]
          req
          expect(list_items.pluck(:id)).to eq [first.id, last.id, second.id]
        end

        it do
          req

          expect(parsed_response_body).not_to include(message: String)
          expect(response).to have_http_status(:ok)
        end
      end

      context "when moving to position 100 from position 1" do
        let(:to_index) { 100 }

        before { params }

        it { expect { req }.to(change { Menu::DishesInCategory.order(:id).pluck(:index) }) }
        it { expect { req }.to(change { Menu::DishesInCategory.order(:id).pluck(:updated_at) }) }

        it do
          expect(list_items.pluck(:id)).to eq [first.id, second.id, last.id]
          req
          expect(list_items.pluck(:id)).to eq [first.id, last.id, second.id]
        end

        it do
          req

          expect(parsed_response_body).not_to include(message: String)
          expect(response).to have_http_status(:ok)
        end
      end

      context "when moving to position 0 from position 2" do
        let(:to_index) { 0 }
        let(:dish_id) { last.id }

        before { params }

        it { expect { req }.to(change { Menu::DishesInCategory.order(:id).pluck(:index) }) }
        it { expect { req }.to(change { Menu::DishesInCategory.order(:id).pluck(:updated_at) }) }

        it do
          expect(list_items.pluck(:id)).to eq [first.id, second.id, last.id]
          req
          expect(list_items.pluck(:id)).to eq [last.id, first.id, second.id]
        end

        it do
          req

          expect(parsed_response_body).not_to include(message: String)
          expect(response).to have_http_status(:ok)
        end
      end

      context "when moving to position 0 from position 1" do
        let(:to_index) { 1 }
        let(:dish_id) { last.id }

        before { params }

        it { expect { req }.to(change { Menu::DishesInCategory.order(:id).pluck(:index) }) }
        it { expect { req }.to(change { Menu::DishesInCategory.order(:id).pluck(:updated_at) }) }

        it do
          expect(list_items.pluck(:id)).to eq [first.id, second.id, last.id]
          req
          expect(list_items.pluck(:id)).to eq [first.id, last.id, second.id]
        end

        it do
          req

          expect(parsed_response_body).not_to include(message: String)
          expect(response).to have_http_status(:ok)
        end
      end

      context "when moving to position 2 from position 0" do
        let(:to_index) { 2 }
        let(:dish_id) { first.id }

        before { params }

        it { expect { req }.to(change { Menu::DishesInCategory.order(:id).pluck(:index) }) }
        it { expect { req }.to(change { Menu::DishesInCategory.order(:id).pluck(:updated_at) }) }

        it do
          expect(list_items.pluck(:id)).to eq [first.id, second.id, last.id]
          req
          expect(list_items.pluck(:id)).to eq [second.id, last.id, first.id]
        end

        it do
          req

          expect(parsed_response_body).not_to include(message: String)
          expect(response).to have_http_status(:ok)
        end
      end

      context "when moving to position 1 from position 0" do
        let(:to_index) { 1 }
        let(:dish_id) { first.id }

        before { params }

        it { expect { req }.to(change { Menu::DishesInCategory.order(:id).pluck(:index) }) }
        it { expect { req }.to(change { Menu::DishesInCategory.order(:id).pluck(:updated_at) }) }

        it do
          expect(list_items.pluck(:id)).to eq [first.id, second.id, last.id]
          req
          expect(list_items.pluck(:id)).to eq [second.id, first.id, last.id]
        end

        it do
          req

          expect(parsed_response_body).not_to include(message: String)
          expect(response).to have_http_status(:ok)
        end
      end
    end
  end
end
