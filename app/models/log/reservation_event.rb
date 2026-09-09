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
      record_deferred_payment: "record_deferred_payment",

      # User opened the call-to-action link in the feedback email, and got redirected
      # to the feedback URL configured in Setting[:feedback_url].
      open_feedback_url: "open_feedback_url"
    }

    validates :event_type, presence: true
  end
end
