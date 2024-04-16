# frozen_string_literal: true

FactoryBot.define do
  factory :log_delivered_email, class: "Log::DeliveredEmail" do
    text { "MyText" }
    html { "MyText" }
    subject { "MyText" }
    # headers { "" }
    # raw { "MyText" }
    # pixels { "" }
  end
end
