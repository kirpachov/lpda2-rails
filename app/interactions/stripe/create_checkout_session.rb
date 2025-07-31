# frozen_string_literal: true

module Stripe
  # https://docs.stripe.com/api/checkout/sessions/create
  # Usage:
  #   ```ruby
  #   # 1. Minimal payment
  #   call = Stripe::CreateCheckoutSession.run(
  #     success_url: "https://success.example.com",
  #     cancel_url: "https://cancel.example.com",
  #     product_name: "Pagamento per la prenotazione",
  #     amount: 50
  #   )
  #   # 2. Minimal card hold: same as above, but amount is 0.
  #   # 3. Payment with customer and additional customization
  #   call = Stripe::CreateCheckoutSession.run(
  #     success_url: "https://success.example.com",
  #     cancel_url: "https://cancel.example.com",
  #     product_name: "Pagamento per la prenotazione micio mico mao mao",
  #     amount: 10,
  #     customer_id: "cus_SiMRCFH2LfS8t0",
  #     request_purpose: "reservation_payment",
  #     request_record: Reservation.last,
  #     language: "it",
  #     custom_text_submit: "ciao mao mao"
  #   )
  #   # 4. Payment with customer_email
  #   call = Stripe::CreateCheckoutSession.run(
  #     success_url: "https://success.example.com",
  #     cancel_url: "https://cancel.example.com",
  #     product_name: "Pagamento per la prenotazione",
  #     amount: 50,
  #     customer_email: "sasha@opinioni.net"
  #   )
  #   ```
  class CreateCheckoutSession < ActiveInteraction::Base
    # ##############################
    # Inputs
    # ##############################
    # If zero, won't charge anything, but will store user's payment method.
    float :amount

    # What people are paying for.
    # May be "Reservation card hold", or "Fancy table reservation", etc ...
    string :product_name

    # URL to redirect to after the payment is successful. Must start with "https://".
    string :success_url

    # URL to redirect to if the user cancels the payment. Must start with "https://".
    string :cancel_url

    # ##############################
    # Optional inputs
    # ##############################

    string :client_reference_id, default: -> { SecureRandom.hex(8) }

    # Why this order is being made?
    # Will be used for tracking purposes.
    string :request_purpose, default: nil

    # Object to associate to http request
    # Will be used for tracking purposes.
    interface :request_record, methods: %w[id persisted? update], default: nil

    # language of the interface.
    # "auto" means it will be detected from the browser.
    # "it" for Italian, "en" for English.
    string :language, default: "auto"

    # Reference to Customer in Stripe, when present.
    string :customer_id, default: nil

    # Email of the customer, when present.
    string :customer_email, default: nil

    # Custom text to show alongside the submit button
    # https://docs.stripe.com/api/checkout/sessions/create?api-version=2025-05-28.basil&lang=ruby#create_checkout_session-custom_text-submit
    string :custom_text_submit, default: nil

    # ##############################
    # Validations
    # ##############################
    validates :amount, numericality: { greater_than_or_equal_to: 0 }
    validates :language, inclusion: { in: %w[it en auto] }

    # ##############################
    # - Main -
    # ##############################
    attr_reader :session, :url

    def execute
      do_call

      @url = session.url

      session
    end

    # ##############################
    # Helpers
    # ##############################

    def cod_trans
      client_reference_id
    end

    def deferred?
      amount.to_f.zero?
    end
    alias deferred deferred?

    def params
      @params ||= (additional_params || {}).merge(
        line_items:,

        mode: deferred ? "setup" : "payment",
        ui_mode: "hosted",
        success_url:,
        currency: "EUR",
        cancel_url:,
        locale: language,
        client_reference_id:
      )
    end

    def additional_params
      {
        customer_creation: customer_id.blank? ? "always" : nil,
        customer: customer_id,
        customer_email:,
        custom_text: {
          submit: {
            message: custom_text_submit
          }.compact_blank
        }.compact_blank
      }.compact_blank
    end

    def line_items # rubocop:disable Metrics/MethodLength
      return [] if amount.to_f.zero?

      [{
        price_data: {
          currency: "EUR",
          product_data: {
            name: product_name
          },

          # https://docs.stripe.com/api/checkout/sessions/create?api-version=2025-05-28.basil&shell=true&api=true&lang=ruby#create_checkout_session-line_items-price_data-unit_amount
          unit_amount: (amount * 100).to_i
        },
        quantity: 1
      }]
    end

    private

    def do_call # rubocop:disable Metrics/MethodLength
      @session = Stripe::Checkout::Session.create(params)

      # https://docs.stripe.com/api/errors?api-version=2025-05-28.basil&shell=true&api=true&lang=ruby
    rescue Stripe::StripeError => e
      errors.add(:base, "Something went wrong with Stripe: #{e.message}")
      ExceptionNotifier.notify_exception(
        e,
        data: {
          params:,
          request_purpose:,
          request_record_id: request_record&.id,
          additional_params:,
          amount:
        }
      )
    rescue StandardError => e
      errors.add(:base, "An unexpected error occurred: #{e.message}")
      ExceptionNotifier.notify_exception(e)
    end
  end
end
