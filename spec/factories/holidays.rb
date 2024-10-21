# frozen_string_literal: true

FactoryBot.define do
  factory :holiday do
    from_timestamp { Time.zone.now.beginning_of_day }
    to_timestamp { 1.day.from_now.end_of_day }
    weekly_from { nil }
    weekly_to { nil }
    weekday { nil }
  end
end
