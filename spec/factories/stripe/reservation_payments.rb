# frozen_string_literal: true

FactoryBot.define do
  factory :stripe_payment_details, class: "Stripe::PaymentDetails" do
    # payment_intent_id { "MyText" }
    # checkout_session_id { "MyText" }
    # setup_intent_id { "MyText" }
    # customer_id { "MyText" }
    # status { "MyText" }
  end
end
