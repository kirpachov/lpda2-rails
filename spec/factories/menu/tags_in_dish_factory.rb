# frozen_string_literal: true

FactoryBot.define do
  factory :menu_tags_in_dish, class: "Menu::TagsInDish" do
    menu_dish { create(:menu_dish) }
    menu_tag { create(:menu_tag) }
    index { generate(:menu_tags_in_dish_index) }
  end

  sequence :menu_tags_in_dish_index do |n|
    n
  end
end
