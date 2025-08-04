# frozen_string_literal: true

module Stripe
  # Create a ReservationPayment for a Reservation using Stripe as payment gateway.
  class CreateReservationPayment < ActiveInteraction::Base
    # ################################
    # Inputs
    # ################################
    record :reservation, class: Reservation

    # can be nil when deferred.
    float :amount, default: nil

    boolean :deferred

    # ################################
    # Validations
    # ################################
    validate do
      errors.add(:reservation, "has already a payment") if reservation.payment.present? && @payment.blank?
    end

    # ################################
    # - Main -
    # ################################

    attr_reader :call

    def execute
      @call = Stripe::CreateCheckoutSession.run(
        success_url:,
        cancel_url:,
        amount: deferred ? 0 : amount,
        customer_email: reservation.email,
        request_purpose: "stripe_reservation_#{deferred ? "authorization" : "payment"}",
        request_record: reservation,
        product_name:,
        custom_text_submit:,
        client_reference_id: reservation.id.to_s,
      )

      errors.merge!(call.errors) if call.errors.any? || call.invalid?

      return if errors.any? || invalid?

      create_payment
    end

    private

    # ################################
    # Helpers
    # ################################

    def product_name
      I18n.t("stripe.create_reservation_payment.product_name",
             fullname: reservation.fullname, people: reservation.people)
    end

    def custom_text_submit
      if deferred
        I18n.t("stripe.create_reservation_payment.custom_text_submit_deferred",
               fullname: reservation.fullname, people: reservation.people)
      else
        I18n.t("stripe.create_reservation_payment.custom_text_submit",
               fullname: reservation.fullname, people: reservation.people)
      end
    end

    def cancel_url
      Mustache.render(
        Config.cancelled_payment_reservation_url, Config.hash.merge(secret: reservation.secret,
                                                                    locale: reservation.lang || I18n.default_locale)
      ).gsub(%r{//$/}, "")
    end

    def success_url
      Mustache.render(
        Config.processed_payment_reservation_url, Config.hash.merge(secret: reservation.secret,
                                                                    locale: reservation.lang || I18n.default_locale)
      ).gsub(%r{//$/}, "")
    end

    def create_payment
      @payment = ::ReservationPayment.create(
        value: amount,
        # html: call.client.html,
        # other: { order_hpp_call: call.result },
        # external_object: call.session.as_json,
        other: {
          custom_text_submit:,
          product_name:,
          deferred:
        },
        reservation:,
        status: :todo,
        external_id: call.session.id,
        preorder_type: deferred ? :stripe_authorization : :stripe_payment,
        success_url:,
        failure_url: cancel_url,
        hpp_url: call.url,

        stripe_payment_details: Stripe::PaymentDetails.new(
          checkout_session_id: call.session.id,
        )
      )

      # errors.merge!(@payment.errors) if @payment.invalid?
      errors.add(:base, "failed to create payment: #{@payment.errors.full_messages.join(", ")}") if @payment.invalid?

      @payment
    end
  end
end
