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
  validate :turn_weekday_same_as_date

  # TODO check what happens if a turn is deleted or its weekday is changed.

  def turn_weekday_same_as_date
    return if date.blank? || reservation_turn.nil?
    return if date.wday == reservation_turn.weekday

    errors.add(:date, "date has wday=#{date.wday} while reservation_turn weekday is #{reservation_turn.weekday}")
  end
end
