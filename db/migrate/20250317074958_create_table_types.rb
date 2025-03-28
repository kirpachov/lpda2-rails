# frozen_string_literal: true

class CreateTableTypes < ActiveRecord::Migration[7.0]
  def change
    create_table :table_types do |t|
      t.integer :default_people_per_turn,
                comment: %(Default number of people that can reserve a table of this type during a turn. Can be overwritten on the join table between table_types and preorder_reservation_groups)
      t.float :default_price,
              comment: %(Default price per person for the table type. Can be overwritten on the join table between table_types and preorder_reservation_groups)
      t.text :notes, comment: %(Internal notes for the admin)
      t.text :status, null: false, default: "active"

      t.timestamps
      t.check_constraint "default_price >= 0", name: "default_price_non_negative"
      t.check_constraint "default_people_per_turn > 0", name: "default_people_per_turn_positive"
    end
  end
end
