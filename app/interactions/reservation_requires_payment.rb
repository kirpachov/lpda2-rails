# frozen_string_literal: true

# Returns a PreorderReservationGroup if the reservation requires payment, nil otherwise.
class ReservationRequiresPayment < ActiveInteraction::Base
  record :reservation

  validate do
    errors.add(:base, "turn is blank") if turn.blank?
  end

  def execute
    # Always required turns
    if matching_turns.any?

      # It's important to raise issues here.
      if matching_turns.size > 1
        raise "matching more than one turn. Reservation #{reservation.inspect} is matching turns: #{matching_turns.as_json}"
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
    @matching_turns ||= groups.map(&:turns).flatten.filter { |turn| turn.id == reservation.turn.id }
  end

  def matching_dates
    @matching_dates ||= groups.map(&:dates).flatten.filter do |date|
      date.date == reservation.datetime.to_date && date.reservation_turn.id == reservation.turn.id
    end
  end

  def turn
    @turn ||= reservation.turn
  end

  def groups
    @groups ||= PreorderReservationGroup.active_now
  end
end
