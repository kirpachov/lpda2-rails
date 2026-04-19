# frozen_string_literal: true

# Given a ReservationPayment, will delete it and create a new one with the same attributes,
# for the same reservation.
class ReplaceReservationPayment < ActiveInteraction::Base
  # ################################
  # Constants, settings, modules, etc...
  # ################################

  ACCEPTED_PAYMENT_STATUSES = %w[
    todo
    expired
    refunded
  ].freeze

  # ################################
  # Inputs
  # ################################
  record :reservation, class: Reservation

  # ################################
  # Validations
  # ################################
  validate :v_payment_presence
  validate :v_payment_status

  # ################################
  # Main logic
  # ################################
  delegate :payment, to: :reservation

  attr_reader :old_payment_attributes, :status, :existing_payment_attributes, :was_deferred, :old_payment_gateway

  def execute # rubocop:disable Metrics/MethodLength
    delete_old_payment

    create_new_payment

    reservation.touch

    reservation.reload

    @status = 200
  rescue ActiveRecord::RecordInvalid, ActiveInteraction::InvalidInteractionError => e
    manage_error(e)
    @status = :unprocessable_entity
  rescue StandardError => e
    manage_error(e)
    @status = :internal_server_error
  end

  private

  # ################################
  # Private utils
  # ################################

  def delete_old_payment
    @existing_payment_attributes = payment.attributes

    @old_payment_gateway = payment.payment_gateway.to_s

    @was_deferred = payment.deferred?

    payment.destroy!

    reservation.reload
  end

  def create_new_payment
    CreateReservationPayment.run!(
      reservation:,
      amount: existing_payment_attributes["value"],
      deferred: was_deferred,
      payment_gateway: old_payment_gateway
    )
  end

  def manage_error(e)
    Rails.logger.error("[RefreshReservationPayment] Failed to refresh reservation payment. Error: #{e.message}")
    errors.add(:base, "Failed to refresh reservation payment: #{e.message}")
    ReservationPayment.create!(existing_payment_attributes)
  end

  # #################
  # Validations
  # #################

  def v_payment_presence
    return if payment.present?

    errors.add(:base, "reservation does not have a payment")
    @status = :unprocessable_entity
  end

  def v_payment_status
    return if payment&.status.blank?
    return if ACCEPTED_PAYMENT_STATUSES.include?(payment.status)

    errors.add(:base, "status must be one of #{ACCEPTED_PAYMENT_STATUSES.join(", ")}. got #{payment.status.inspect}")
    @status = :unprocessable_entity
  end
end
