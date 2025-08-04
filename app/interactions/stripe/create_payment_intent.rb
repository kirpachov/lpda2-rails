# frozen_string_literal: true

module Stripe
  # Will create a Stripe PaymentIntent
  # https://docs.stripe.com/api/payment_intents/object?api-version=2025-06-30.basil
  class CreatePaymentIntent < ActiveInteraction::Base
    # ##############################
    # Inputs
    # ##############################
    # If zero, won't charge anything, but will store user's payment method.
    float :amount

    # Stripe's customer_id
    string :customer_id

    # Stripe's payment method id
    string :payment_method_id

    # ##############################
    # Validations
    # ##############################
    validates :amount, numericality: { greater_than: 0 }
    validates :customer_id, presence: true
    validates :payment_method_id, presence: true

    # ##############################
    # - Main -
    # ##############################
    attr_reader :payment_intent

    def execute
      do_call
    end

    private

    # ##############################
    # Helpers
    # ##############################

    def do_call # rubocop:disable Metrics/MethodLength
      @payment_intent = Stripe::PaymentIntent.create(
        params
      )
    rescue Stripe::StripeError => e
      errors.add(:base, "Something went wrong with Stripe: #{e.message}")
      ExceptionNotifier.notify_exception(
        e,
        data: {
          params:
        }
      )
    rescue StandardError => e
      errors.add(:base, "An unexpected error occurred: #{e.message}")
      ExceptionNotifier.notify_exception(e)
    end

    def params
      @params ||= {
        amount: (amount * 100).to_i,
        customer: customer_id,
        payment_method: payment_method_id,

        currency: "EUR",
        confirm: true,
        off_session: true
      }
    end
  end
end
