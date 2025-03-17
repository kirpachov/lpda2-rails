# frozen_string_literal: true

class CreateTableTypeToPreorderReservationGroups < ActiveRecord::Migration[7.0]
  def change
    create_table :table_type_to_preorder_reservation_groups do |t|
      t.references :table_type, null: false, foreign_key: true, index: { name: "index_table_type_to_prgroups_on_table_type_id" }
      t.references :preorder_reservation_group, null: false, foreign_key: true, index: { name: "index_table_type_to_prgroups_on_preorder_reservation_group_id" }
      t.float :price, null: false
      t.integer :people_per_turn, null: false

      t.timestamps
      t.check_constraint "price >= 0", name: "price_non_negative"
      t.check_constraint "people_per_turn > 0", name: "people_per_turn_positive"
    end
  end
end
