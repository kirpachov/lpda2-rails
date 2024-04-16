# frozen_string_literal: true

FactoryBot.define do
  factory :menu_ingredient, class: "Menu::Ingredient" do
    name { Faker::Food.ingredient }
    description { Faker::Lorem.paragraph }
    other { {} }
    status { "active" }

    trait :with_image do
      image { create(:image) }
    end

    trait :with_image_with_attachment do
      image { create(:image, :with_attached_image) }
    end
  end
end
