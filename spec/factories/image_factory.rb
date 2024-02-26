# frozen_string_literal: true

FactoryBot.define do
  factory :image do
    filename { generate(:image_filename) }
    status { 'active' }

    trait :with_original do
      original { build(:image) }
      tag { 'blur' }
    end

    trait :with_key do
      key { generate(:image_key) }
    end

    trait :with_attached_image do
      after(:build) do |image|
        image.attached_image.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'files', 'cat.jpeg')), filename: image.filename)
      end
    end
  end

  sequence :image_filename do |n|
    "image_#{n}.jpg"
  end

  sequence :image_key do |n|
    "image_#{n}"
  end
end