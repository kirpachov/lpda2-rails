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

  attr_reader :group, :tables

  def execute
    return nil if turn.nil?

    @group = find_group
    @tables = filter_tables
    {
      group:,
      tables:
    }
  end

  private

  def find_group
    find_group_by_turn || find_group_by_dates
  end

  def filter_tables
    return TableTypeToPreorderReservationGroup.none if group.nil? || group.table_types.empty?

    TableTypeToPreorderReservationGroup.where(id: group.table_type_to_preorder_reservation_groups.includes(:table_type).filter do |table_join|
                                                    table = table_join.table_type

                                                    available_seats_call = AvailableSeatsForReservationTurnAndPgroup.run(
                                                      pgroup: group,
                                                      table_type: table,
                                                      reservation_turn: turn,
                                                      datetime:
                                                    )

                                                    available_seats = available_seats_call.valid? ? available_seats_call.result : 0

                                                    available_seats >= people
                                                  end.map(&:id))
  end

  # Finding PreorderReservationGroup by matching turn.
  def find_group_by_turn
    return nil if matching_turns.empty?

    # It's important to raise issues here.
    if matching_turns.size > 1
      raise "matching more than one turn. datetime #{datetime} is matching turns: #{matching_turns.as_json}"
    end

    if matching_turns.first.preorder_reservation_groups.count != 1
      raise "Expected one group for turn #{matching_turns.first.id}, got #{matching_turns.first.preorder_reservation_groups.as_json}"
    end

    matching_turns.first.preorder_reservation_groups.first
  end

  # Finding PreorderReservationGroup by matching PreorderReservationDate.
  def find_group_by_dates
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
