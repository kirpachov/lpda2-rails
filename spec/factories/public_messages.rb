# frozen_string_literal: true

FactoryBot.define do
  factory :public_message do
    key { generate(:public_message_key) }
    text { Faker::Lorem.question }
    status { "active" }
  end

  sequence :public_message_key do |n|
    "key_#{n}"
  end
end
