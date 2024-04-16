# frozen_string_literal: true

FactoryBot.define do
  factory :menu_dishes_in_category, class: "Menu::DishesInCategory" do
    menu_dish { create(:menu_dish) }
    menu_category { create(:menu_category) }
    index { generate(:menu_dishes_in_category_index) }
  end

  sequence :menu_dishes_in_category_index do |n|
    n
  end
end
