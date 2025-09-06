# frozen_string_literal: true

require "rails_helper"

RSpec.shared_examples "successful request PATCH /v1/admin/menu/dishes/<dish-id>/move" do
  context "after request" do
    before { req }

    it do
      expect(response).to have_http_status(:ok)
    end

    it do
      expect(json).not_to include(message: String)
    end

    it "indexes should all be consecutive" do
      Menu::DishesInCategory.pluck(:menu_category_id).uniq.each do |category_id|
        indexes = Menu::DishesInCategory.where(menu_category_id: category_id).order(:index).pluck(:index)
        next if indexes.empty?

        expect(indexes.uniq).to match_array(indexes)
        expect(indexes).to match_array((0..indexes.size - 1).to_a)
      end
    end
  end
end

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

      [
        { from_index: 3, to_index: 13 },
        { from_index: 3, to_index: 14 },
        { from_index: 0, to_index: 14 },
        { from_index: 14, to_index: 0 },
        { from_index: 10, to_index: 0 },
        { from_index: 10, to_index: 5 },
      ].each do |spec_context|
        from_index = spec_context[:from_index]
        to_index = spec_context[:to_index]

        context "when moving from #{from_index.inspect} to index #{to_index.inspect}" do
          let(:dishes) { create_list(:menu_dish, 15) }
          let!(:category) do
            create(:menu_category).tap do |cat|
              dishes.shuffle.each do |dish|
                cat.dishes << dish
              end

              7.times do
                dishes.sample.move(to_index: Random.rand(0..14), category_id: cat.id)
              end
            end
          end

          let(:dish) { dishes.sample }

          let(:params) { { to_index: to_index, category_id:, id: dish.id } }

          before do
            dish.move(to_index: from_index, category_id: category.id)
          end

          it_behaves_like "successful request PATCH /v1/admin/menu/dishes/<dish-id>/move"

          it { expect { req }.to(change { Menu::DishesInCategory.where(menu_dish: dish, menu_category_id: category_id).pluck(:index) }.to([to_index]) ) }
        end
      end

      context "when moving to location 1 but index 2 is empty" do
        before do
          Menu::DishesInCategory.where(index: 2).update!(index: 3)
        end

        let(:params) { { to_index: 1, category_id:, id: dish_id } }

        it { expect(Menu::DishesInCategory.pluck(:index)).to contain_exactly(0, 1, 3) }
        it { expect { req }.to(change { Menu::DishesInCategory.pluck(:index).sort }.to([0, 1, 2])) }

        it_behaves_like "successful request PATCH /v1/admin/menu/dishes/<dish-id>/move"
      end

      context "when moving to position 0 from position 1" do
        let(:to_index) { 0 }

        before { params }

        it { expect { req }.to(change { Menu::DishesInCategory.order(:id).pluck(:index) }) }
        it { expect { req }.to(change { Menu::DishesInCategory.order(:id).pluck(:updated_at) }) }

        it do
          expect(list_items.pluck(:id)).to match_array [first.id, second.id, last.id]
          req
          expect(list_items.pluck(:id)).to match_array [second.id, first.id, last.id]
        end

        it do
          req

          expect(parsed_response_body).not_to include(message: String)
          expect(response).to have_http_status(:ok)
        end

        it_behaves_like "successful request PATCH /v1/admin/menu/dishes/<dish-id>/move"
      end

      context "when moving to position 2 from position 1" do
        let(:to_index) { 2 }

        before { params }

        it { expect { req }.to(change { Menu::DishesInCategory.order(:id).pluck(:index) }) }
        it { expect { req }.to(change { Menu::DishesInCategory.order(:id).pluck(:updated_at) }) }

        it do
          expect(list_items.pluck(:id)).to match_array [first.id, second.id, last.id]
          req
          expect(list_items.pluck(:id)).to match_array [first.id, last.id, second.id]
        end

        it do
          req

          expect(parsed_response_body).not_to include(message: String)
          expect(response).to have_http_status(:ok)
        end

        it_behaves_like "successful request PATCH /v1/admin/menu/dishes/<dish-id>/move"
      end

      context "when moving to position 100 from position 1" do
        let(:to_index) { 100 }

        before { params }

        it { expect { req }.to(change { Menu::DishesInCategory.order(:id).pluck(:index) }) }
        it { expect { req }.to(change { Menu::DishesInCategory.order(:id).pluck(:updated_at) }) }

        it do
          expect(list_items.pluck(:id)).to match_array [first.id, second.id, last.id]
          req
          expect(list_items.pluck(:id)).to match_array [first.id, last.id, second.id]
        end

        it do
          req

          expect(parsed_response_body).not_to include(message: String)
          expect(response).to have_http_status(:ok)
        end

        it_behaves_like "successful request PATCH /v1/admin/menu/dishes/<dish-id>/move"
      end

      context "when moving to position 0 from position 2" do
        let(:to_index) { 0 }
        let(:dish_id) { last.id }

        before { params }

        it { expect { req }.to(change { Menu::DishesInCategory.order(:id).pluck(:index) }) }
        it { expect { req }.to(change { Menu::DishesInCategory.order(:id).pluck(:updated_at) }) }

        it do
          expect(list_items.pluck(:id)).to match_array [first.id, second.id, last.id]
          req
          expect(list_items.pluck(:id)).to match_array [last.id, first.id, second.id]
        end

        it do
          req

          expect(parsed_response_body).not_to include(message: String)
          expect(response).to have_http_status(:ok)
        end

        it_behaves_like "successful request PATCH /v1/admin/menu/dishes/<dish-id>/move"
      end

      context "when moving to position 0 from position 1" do
        let(:to_index) { 1 }
        let(:dish_id) { last.id }

        before { params }

        it { expect { req }.to(change { Menu::DishesInCategory.order(:id).pluck(:index) }) }
        it { expect { req }.to(change { Menu::DishesInCategory.order(:id).pluck(:updated_at) }) }

        it do
          expect(list_items.pluck(:id)).to match_array [first.id, second.id, last.id]
          req
          expect(list_items.pluck(:id)).to match_array [first.id, last.id, second.id]
        end

        it do
          req

          expect(parsed_response_body).not_to include(message: String)
          expect(response).to have_http_status(:ok)
        end

        it_behaves_like "successful request PATCH /v1/admin/menu/dishes/<dish-id>/move"
      end

      context "when moving to position 2 from position 0" do
        let(:to_index) { 2 }
        let(:dish_id) { first.id }

        before { params }

        it { expect { req }.to(change { Menu::DishesInCategory.order(:id).pluck(:index) }) }
        it { expect { req }.to(change { Menu::DishesInCategory.order(:id).pluck(:updated_at) }) }

        it do
          expect(list_items.pluck(:id)).to match_array [first.id, second.id, last.id]
          req
          expect(list_items.pluck(:id)).to match_array [second.id, last.id, first.id]
        end

        it do
          req

          expect(parsed_response_body).not_to include(message: String)
          expect(response).to have_http_status(:ok)
        end

        it_behaves_like "successful request PATCH /v1/admin/menu/dishes/<dish-id>/move"
      end

      context "when moving to position 1 from position 0" do
        let(:to_index) { 1 }
        let(:dish_id) { first.id }

        before { params }

        it { expect { req }.to(change { Menu::DishesInCategory.order(:id).pluck(:index) }) }
        it { expect { req }.to(change { Menu::DishesInCategory.order(:id).pluck(:updated_at) }) }

        it do
          expect(list_items.pluck(:id)).to match_array [first.id, second.id, last.id]
          req
          expect(list_items.pluck(:id)).to match_array [second.id, first.id, last.id]
        end

        it do
          req

          expect(parsed_response_body).not_to include(message: String)
          expect(response).to have_http_status(:ok)
        end

        it_behaves_like "successful request PATCH /v1/admin/menu/dishes/<dish-id>/move"
      end
    end
  end
end
