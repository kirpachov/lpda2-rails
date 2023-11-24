# frozen_string_literal: true

FactoryBot.define do
  factory :menu_tag, class: "Menu::Tag" do
    name { %w[Pesce NoGlutine Vegetariano Piccante Specialità Novità VinoBio Italiano].sample }
    description { Faker::Lorem::paragraph }
    other { {} }
    status { "active" }
    color { Faker::Color.hex_color }
  end
end