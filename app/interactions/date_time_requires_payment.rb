# frozen_string_literal: true

# Returns a PreorderReservationGroup if for the given date,time and people
# a payment is required, nil otherwise.
class DateTimeRequiresPayment < ActiveInteraction::Base
  string :date
  string :time
  integer :people

  validates :date, format: { with: /\A\d{4}-\d{1,2}-\d{1,2}\z/, message: "must be in YYYY-MM-DD format" }
  validates :time, format: { with: /\A\d{1,2}:\d{1,2}\z/, message: "must be in HH:MM format" }
  validates :people, numericality: { only_integer: true, greater_than: 0 }
  validates :date, :time, :people, presence: true
  # validates :turn, presence: { message: "Turn not found for the given date and time" }

  validate :datetime

  def execute
    return nil if turn.nil?

    # Always required turns
    if matching_turns.any?

      # It's important to raise issues here.
      if matching_turns.size > 1
        raise "matching more than one turn. datetime #{datetime} is matching turns: #{matching_turns.as_json}"
      end

      if matching_turns.first.preorder_reservation_groups.count != 1
        raise "Expected one group for turn #{matching_turns.first.id}, got #{matching_turns.first.preorder_reservation_groups.as_json}"
      end

      return matching_turns.first.preorder_reservation_groups.first
    end

    # Turns required only for specific date
    if matching_dates.any?
      raise "more than one group with the same date and turn" if matching_dates.size > 1

      return matching_dates.first.group
    end

    nil
  end

  def matching_turns
    @matching_turns ||= groups.map(&:turns).flatten.filter { |gturn| gturn.id == turn.id }
  end

  def matching_dates
    @matching_dates ||= groups.map(&:dates).flatten.filter do |date|
      date.date == datetime.to_date && date.reservation_turn.id == turn.id
    end
  end

  def turn
    @turn ||= ReservationTurn.for(datetime)
  end

  def datetime
    @datetime ||= DateTime.parse("#{date} #{time}")
  rescue ArgumentError
    errors.add(:date, "Invalid date format")
  end

  def groups
    @groups ||= PreorderReservationGroup.active_now.where(
      "min_people IS NULL OR min_people <= ?",
      people
    )
  end
end
