# frozen_string_literal: true

# Wrapping logic of creating a reservation payment.
# Indipendent from payment gateways, currently only Nexi is supported, but it could be easily extended.
class CreateReservationPayment < ActiveInteraction::Base
  object :reservation, class: Reservation

  interface :options, methods: [:to_h, :merge, :[]], default: {}

  validate :preorder_reservation_group_must_be_present
  validates :required_payment_value, numericality: { greater_than: 0 }

  delegate :table_type, :required_payment_value, :people, to: :reservation

  def execute
    call = Nexi::CreateReservationPayment.run(
      options.merge(
        {
          reservation:,
          amount: required_payment_value * people,
          deferred: preorder_reservation_group.deferred?
        }.compact
      )
    )

    errors.merge!(call.errors) if call.errors.any? || call.invalid?

    call
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
