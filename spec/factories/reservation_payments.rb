# frozen_string_literal: true

FactoryBot.define do
  factory :reservation_payment do
    hpp_url { "https://secure.payment-provider.example.com?id=#{SecureRandom.hex}" }
    value { 30 }
    status { "todo" }
    preorder_type { "nexi_payment" }
  end
end
