# frozen_string_literal: true

# Jointable between PreorderReservationGroup and ReservationTurn
class PreorderReservationGroupsToTurn < ApplicationRecord
  # ################################
  # Associations
  # ################################
  belongs_to :reservation_turn
  belongs_to :preorder_reservation_group

  # ################################
  # Hooks / Callbacks
  # ################################
  before_validation :assign_group_status_from_group

  # ################################
  # Validators
  # ################################

  validates :reservation_turn_id, uniqueness: {
    conditions: -> { where(preorder_reservation_group_status: :active) }
  }, if: -> { reservation_turn_id.present? && preorder_reservation_group_status == "active" }

  validate :turn_cannot_be_present_in_dates

  # ################################
  # Instance methods
  # ################################

  private

  def assign_group_status_from_group
    self.preorder_reservation_group_status = preorder_reservation_group&.status
  end

  def turn_cannot_be_present_in_dates
    return if reservation_turn.blank?
    return if preorder_reservation_group_status.to_s != "active"

    dates = PreorderReservationDate.where(reservation_turn:, group_status: :active)
    return if dates.blank?

    errors.add(:reservation_turn, "has already been taken by a date")
  end
end
