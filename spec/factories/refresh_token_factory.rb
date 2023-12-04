# frozen_string_literal: true

FactoryBot.define do
  factory :refresh_token do
    secret { generate(:refresh_token_secret) }
    expires_at { RefreshToken::DEFAULT_EXPIRATION_TIME.from_now }

    trait :with_user do
      user { create(:user) }
    end
  end

  sequence :refresh_token_secret do |n|
    "refresh_token_secret_#{n}"
  end
end
