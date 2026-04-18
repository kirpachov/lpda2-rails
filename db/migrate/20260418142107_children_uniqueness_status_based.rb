# frozen_string_literal: true

# Managing preorder_reservation_groups_to_turns and preorder_reservation_dates tables.
# Removing old unique indexes and creating new ones that only consider active groups.
class ChildrenUniquenessStatusBased < ActiveRecord::Migration[7.0]
  def change
    reversible do |dir|
      dir.up do
        # Removing old indexed
        remove_index :preorder_reservation_groups_to_turns, name: :preorder_reservation_groups_to_turns_turn_id
        remove_index :preorder_reservation_dates, name: :index_date_reservation_turn_uniqueness

        # Creating new indexes with condition to only consider active groups
        add_index :preorder_reservation_groups_to_turns, %i[reservation_turn_id], unique: true, where: "preorder_reservation_group_status = 'active'", name: :preorder_reservation_groups_to_turns_turn_id_active
        add_index :preorder_reservation_dates, %i[date reservation_turn_id], unique: true, where: "group_status = 'active'", name: :index_date_reservation_turn_uniqueness_active
      end

      dir.down do
        # Removing new indexes (the ones with the 'active' condition)
        remove_index :preorder_reservation_groups_to_turns, name: :preorder_reservation_groups_to_turns_turn_id_active
        remove_index :preorder_reservation_dates, name: :index_date_reservation_turn_uniqueness_active

        # Adding old indexes back without the condition, just in case.
        add_index :preorder_reservation_groups_to_turns, %i[reservation_turn_id], unique: true, name: :preorder_reservation_groups_to_turns_turn_id
        add_index :preorder_reservation_dates, %i[date reservation_turn_id], unique: true, name: :index_date_reservation_turn_uniqueness
      end
    end
  end
end
