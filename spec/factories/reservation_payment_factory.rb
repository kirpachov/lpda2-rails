# frozen_string_literal: true

FactoryBot.define do
  factory :reservation_payment do
    html do
      File.read(Rails.root.join("spec", "fixtures", "nexi-simple-payment-success-page.html"))
    end
    # hpp_url { "https://my.example.com/hpp" }
    success_url { "https://my.example.com/success" }
    failure_url { "https://my.example.com/failure" }
    value { 30 }
    status { "todo" }
    preorder_type { "html_nexi_payment" }
    external_id { SecureRandom.hex }
  end
end
