# frozen_string_literal: true

FactoryBot.define do
  factory :table_type do
    default_people_per_turn { 15 }
    notes { "Mario" }
    default_price { 15 }
  end
end
