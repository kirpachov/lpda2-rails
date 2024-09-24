# frozen_string_literal: true

FactoryBot.define do
  factory :preorder_reservation_date do
    date { "2024-09-23" }
    reservation_turn { create(:reservation_turn, weekday: 1) }
    group { create(:preorder_reservation_group) }
  end
end
