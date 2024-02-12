# frozen_string_literal: true

FactoryBot.define do
  factory :reservation_turn do
    weekday { (0..6).to_a.sample }
    starts_at { generate(:starts_and_ends_at_sq).first }
    ends_at { generate(:starts_and_ends_at_sq).last }
    name { generate(:turn_name_seq) }
    step { 30 }
  end

  sequence :starts_and_ends_at_sq do |n|
    starts_at = Time.zone.now.change(hour: 0, min: 0) + n.minutes
    ends_at = Time.zone.now.change(hour: 0, min: 0) + (n + 1).minutes
    [starts_at, ends_at]
  end

  sequence :turn_name_seq do |n|
    "Turn #{n}"
  end
end
