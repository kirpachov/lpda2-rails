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

    trait :with_hpp_url do
      # hpp_url { "https://my.example.com/hpp" }
      hpp_url { generate(:reservation_payment_hpp_url) }
    end

    trait :stripe_authorization do
      preorder_type { "stripe_authorization" }
      status { "authorized" }
      external_id { StubStripeBackendHelper::CS_ID }
      hpp_url { "https://checkout.stripe.com/pay/#{StubStripeBackendHelper::CS_ID}/#{SecureRandom.hex}" }

      stripe_payment_details do
        build(:stripe_payment_details, checkout_session_id: StubStripeBackendHelper::CS_ID)
      end
    end

    trait :stripe_payment do
      preorder_type { "stripe_payment" }
      external_id { StubStripeBackendHelper::CS_ID }
      status { "paid" }
      hpp_url { "https://checkout.stripe.com/pay/#{StubStripeBackendHelper::CS_ID}/#{SecureRandom.hex}" }

      stripe_payment_details do
        build(:stripe_payment_details, checkout_session_id: StubStripeBackendHelper::CS_ID)
        # association :stripe_payment_details
      end
    end

    trait :nexi_authorization do
      preorder_type { "html_nexi_authorization" }
      status { "todo" }
      html do
        File.read(Rails.root.join("spec", "fixtures", "nexi-simple-payment-success-page.html"))
      end
    end

    trait :nexi_payment do
      preorder_type { "html_nexi_payment" }
      status { "paid" }
      html do
        File.read(Rails.root.join("spec", "fixtures", "nexi-simple-payment-success-page.html"))
      end
    end
  end

  sequence :reservation_payment_hpp_url do |n|
    "https://my.example.com/hpp/#{n}"
  end
end
