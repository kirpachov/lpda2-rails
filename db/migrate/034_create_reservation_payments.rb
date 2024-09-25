# frozen_string_literal: true

class CreateReservationPayments < ActiveRecord::Migration[7.0]
  def change
    create_table :reservation_payments do |t|
      # when - and if - you'll need to support different payment types from hpp_url, create a migration removing presence constraint, but create checks.
      t.text :hpp_url, null: false, index: { unique: true }, comment: %(URL where user can complete the payment. HPP stands for "Hosted Payment Page")
      t.float :value, null: false, comment: %(EUR user is required to pay.)
      t.text :status, null: false, comment: %(Will show if payment has been made.)
      t.belongs_to :reservation, null: false, foreign_key: true, index: { unique: true }
      t.text :preorder_type, null: false, comment: %(What should ask the user to do. Will include provider name. May be something like 'paypal_payment', or 'nexi_card_hold'...)
      t.jsonb :other, null: false, default: {}

      t.timestamps
    end
  end
end
