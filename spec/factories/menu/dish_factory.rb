# frozen_string_literal: true

FactoryBot.define do
  factory :menu_dish, class: "Menu::Dish" do
    status { "active" }
    price  { nil }
    other { {} }
  end
end