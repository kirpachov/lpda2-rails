# frozen_string_literal: true

# Defines a scenario when user is required to pay before making a reservation.
class PreorderReservationGroup < ApplicationRecord
  # NOTE: this field has a active_from and active_to fields.
  # These fields set a datetime window where this settings are enabled.
  # They do not refer to reservation dates: for those, there will be records associated.
  # From active_from to active_to time window, theese settings will be applied. Outside of this window, they will not be applied.

  # ################################
  # Constants, settings, modules, et...
  # ################################
  include TrackModelChanges
  extend Mobility
  translates :message

  PAYMENT_VALUE_MANDATORY_PREORDER_TYPES = %w[
    nexi_payment
  ].freeze

  enum preorder_type: {
    # Will require a payment with nexi before reservation can be created.
    # Will use Nexi HPP service.
    nexi_payment: "nexi_payment",
  }

  enum status: {
    active: "active",
    inactive: "inactive"
  }

  # ################################
  # Validators
  # ################################
  validates :title, presence: true
  validates :status, presence: true
  validates :preorder_type, presence: true
  validates :payment_value, numericality: { more_than: 0 }, if: -> { PAYMENT_VALUE_MANDATORY_PREORDER_TYPES.include?(preorder_type.to_s) }

  # ################################
  # Callbacks / Hooks
  # ################################
  after_initialize :assign_defaults

  # ################################
  # Associations
  # ################################

  # When reservations will be created for those turns payment will be required.
  has_many :preorder_reservation_groups_to_turn, dependent: :destroy
  has_many :turns, through: :preorder_reservation_groups_to_turn, source: :reservation_turn

  # Dates for which selected turns will require payment.
  has_many :dates, class_name: "PreorderReservationDate", foreign_key: :group_id, dependent: :destroy

  private

  def assign_defaults
    self.status ||= :active
    self.preorder_type ||= :nexi_payment
  end
end
