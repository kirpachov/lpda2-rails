# frozen_string_literal: true

FactoryBot.define do
  factory :menu_dish, class: "Menu::Dish" do
    status { "active" }
    price { nil }
    other { {} }
    name { Faker::Food.dish }
    description { Faker::Food.description }

    trait :with_name do
      after(:create) do |dish|
        dish.assign_translation(:name, Mobility.available_locales.map { |locale| [locale, Faker::Food.dish] })
        dish.save!
      end
    end

    trait :with_description do
      after(:create) do |dish|
        dish.assign_translation(:name, Mobility.available_locales.map { |locale| [locale, Faker::Food.description] })
        dish.save!
      end
    end

    trait :with_images do
      after(:create) do |dish|
        dish.images = create_list(:image, 3, :with_attached_image)
      end
    end

    trait :with_allergens do
      after(:create) do |dish|
        dish.allergens = create_list(:menu_allergen, 3)
      end
    end

    trait :with_tags do
      after(:create) do |dish|
        dish.tags = create_list(:menu_tag, 3)
      end
    end

    trait :with_ingredients do
      after(:create) do |dish|
        dish.ingredients = create_list(:menu_ingredient, 3)
      end
    end

    trait :with_suggestions do
      after(:create) do |dish|
        dish.suggestions = create_list(:menu_dish, 3)
      end
    end
  end
end
