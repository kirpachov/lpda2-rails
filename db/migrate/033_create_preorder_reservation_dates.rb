# frozen_string_literal: true

class CreatePreorderReservationDates < ActiveRecord::Migration[7.0]
  def change
    create_table :preorder_reservation_dates do |t|
      t.date :date, null: false
      t.belongs_to :reservation_turn, null: false, foreign_key: true
      t.belongs_to :group, null: false, foreign_key: { to_table: :preorder_reservation_groups }

      t.timestamps

      # It doesen't make any sense have two times the same date, turn belonging to the same group.
      t.index %w[date reservation_turn_id group_id], unique: true, name: :unique_date_in_group
    end
  end
end
