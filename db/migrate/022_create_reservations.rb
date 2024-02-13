# frozen_string_literal: true

class CreateReservations < ActiveRecord::Migration[7.0]
  def change
    create_table :reservations do |t|
      t.text :fullname,       null: false
      t.timestamp :datetime,  null: false

      t.text :status,         null: false
      t.text :secret,         null: false
      t.integer :people,      null: false
      t.text :table,          null: true, default: nil
      t.text :notes,          null: true, default: nil

      t.text :email,          null: true
      t.text :phone,          null: true

      t.jsonb :other, default: {}

      t.timestamps
    end
  end
end
