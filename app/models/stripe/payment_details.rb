# frozen_string_literal: true

module Stripe
  # Will hold Stripe-specific reservation payment data.
  class PaymentDetails < ApplicationRecord
    # ################################
    # Constants, settings, modules, et...
    # ################################
    include TrackModelChanges

    # ################################
    # Validations
    # ################################
    validates :checkout_session_id, presence: true

    # ################################
    # Associations
    # ################################
    belongs_to :reservation_payment, class_name: "ReservationPayment", inverse_of: :stripe_payment_details
    has_one :reservation, through: :reservation_payment, class_name: "::Reservation", foreign_key: :reservation_id

    # ################################
    # Class methods
    # ################################
    class << self
      def table_name
        "stripe_payment_details"
      end
    end

    # ################################
    # Instance methods
    # ################################
    def checkout_session
      @checkout_session ||= Stripe::Checkout::Session.retrieve(checkout_session_id)
    end

    def customer_id
      checkout_session.customer
    end

    def setup_intent_id
      checkout_session.setup_intent
    end

    def customer
      @customer ||= Stripe::Customer.retrieve(customer_id)
    end

    def payment_methods
      @payment_methods ||= Stripe::PaymentMethod.list(
        customer: customer_id
      )
    end

    def refund
      return nil if refund_id.blank?

      @refund ||= Stripe::Refund.retrieve(refund_id)
    end

    def payment_method_ids
      payment_methods.data.map(&:id)
    end

    def payment_method_id
      payment_method_ids.first
    end

    def setup_intent
      return nil if setup_intent_id.blank?

      @setup_intent ||= Stripe::SetupIntent.retrieve(setup_intent_id)
    end

    def payment_intent
      return nil if payment_intent_id.blank?

      @payment_intent ||= Stripe::PaymentIntent.retrieve(payment_intent_id)
    end

    def expire_checkout_session!
      Stripe::ExpireCheckoutSession.run!(
        checkout_session_id:
      )
    end

    def refund_payment_intent!
      Stripe::RefundPaymentIntent.run!(
        payment: reservation_payment,
        payment_intent_id:
      )
    end
  end
end
