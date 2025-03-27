# frozen_string_literal: true

class AvailableSeatsForReservationTurnAndPgroup < ActiveInteraction::Base
  record :reservation_turn, class: ReservationTurn
  record :pgroup, class: PreorderReservationGroup
  record :table_type, class: TableType
  interface :datetime, methods: %i[beginning_of_day end_of_day]

  validate :joins_exactly_one

  def execute
    available_seats
  end

  def available_seats
    @available_seats ||= total_seats - already_reserved_seats
  end

  def total_seats
    @total_seats ||= joins.first.people_per_turn
  end

  def already_reserved_seats
    @already_reserved_seats ||= reservations_same_turn.pluck(:adults, :children).flatten.sum
  end

  def reservations_same_turn
    @reservations_same_turn ||= Reservation.visible.where.not(
      status: %w[deleted cancelled]
    ).where(table_type: table_type).where(
      datetime: datetime.beginning_of_day..datetime.end_of_day
    ).filter { |r| r.reservation_turn == reservation_turn }
  end

  def joins
    @joins ||= TableTypeToPreorderReservationGroup.where(
      table_type: table_type,
      preorder_reservation_group: pgroup
    )
  end

  def joins_exactly_one
    return if joins.count == 1

    errors.add(:base, "expected exactly one TableTypeToPreorderReservationGroup matching. Got #{joins.count}.")
  end
end
