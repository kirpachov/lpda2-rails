# frozen_string_literal: true

# Allow admin users to create a Reservation payment.
# Usage:
# AdminCreateReservationPayment.run!(reservation: r, params: { amount: 15.2, deferred: false })
class AdminCreateReservationPayment < ActiveInteraction::Base
  object :reservation, class: Reservation
  interface :params, methods: %w[fetch to_h]

  validates :amount, numericality: { greater_than: 0 }

  validate :table_type_found_if_id_provided

  def execute
    create_payment

    assign_table_type if table_type && errors.empty?

    send_confirmation_email if errors.empty?

    reservation.touch if errors.empty?

    reservation.reload
  end

  # ################################
  # Main logic
  # ################################

  def create_payment
    compose(
      CreateReservationPayment,
      reservation:,
      amount:,
      deferred:
    )
  end

  def assign_table_type
    reservation.update(table_type:)

    errors.merge!(reservation.errors)
  end

  def send_confirmation_email
    reservation.deliver_confirmation_email_later
  end

  # ################################
  # Helpers
  # ################################

  def table_type
    @table_type ||= TableType.visible.find_by(id: params[:table_type_id])
  end

  def amount
    params[:amount].to_f
  end

  def deferred
    params[:deferred].to_s == "true"
  end
  alias_method :deferred?, :deferred

  # ################################
  # Validators
  # ################################

  def table_type_found_if_id_provided
    return unless params.key?(:table_type_id)
    return if table_type.present?

    errors.add(:base, "table type with id=#{params[:table_type_id].inspect} not found.")
  end
end
