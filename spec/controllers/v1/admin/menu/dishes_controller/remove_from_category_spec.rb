# frozen_string_literal: true

require "rails_helper"

RSpec.describe V1::Admin::Menu::DishesController do
  include_context CONTROLLER_UTILS_CONTEXT
  include_context CONTROLLER_AUTHENTICATION_CONTEXT
  include_context TESTS_OPTIMIZATIONS_CONTEXT

  let(:instance) { described_class.new }

  describe "#remove_from_category" do
    let(:dish) { create(:menu_dish) }
    let(:category) do
      create(:menu_category).tap do |cat|
        cat.dishes << dish
      end
    end

    it { expect(instance).to respond_to(:remove_from_category) }

    it do
      expect(subject).to route(:delete, "/v1/admin/menu/dishes/22/remove_from_category").to(format: :json, action: :remove_from_category,
                                                                                            controller: "v1/admin/menu/dishes", id: 22)
    end

    it do
      expect(subject).to route(:delete, "/v1/admin/menu/dishes/22/remove_from_category/7").to(format: :json, action: :remove_from_category,
                                                                                              controller: "v1/admin/menu/dishes", id: 22, category_id: 7)
    end

    def req(id = dish.id, category_id = category.id, params = {})
      delete :remove_from_category, params: params.merge(id:, category_id:)
    end

    context "when user is not authenticated" do
      before { req(dish.id) }

      it_behaves_like UNAUTHORIZED
    end

    context "[user is authenticated]" do
      before do
        authenticate_request(user: create(:user))
      end

      it { expect(req(dish.id)).to be_successful }

      context "when item does not exist" do
        subject { response }

        before { req(999_999_999) }

        it_behaves_like NOT_FOUND
      end

      context "when category has dishes" do
        before { category }

        it { expect { req }.not_to(change { Menu::Dish.count }) }
        it { expect { req }.not_to(change { Menu::Dish.visible.count }) }
        it { expect { req }.not_to(change { dish.reload.status }) }
        it { expect { req }.to change { category.dishes.count }.by(-1) }
        it { expect { req }.to change { Menu::DishesInCategory.count }.by(-1) }
      end

      context "when dish is root" do
        before do
          category.dishes.delete_all # should not be necessary, just to be sure.

          Menu::DishesInCategory.create!(dish:)
        end

        context "checking mock data" do
          it { expect(dish.categories.count).to eq 0 }
          it { expect(Menu::Category.count).to eq 1 }
          it { expect(Menu::DishesInCategory.count).to eq 1 }
          it { expect(Menu::DishesInCategory.where(dish:, category: nil).count).to eq 1 }
        end

        it { expect { req(dish.id, nil) }.to change { Menu::DishesInCategory.count }.by(-1) }
        it { expect { req(dish.id, nil) }.not_to(change { Menu::Dish.count }) }
        it { expect { req(dish.id, nil) }.not_to(change { Menu::Dish.visible.count }) }
        it { expect { req(dish.id, nil) }.not_to(change { dish.reload.status }) }
      end
    end
  end
end
