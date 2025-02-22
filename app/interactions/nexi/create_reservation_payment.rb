# frozen_string_literal: true

module Nexi
  # Require nexi a payment link where redirect user
  # Usage:
  # Nexi::CreateReservationPayment.run!(amount: 20, reservation: Reservation.visible.last)
  class CreateReservationPayment < ActiveInteraction::Base
    record :reservation, class: Reservation
    float :amount
    boolean :deferred

    validate do
      errors.add(:reservation, "has already a payment") if reservation.payment.present? && @payment.blank?
    end

    attr_reader :call

    def execute
      @call = SimplePayment.run(
        language: reservation.lang.lang_to_iso639_2.upcase,
        amount:,
        result_url:,
        cancel_url:,
        deferred:,
        request_purpose: "reservation_payment",
        request_record: reservation,
        additional_params: {
          email: reservation.email,
          urlpost: Rails.application.routes.url_helpers.nexi_receive_order_outcome_url
        }
      )

      errors.merge!(call.errors) if call.errors.any? || call.invalid?

      return if errors.any? || invalid?

      create_payment
    end

    def cancel_url
      Mustache.render(
        Config.cancelled_payment_reservation_url, Config.hash.merge(secret: reservation.secret,
                                                                    locale: reservation.lang || I18n.default_locale)
      ).gsub(%r{//$/}, "")
    end

    def result_url
      Mustache.render(
        Config.processed_payment_reservation_url, Config.hash.merge(secret: reservation.secret,
                                                                    locale: reservation.lang || I18n.default_locale)
      ).gsub(%r{//$/}, "")
    end

    def create_payment
      @payment = ::ReservationPayment.create(
        value: amount,
        html: call.client.html,
        other: { order_hpp_call: call.result },
        reservation:,
        status: :todo,
        external_id: call.cod_trans,
        preorder_type: deferred ? :html_nexi_payment : :html_nexi_authorization,
        success_url: result_url,
        failure_url: cancel_url
      )

      errors.merge!(@payment.errors) if @payment.invalid?

      @payment
    end
  end
end
