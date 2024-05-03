# frozen_string_literal: true

FactoryBot.define do
  factory :reset_password_secret do
    secret { SecureRandom.urlsafe_base64(32) }
    expires_at { 1.week.from_now }
  end
end
