# frozen_string_literal: true

# Reservation turns. A turn is a time slot where reservations can be created.
# Reservation turns are periodic. You just indicate the weekday and the time slot.
class ReservationTurn < ApplicationRecord
  # ################################
  # Constants, settings, modules, etc...
  # ################################
  WEEKDAYS = %w[sunday monday tuesday wednesday thursday friday saturday].freeze

  # ################################
  # Associations
  # ################################
  has_many :preorder_reservation_groups_to_turn, dependent: :destroy
  has_many :preorder_reservation_groups, through: :preorder_reservation_groups_to_turn

  # ################################
  # Validations
  # ################################
  validates :weekday, presence: true, inclusion: { in: (0..6).to_a }
  validates :starts_at, presence: true
  validates :ends_at, presence: true
  validates :name, presence: true

  validate :starts_at_before_ends_at
  validate :starts_at_overlaps_other_turn
  validate :ends_at_overlaps_other_turn
  validate :name_should_be_unique_for_each_weekday

  # ################################
  # Class methods
  # ################################
  class << self
    # Find the reservation turn for a given datetime.
    def for(datetime)
      return nil if datetime.blank?

      ReservationTurn.where(
        weekday: datetime.wday
      ).where(
        "starts_at <= ? AND ends_at >= ?", datetime.strftime("%k:%M"), datetime.strftime("%k:%M")
      ).first
    end
  end

  # ################################
  # Instance methods
  # ################################
  def valid_times(options = {})
    ReservationTurnValidTimes.run!(options.merge(turn: self))
  end

  private

  # ################################
  # Validation methods
  # ################################
  def name_should_be_unique_for_each_weekday
    return if name.blank? || weekday.blank?

    other_turns = ReservationTurn.where(weekday:).where("LOWER(name) = LOWER(?)", name)
    other_turns = other_turns.where.not(id:) if persisted?
    return if other_turns.empty?

    errors.add(:name, %(should be unique for each weekday.), overlapping: other_turns.pluck(:id))
  end

  def starts_at_before_ends_at
    return if starts_at.blank? || ends_at.blank?
    return if starts_at < ends_at

    errors.add(:starts_at, "should be before ends_at")
    errors.add(:ends_at, "should be after starts_at")
  end

  def starts_at_overlaps_other_turn
    return if starts_at.blank? || weekday.blank?

    overlapping = self.class.where("? BETWEEN starts_at AND ends_at", starts_at).where(weekday:)
    overlapping = overlapping.where.not(id:) if persisted?
    return if overlapping.empty?

    errors.add(:starts_at, "overlaps with other turn(s)", overlapping: overlapping.pluck(:id))
  end

  def ends_at_overlaps_other_turn
    return if ends_at.blank? || weekday.blank?

    overlapping = self.class.where("? BETWEEN starts_at AND ends_at", ends_at).where(weekday:)
    overlapping = overlapping.where.not(id:) if persisted?
    return if overlapping.empty?

    errors.add(:ends_at, "overlaps with other turn(s)", overlapping: overlapping.pluck(:id))
  end

  # def should_not_overlap_with_other_reservation_turns
  #   return if starts_at.blank? || ends_at.blank?
  #   return if starts_at >= ends_at # another validator will catch this
  #   return if weekday.blank?
  #
  #   overlapping = self.class.where('? BETWEEN starts_at AND ends_at', starts_at).where(weekday:).or(self.class.where(weekday:).where('? BETWEEN starts_at AND ends_at', ends_at))
  #   # overlapping = ReservationTurn.where(weekday:).where('starts_at > ? OR ends_at < ?', ends_at, starts_at)
  #   return if overlapping.empty?
  #
  #   full_message = %(This turn starts at #{starts_at.strftime('%k:%M')} and ends at #{ends_at.strftime('%k:%M')},
  #     but #{overlapping.map { |ot| "turn ##{ot.id} starts at #{ot.starts_at.strftime('%k:%M')} and ends at #{ot.ends_at.strftime('%k:%M')}" }.join(", ") }
  #   ).squish
  #
  #   errors.add(:starts_at, 'should not overlap with other turns' + full_message, overlapping: overlapping.pluck(:id), full_message:)
  #   errors.add(:ends_at, 'should not overlap with other turns' + full_message, overlapping: overlapping.pluck(:id), full_message:)
  # end
end
