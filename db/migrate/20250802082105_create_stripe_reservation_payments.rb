# frozen_string_literal: true

class CreateStripeReservationPayments < ActiveRecord::Migration[7.0]
  def change
    create_table :stripe_payment_details do |t|
      t.text :checkout_session_id, null: false

      t.text :payment_intent_id, comment: %(Does depend from checkout_session if is a payment, but does not if it's a authorization. When authorization can create a PaymentIntent by using payment methods provided by customer. In this case, PaymentIntent id is not linked to checkout session.)

      t.references :reservation_payment, null: false, foreign_key: { to_table: 'reservation_payments' }

      t.timestamps
    end
  end
end
