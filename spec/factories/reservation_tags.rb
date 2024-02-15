# frozen_string_literal: true

FactoryBot.define do
  factory :reservation_tag do
    title { generate(:reservation_tag_title) }
    bg_color { "#000" }
    color { "#FFF" }
  end

  sequence(:reservation_tag_title) do |n|
    "Tag ##{n}"
  end
end
