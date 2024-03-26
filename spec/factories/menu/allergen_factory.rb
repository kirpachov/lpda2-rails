# frozen_string_literal: true

FactoryBot.define do
  factory :menu_allergen, class: 'Menu::Allergen' do
    name { %w[Cereali Crostacei Uova Pesce Arachidi Soia Latte FruttaGuscio Sedano].sample }
    description { Faker::Lorem.paragraph }
    other { {} }
    status { 'active' }

    trait :with_image do
      image { create(:image) }
    end

    trait :with_image_with_attachment do
      image { create(:image, :with_attached_image) }
    end
  end
end
