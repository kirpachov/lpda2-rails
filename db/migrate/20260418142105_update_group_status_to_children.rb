# frozen_string_literal: true

class UpdateGroupStatusToChildren < ActiveRecord::Migration[7.0]
  def change
    # Now, updating the existing records with the correct status from their parent.
    reversible do |dir|
      dir.up do
        execute <<~SQL.squish
          UPDATE preorder_reservation_dates
          SET group_status = (
            SELECT status
            FROM preorder_reservation_groups
            WHERE preorder_reservation_groups.id = preorder_reservation_dates.group_id
          )
        SQL

        execute <<~SQL.squish
          UPDATE preorder_reservation_groups_to_turns
          SET preorder_reservation_group_status = (
            SELECT status
            FROM preorder_reservation_groups
            WHERE preorder_reservation_groups.id = preorder_reservation_groups_to_turns.preorder_reservation_group_id
          )
        SQL
      end
    end
  end
end
