# frozen_string_literal: true

class TableTypeToPreorderReservationGroup < ApplicationRecord
  # ################################
  # Associations
  # ################################
  belongs_to :table_type
  belongs_to :preorder_reservation_group

  # ################################
  # Validators
  # ################################
  validates :price, numericality: { greater_than_or_equal_to: 0 }, allow_nil: false
  validates :people_per_turn, numericality: { greater_than: 0 }, allow_nil: false
end
