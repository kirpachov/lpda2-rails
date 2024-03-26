# frozen_string_literal: true

FactoryBot.define do
  factory :menu_dish, class: 'Menu::Dish' do
    status { 'active' }
    price { nil }
    other { {} }

    trait :with_name do
      name { Faker::Food.dish }
    end

    trait :with_description do
      description { Faker::Food.description }
    end
  end
end
