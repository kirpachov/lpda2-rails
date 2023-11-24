# frozen_string_literal: true

FactoryBot.define do
  factory :menu_allergen, class: "Menu::Allergen" do
    name { %w[Cereali Crostacei Uova Pesce Arachidi Soia Latte FruttaGuscio Sedano].sample }
    description { Faker::Lorem::paragraph }
    other { {} }
    status { "active" }
  end
end