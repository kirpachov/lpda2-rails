# frozen_string_literal: true

FactoryBot.define do
  factory :menu_category, class: "Menu::Category" do
    status { 'active' }
    index { 0 }
    secret { SecureRandom.hex(20) }
    secret_desc { nil }
    other { {} }
    parent_id { nil }
    menu_visibility { build(:menu_visibility) }
    price { nil }
  end
end