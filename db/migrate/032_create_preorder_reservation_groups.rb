# frozen_string_literal: true

class CreatePreorderReservationGroups < ActiveRecord::Migration[7.0]
  def change
    create_table :preorder_reservation_groups do |t|
      t.text :title, null: false, comment: %(Comment for admins that define payment required cases)
      t.text :status, null: false, comment: %(Is this case enabled?)
      t.datetime :active_from, null: true, comment: %(From when this case is enabled. When nil, is enabled from its creation date.)
      t.datetime :active_to, comment: %(Until when this case is enabled. when nil, is enable forever)
      t.text :preorder_type, null: false, comment: %(What should ask the user to do. Will include provider name. May be something like 'paypal_payment', or 'nexi_card_hold'...)
      t.float :payment_value, null: true, comment: %(How much should people be required to pay if it's a payment. Since may be card hold, this field can be nil.)

      t.timestamps
    end
  end
end
