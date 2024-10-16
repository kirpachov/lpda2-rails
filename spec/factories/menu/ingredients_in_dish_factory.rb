# frozen_string_literal: true

FactoryBot.define do
  factory :menu_ingredients_in_dish, class: "Menu::IngredientsInDish" do
    menu_dish { create(:menu_dish) }
    menu_ingredient { create(:menu_ingredient) }
    index { generate(:menu_ingredients_in_dish_index) }
  end

  sequence :menu_ingredients_in_dish_index do |n|
    n
  end
end
