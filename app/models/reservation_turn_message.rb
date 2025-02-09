# frozen_string_literal: true

# Want to specify a message for people who try to reserve for a specific date for
# a specific time? Well, this model is for you. Specify for what dates the message
# will be shown: from `from_date` to `to_date`, the message will be shown
# to the users that do select this turn.
class ReservationTurnMessage < ApplicationRecord
  # ##############################
  # Constants, settings, modules, et...
  # ##############################
  include TrackModelChanges

  extend Mobility
  translates :message

  # ################################
  # Associations
  # ################################
  has_many :reservation_turn_to_messages, dependent: :destroy
  has_many :reservation_turns, through: :reservation_turn_to_messages
  alias_attribute :turns, :reservation_turns

  # ################################
  # Validations
  # ################################
  validate :from_date_before_to_date

  # ################################
  # Scopes
  # ################################
  scope :active_at, lambda { |date|
    where("(from_date IS NULL OR from_date <= ?) AND (to_date IS NULL OR to_date >= ?)", date, date)
  }
  scope :active_now, -> { active_at(Time.zone.now.to_date) }

  # ################################
  # Instance methods
  # ################################
  def from_date_before_to_date
    return if from_date.blank? || to_date.blank?

    errors.add(:from_date, "should be before to_date") if from_date > to_date
  end
end
