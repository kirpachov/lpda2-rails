FactoryBot.define do
  factory :public_message do
    key { generate(:public_message_key) }
    text { "MyText" }
    status { "active" }
  end

  sequence :public_message_key do |n|
    "key_#{n}"
  end
end
