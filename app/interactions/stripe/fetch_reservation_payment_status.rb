# frozen_string_literal: true

module Stripe
  # Download from Stripe the status of a Checkout Session.
  class FetchReservationPaymentStatus < ActiveInteraction::Base
    # ##############################
    # Inputs
    # ##############################
    record :reservation_payment, class: ReservationPayment

    # ##############################
    # Validations
    # ##############################
    validate do
      unless %w[
        stripe_authorization stripe_payment
      ].include?(reservation_payment.preorder_type)
        errors.add(:reservation_payment,
                   "preorder_type must be one of 'stripe_authorization' or 'stripe_payment'. got #{reservation_payment.preorder_type.inspect}")
      end

      errors.add(:reservation_payment, "does not have an 'external_id'") if reservation_payment.external_id.blank?

      if reservation_payment.stripe_payment_details.nil?
        errors.add(:reservation_payment,
                   "does not have an associated Stripe::PaymentDetails")
      end
    end

    validates :reservation_payment, presence: true
    validates :checkout_session, presence: true
    validates :stripe_payment_details, presence: true

    # ##############################
    # - Main -
    # ##############################
    attr_reader :session

    delegate :stripe_payment_details, to: :reservation_payment
    delegate :checkout_session, :payment_intent, :refund, to: :stripe_payment_details, allow_nil: true

    def execute
      reservation_payment.status = calc_reservation_payment_status
      reservation_payment.save if errors.empty?

      reservation_payment.reload
    rescue Stripe::APIError => e
      ExceptionNotifier.notify_exception(e)
      errors.add(:base, "Stripe API error: #{e.message}")
    end

    def calc_reservation_payment_status
      # Got an async charge after authorization
      return "paid" if payment_intent&.status == "succeeded"

      # A payment was made but then canceled/refunded.
      return "refunded" if payment_intent&.status == "canceled"

      # Successful refund.
      return "refunded" if refund&.status == "succeeded"

      # User did nothing.
      return "todo" if checkout_session.status == "open"

      # Got a direct charge. User paid inside checkout session.
      return "paid" if checkout_session.payment_status == "paid"

      # Authorization was completed.
      return "authorized" if checkout_session.status == "complete" && checkout_session.mode == "setup"

      # Authorization page has expired.
      return "todo" if checkout_session.status == "expired" && checkout_session.mode == "setup"

      errors.add(:base,
                 "don't know how to handle request. checkout_session.status: #{checkout_session.status}; payment_intent.status: #{payment_intent&.status}, checkout_session.mode: #{checkout_session.mode}")
      nil
    end
  end
end
