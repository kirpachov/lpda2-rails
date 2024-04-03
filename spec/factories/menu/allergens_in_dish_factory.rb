# frozen_string_literal: true

FactoryBot.define do
  factory :menu_allergens_in_dish, class: "Menu::AllergensInDish" do
    menu_dish { create(:menu_dish) }
    menu_allergen { create(:menu_allergen) }
    index { generate(:menu_allergens_in_dish_index) }
  end

  sequence :menu_allergens_in_dish_index do |n|
    n
  end
end
