FactoryBot.define do
  factory :reservation do
    datetime { "2024-02-12 21:38:03" }
    status { "active" }
    secret { "secret-#{SecureRandom.uuid}" }
    adults { 2 }
    children { 0 }
    table { "Some table bruh" }
    notes { "no te s" }
    fullname { "Mark" }
    email { Faker::Internet.email }
    phone { Faker::PhoneNumber.cell_phone }
  end
end
