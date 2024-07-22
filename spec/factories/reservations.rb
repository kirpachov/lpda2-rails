FactoryBot.define do
  factory :reservation do
    datetime { (Time.now + 1.week).strftime("%Y-%m-%d %H:%M") }
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
