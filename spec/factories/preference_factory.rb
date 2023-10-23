# frozen_string_literal: true

FactoryBot.define do
  factory :preference do
    key { Preference::DEFAULTS.keys.sample }
    value { nil }
  end

  sequence :language do
    I18n.available_locales.sample
  end

  sequence :timezone do
    ActiveSupport::TimeZone.all.map(&:name).sample
  end
end
