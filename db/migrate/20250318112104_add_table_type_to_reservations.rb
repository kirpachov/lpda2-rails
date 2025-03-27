# frozen_string_literal: true

class AddTableTypeToReservations < ActiveRecord::Migration[7.0]
  def change
    add_column :reservations, :table_type_id, :bigint
    add_foreign_key :reservations, :table_types, column: :table_type_id
  end
end
