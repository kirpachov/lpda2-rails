# frozen_string_literal: true

FactoryBot.define do
  factory :preorder_reservation_date do
    date { "2024-09-22" }
    turn { create(:reservation_turn) }
    group { create(:preorder_reservation_group) }
  end
end
