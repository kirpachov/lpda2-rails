# frozen_string_literal: true

FactoryBot.define do
  factory :table_type do
    default_people_per_turn { 15 }
    notes { "Mario" }
    default_price { 15 }
    name { "Super luxe table" }
    description { "Something super cool" }

    trait :with_images do
      after(:create) do |me|
        me.images = create_list(:image, Random.rand(1..3), :with_attached_image)
      end
    end

    trait :with_image do
      after(:create) do |me|
        me.images = create_list(:image, 1, :with_attached_image)
      end
    end
  end
end
