# frozen_string_literal: true

class CreatePreorderReservationGroupsToTurns < ActiveRecord::Migration[7.0]
  def change
    create_table :preorder_reservation_groups_to_turns do |t|
      t.references :reservation_turn, null: false, foreign_key: true, index: { name: "preorder_reservation_groups_to_turns_turn_id" }
      t.references :preorder_reservation_group, null: false, foreign_key: true, index: { name: "preorder_reservation_groups_to_turns_group_id" }

      t.timestamps
      t.index %w[reservation_turn_id preorder_reservation_group_id], unique: true, name: "turn_id_to_group_id_unique"
    end
  end
end
