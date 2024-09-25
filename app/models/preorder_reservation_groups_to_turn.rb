# frozen_string_literal: true

# Jointable between PreorderReservationGroup and ReservationTurn
class PreorderReservationGroupsToTurn < ApplicationRecord
  belongs_to :reservation_turn
  belongs_to :preorder_reservation_group

  validates :reservation_turn_id, uniqueness: true

  validate :turn_cannot_be_present_in_dates

  def turn_cannot_be_present_in_dates
    return if reservation_turn.blank?

    dates = PreorderReservationDate.where(reservation_turn: reservation_turn)
    return if dates.blank?

    errors.add(:reservation_turn, "has already been taken by a date")
  end
end
