# frozen_string_literal: true

# Create a Reservation payment by a given Reservation and its PreorderReservationGroup.
class CreateReservationPaymentByGroup < ActiveInteraction::Base
  object :reservation, class: Reservation

  interface :options, methods: %i[to_h merge \[\]], default: {}

  validate :preorder_reservation_group_must_be_present
  validates :required_payment_value, numericality: { greater_than: 0 }

  delegate :table_type, :required_payment_value, :people, to: :reservation

  def execute
    compose(
      CreateReservationPayment,
      options:,
      reservation:,
      amount: required_payment_value * people,
      deferred: preorder_reservation_group.deferred?
    )
  end

  def preorder_reservation_group
    @preorder_reservation_group ||= reservation.required_payment_group
  end

  def preorder_reservation_group_must_be_present
    return if preorder_reservation_group

    errors.add(:base, "preorder_reservation_group is blank.")
  end

  def table_type_must_be_active
    return if table_type.nil?
    return if table_type.status == "active"

    errors.add(:base, "table type must be active. got #{table_type.status}")
  end
end
