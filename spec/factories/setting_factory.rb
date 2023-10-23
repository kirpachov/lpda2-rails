# frozen_string_literal: true

FactoryBot.define do
  factory :setting do
    key { Setting::DEFAULTS.keys.sample }
    value { nil }
  end
end
