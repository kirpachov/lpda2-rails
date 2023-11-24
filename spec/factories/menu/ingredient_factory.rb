# frozen_string_literal: true

FactoryBot.define do
  factory :menu_ingredient, class: "Menu::Ingredient" do
    name { Faker::Food.ingredient }
    description { Faker::Lorem::paragraph }
    other { {} }
    status { "active" }
  end
end