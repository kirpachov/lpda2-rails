# frozen_string_literal: true

# Wrapping logic of creating a reservation payment.
# Indipendent from payment gateways, currently only Nexi is supported, but it could be easily extended.
# Usage:
# CreateReservationPayment.run(
#   reservation: @reservation,
#   amount: 10.0,
#   deferred: true,
# )
class CreateReservationPayment < ActiveInteraction::Base
  object :reservation, class: Reservation

  float :amount

  # If the reservation is a payment or an authorization. When deferred is a authorization, the payment will be done later.
  boolean :deferred, default: false

  interface :options, methods: %i[to_h merge \[\]], default: {}

  # validate :preorder_reservation_group_must_be_present
  validates :amount, numericality: { greater_than: 0 }

  def execute
    compose(
      Nexi::CreateReservationPayment,
      options.merge(
        {
          reservation:,
          amount:,
          deferred:
        }.compact
      )
    )
  end
end
