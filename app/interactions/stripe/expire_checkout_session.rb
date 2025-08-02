# frozen_string_literal: true

module Stripe
  # Will expire a Stripe Checkout Session.
  class ExpireCheckoutSession < ActiveInteraction::Base
    # ################################
    # Inputs
    # ################################
    string :checkout_session_id

    # ################################
    # Validations
    # ################################
    validate :checkout_session_id, presence: true

    def execute
      Stripe::Checkout::Session.expire(
        checkout_session_id
      )
    rescue Stripe::InvalidRequestError => e
      errors.add(:base, "Stripe API error: #{e.message}")
    end
  end
end
