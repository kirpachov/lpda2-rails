# frozen_string_literal: true

class CreatePreorderReservationDates < ActiveRecord::Migration[7.0]
  def change
    create_table :preorder_reservation_dates do |t|
      t.date :date, null: false
      t.belongs_to :reservation_turn, null: false, foreign_key: true
      t.belongs_to :group, null: false, foreign_key: { to_table: :preorder_reservation_groups }

      t.timestamps

      # Avoid having the same date and turn.
      # This is necessary because otherwise, when creating a reservation, it may match many Groups.
      t.index %w[date reservation_turn_id], unique: true, name: "index_date_reservation_turn_uniqueness"
    end
  end
end
