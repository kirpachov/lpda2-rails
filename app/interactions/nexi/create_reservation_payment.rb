# frozen_string_literal: true

module Nexi
  # Require nexi a payment link where redirect user
  # Usage:
  # Nexi::CreateReservationPayment.run!(amount: 2000, reservation: Reservation.visible.last)
  # Response will look like this:
  # {"hostedPage"=>"https://xpaysandbox.nexigroup.com/monetaweb/page/hosted/2/html?paymentid=193469235156442659", "securityToken"=>"35e06eae8cc241718478dfdd82eca9d8", "warnings"=>[]}
  class CreateReservationPayment < ActiveInteraction::Base
    record :reservation, class: Reservation
    integer :amount

    attr_reader :call

    def execute
      @call = OrderHpp.run(
        amount:,
        language: "ita",
        order_id: reservation.secret,
        result_url:,
        cancel_url:,
        request_purpose: "reservation_payment",
        request_record: reservation,
      )

      errors.merge!(call.errors)

      call.result
    end

    def cancel_url
      Mustache.render(
        Config.cancelled_payment_reservation_url, Config.hash.merge(secret: reservation.secret)
      ).gsub(%r(/\/$/), "")
    end

    def result_url
      Mustache.render(
        Config.processed_payment_reservation_url, Config.hash.merge(secret: reservation.secret)
      ).gsub(%r(/\/$/), "")
    end
  end
end
