# frozen_string_literal: true

# User-defined date when user who create reservations are required to pay
class PreorderReservationDate < ApplicationRecord
  # ################################
  # Associations
  # ################################
  belongs_to :reservation_turn, optional: false
  belongs_to :group, class_name: "PreorderReservationGroup", optional: false

  # ################################
  # Validators
  # ################################
  validates :date, presence: true
  validates :reservation_turn_id, uniqueness: { scope: :date }, if: -> { reservation_turn_id.present? && date.present? }
  validate :turn_weekday_same_as_date
  validate :turn_cannot_be_present_in_group

  # TODO check what happens if a turn is deleted or its weekday is changed.

  def turn_weekday_same_as_date
    return if date.blank? || reservation_turn.nil?
    return if date.wday == reservation_turn.weekday

    errors.add(:date, "date has wday=#{date.wday} while reservation_turn weekday is #{reservation_turn.weekday}")
  end

  def turn_cannot_be_present_in_group
    return if reservation_turn.blank?
    return if PreorderReservationGroupsToTurn.where(reservation_turn:).count.zero?

    errors.add(:reservation_turn, "has already been taken by a group")
  end
end
