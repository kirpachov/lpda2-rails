# frozen_string_literal: true

# Payment associated to a reservation.
# Only reservations created when a payment is required will have one.
# If a reservation has one and it's not paid, reservation should not be shown in the dashboard as it's not completed.
class ReservationPayment < ApplicationRecord
  # ################################
  # Constants, settings, modules, et...
  # ################################
  enum status: {
    todo: "todo",
    paid: "paid",
  }

  enum preorder_type: {
    # Will require a payment with nexi before reservation can be created.
    # Will use Nexi HPP service.
    nexi_payment: "nexi_payment",
  }

  # ################################
  # Associations
  # ################################
  belongs_to :reservation, optional: false
  has_many :nexi_http_requests, through: :reservation

  # ################################
  # Validators
  # ################################
  validates :status, presence: true
  validates :hpp_url, presence: true
  validates :value, presence: true, numericality: { only_integer: false, greater_than: 0 }
end
