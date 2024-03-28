# frozen_string_literal: true

class CreateReservationTurns < ActiveRecord::Migration[7.0]
  def change
    create_table :reservation_turns do |t|
      t.time :starts_at, null: false
      t.time :ends_at,   null: false
      t.text :name,          null: false
      t.integer :weekday,    null: false, index: true
      t.integer :step,       null: false, default: 30,
                             comment: "minutes between one valid reservation time and the next one. Set to 1 to allow any minute."

      t.timestamps
    end
  end
end
