# frozen_string_literal: true

class AddPreorderReservationGroupStatusToChildren < ActiveRecord::Migration[7.0]
  def change
    comment = <<~COMMENT
      The status of its PreorderReservationGroup.
      It's needed here to ensure uniqueness only among the active PreorderReservationGroups.
    COMMENT

    add_column :preorder_reservation_dates, :group_status, :text, comment: comment
    add_column :preorder_reservation_groups_to_turns, :preorder_reservation_group_status, :text, comment: comment
  end
end
