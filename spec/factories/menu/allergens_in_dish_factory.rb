# frozen_string_literal: true

FactoryBot.define do
  factory :menu_allergens_in_dish, class: 'Menu::AllergensInDish' do
    menu_dish { create(:menu_dish) }
    menu_allergen { create(:menu_allergen) }
  end
end
