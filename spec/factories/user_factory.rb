# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { generate(:user_email) }
    status { 'active' }
  end

  trait :admin do
    roles { %w[admin] }
  end

  sequence :user_email do |n|
    Faker::Internet.email.gsub('@', "#{n}@")
  end

  sequence :user_username do |n|
    "#{Faker::Lorem.word}-#{n}".parametrize
  end
end
