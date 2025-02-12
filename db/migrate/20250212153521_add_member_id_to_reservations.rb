class AddMemberIdToReservations < ActiveRecord::Migration[7.0]
  def change
    add_column :reservations, :member_id, :text
  end
end
