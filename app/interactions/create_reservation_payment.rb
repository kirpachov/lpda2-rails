# frozen_string_literal: true

# Wrapping logic of creating a reservation payment.
# Indipendent from payment gateways, currently only Nexi and Stripe are supported, but it could be easily extended.
# Usage:
# CreateReservationPayment.run(
#   reservation: @reservation,
#   amount: 10.0,
#   deferred: true,
# )
class CreateReservationPayment < ActiveInteraction::Base
  # ################################
  # Inputs
  # ################################
  record :reservation, class: Reservation

  float :amount

  # If the reservation is a payment or an authorization. When deferred is a authorization, the payment will be done later.
  boolean :deferred, default: false

  interface :options, methods: %i[to_h merge \[\]], default: {}

  string :payment_gateway, default: -> { Config.default_payment_gateway }

  # ################################
  # Validations
  # ################################
  # validate :preorder_reservation_group_must_be_present
  validates :amount, numericality: { greater_than: 0 }
  validates :payment_gateway, inclusion: { in: %w[nexi stripe] }

  # ################################
  # - Main -
  # ################################

  def execute
    if reservation.payment.present?
      errors.add(:reservation, "has already a payment")
      return
    end

    return create_nexi if payment_gateway == "nexi"

    create_stripe
  end

  private

  def create_nexi
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

  def create_stripe
    compose(
      Stripe::CreateReservationPayment,
      options.merge(
        {
          reservation:,
          amount:,
          deferred:
        }
      )
    )
  end
end
