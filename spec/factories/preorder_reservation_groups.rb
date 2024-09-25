# frozen_string_literal: true

FactoryBot.define do
  factory :preorder_reservation_group do
    title { "MyText" }
    status { "active" }
    # active_from { "2024-09-22 17:40:47" }
    # active_to { "2024-09-22 17:40:47" }
    preorder_type { "nexi_payment" }
    payment_value { 1.5 }
  end
end
