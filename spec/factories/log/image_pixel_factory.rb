# frozen_string_literal: true

FactoryBot.define do
  factory :log_image_pixel, class: 'Log::ImagePixel' do
    event_type { 'email_open' }

    trait :with_image do
      image { create(:image, :with_attached_image) }
    end

    trait :with_record do
      record { create(:user) }
    end

    trait :with_delivered_email do
      delivered_email { create(:log_delivered_email) }
    end
  end
end
