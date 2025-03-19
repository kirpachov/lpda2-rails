# frozen_string_literal: true

# Value to pay per person for a specific reservation.
class ReservationPaymentValue < ActiveInteraction::Base
  object :reservation, class: Reservation

  delegate :table_type, to: :reservation

  def execute
    return 0 if preorder_reservation_group.nil?

    per_table_type_payment_value || preorder_reservation_group.payment_value
  end

  def preorder_reservation_group
    @preorder_reservation_group ||= reservation.required_payment_group
  end

  def per_table_type_payment_value
    return nil if table_type.nil? || preorder_reservation_group.nil?

    join_record = TableTypeToPreorderReservationGroup.where(
      table_type:,
      preorder_reservation_group:
    ).first

    return join_record.price if join_record.present?

    # This will raise errors when creating reservations from public end,
    # when selecting table type and a payment is required but for some reason the
    # join record does not exist.
    # This is acceptable because it should never happen and if it does, I'm expecting an error.
    # The alternative would be to accept that people reserve without paying, and we may never notice.
    # In production it will be a 500 so an email will be sent to the developers.
    errors.add(:base, "join record not found. table_type: #{table_type.id}")
    0
  end
end
