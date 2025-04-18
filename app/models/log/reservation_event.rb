# frozen_string_literal: true

module Log
  # Will track some events related to reservations.
  class ReservationEvent < ApplicationRecord
    # ################################
    # Associations
    # ################################
    belongs_to :reservation

    # ################################
    # Validations
    # ################################
    enum event_type: {
      # User accessed the URL to pay for the reservation.
      do_payment: "do_payment",

      # User accessed the URL to pay for the reservation but it's already paid: got redirected to the success page.
      redirect_payment_success: "redirect_payment_success",

      # Provider notified us about the outcome of the payment.
      payment_outcome: "payment_outcome",

      # Had a card hold, and proceeded to charge the user.
      record_deferred_payment: "record_deferred_payment"
    }

    validates :event_type, presence: true
  end
end
