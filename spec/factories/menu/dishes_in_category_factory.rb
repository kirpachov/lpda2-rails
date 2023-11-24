# frozen_string_literal: true

FactoryBot.define do
  factory :menu_dishes_in_category, class: "Menu::DishesInCategory" do
    menu_dish { create(:menu_dish) }
    menu_category { create(:menu_category) }
    menu_visibility { create(:menu_visibility) }
    # index { 0 }
  end
end