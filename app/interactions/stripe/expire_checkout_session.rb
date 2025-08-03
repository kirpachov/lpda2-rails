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
    validates :checkout_session_id, presence: true

    def execute
      return "checkout session is not open" if checkout_session.status != "open"

      Stripe::Checkout::Session.expire(
        checkout_session_id
      )
    rescue Stripe::InvalidRequestError => e
      errors.add(:base, "Stripe API error: #{e.message}")
    end

    def checkout_session
      @checkout_session ||= Stripe::Checkout::Session.retrieve(
        checkout_session_id
      )
    rescue Stripe::InvalidRequestError => e
      errors.add(:base, "Stripe API error: #{e.message}")
      nil
    end
  end
end
