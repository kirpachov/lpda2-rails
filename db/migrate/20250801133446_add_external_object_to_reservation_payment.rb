# frozen_string_literal: true

class AddExternalObjectToReservationPayment < ActiveRecord::Migration[7.0]
  def change
    add_column :reservation_payments, :external_object, :jsonb, comment: %(JSON of external object, latest version.)
  end
end
