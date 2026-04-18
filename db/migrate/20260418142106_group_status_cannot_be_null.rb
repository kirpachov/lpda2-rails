# frozen_string_literal: true

class GroupStatusCannotBeNull < ActiveRecord::Migration[7.0]
  def change
    change_column_null :preorder_reservation_dates, :group_status, false
    change_column_null :preorder_reservation_groups_to_turns, :preorder_reservation_group_status, false
  end
end
