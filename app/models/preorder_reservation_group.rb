# frozen_string_literal: true

# Defines a scenario when user is required to pay before making a reservation.
class PreorderReservationGroup < ApplicationRecord
  # NOTE: this field has a active_from and active_to fields.
  # These fields set a datetime window where this settings are enabled.
  # They do not refer to reservation dates: for those, there will be records associated.
  # From active_from to active_to time window, theese settings will be applied. Outside of this window, they will not be applied.

  # An issue that may occur is that a reservation matches multiple groups.
  # To avoid this:
  # - A turn can be assigned to only one group.
  # - A turn,date pair can be assigned to only one group.
  # - If a turn is associated to a group, cannot create dates with the same turn. In this way you can specify multiple dates for turns that you want to.

  # ################################
  # Constants, settings, modules, et...
  # ################################
  include TrackModelChanges
  extend Mobility
  translates :message

  PAYMENT_VALUE_MANDATORY_PREORDER_TYPES = %w[
    nexi_payment
    nexi_authorization
  ].freeze

  enum preorder_type: {
    # Will require a payment with nexi before reservation can be created.
    # Will use Nexi HPP service.
    nexi_payment: "nexi_payment",

    # Authorize a payment with nexi before reservation can be created, but don't charge it yet.
    nexi_authorization: "nexi_authorization"
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
  validates :payment_value, numericality: { more_than: 0 }, if: lambda {
                                                                  PAYMENT_VALUE_MANDATORY_PREORDER_TYPES.include?(preorder_type.to_s)
                                                                }

  # ################################
  # Callbacks / Hooks
  # ################################
  after_initialize :assign_defaults
  around_save :save_associated_records_first

  # ################################
  # Associations
  # ################################

  # When reservations will be created for those turns payment will be required.
  has_many :preorder_reservation_groups_to_turn, dependent: :destroy
  has_many :turns, through: :preorder_reservation_groups_to_turn, source: :reservation_turn
  has_many :table_type_to_preorder_reservation_groups, dependent: :destroy
  has_many :table_types, through: :table_type_to_preorder_reservation_groups

  # PreorderReservationGroupsToTurn
  # Dates for which selected turns will require payment.
  has_many :dates, class_name: "PreorderReservationDate", inverse_of: :group, foreign_key: :group_id, dependent: :destroy

  # ################################
  # Scope
  # ################################
  scope :active_now, lambda {
                       active.where("active_from IS NULL or active_from < ?", Time.zone.now).where("active_to IS NULL or active_to > ?", Time.zone.now)
                     }

  scope :deferred, lambda {
    where(preorder_type: %w[nexi_authorization])
  }

  def deferred?
    preorder_type.to_s.in?(%w[nexi_authorization])
  end

  # Usage:
  # add_table_type(table_type: <table-type>, price: 5, people_per_turn: 2)
  def add_table_type(args)
    table_type_to_preorder_reservation_groups.create(args)
  end

  def add_table_type!(args)
    table_type_to_preorder_reservation_groups.create!(args)
  end

  private

  def save_associated_records_first
    if dates.update!(group_status: status) && preorder_reservation_groups_to_turn.update!(preorder_reservation_group_status: status)
      yield
    else
      errors.add(:base, "Error updating associated turns or dates")
      false
    end

    self
  rescue ActiveRecord::RecordInvalid => e
    errors.add(:base, "Error updating associated turns or dates: #{e.message}")
    false
  end

  def assign_defaults
    self.status ||= :active
    # self.preorder_type ||= :nexi_payment  # no default, mandatory value
  end
end
