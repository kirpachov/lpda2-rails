# frozen_string_literal: true

FactoryBot.define do
  factory :menu_tags_in_dish, class: "Menu::TagsInDish" do
    menu_dish { create(:menu_dish) }
    menu_tag { create(:menu_tag) }
  end
end