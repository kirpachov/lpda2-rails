# frozen_string_literal: true

class CreateTagInReservations < ActiveRecord::Migration[7.0]
  def change
    create_table :tag_in_reservations do |t|
      t.belongs_to :reservation, null: false, foreign_key: true
      t.belongs_to :reservation_tag, null: false, foreign_key: true

      t.timestamps
      t.index %w[reservation_id reservation_tag_id], unique: true, name: 'reservation_id_on_tags'
    end
  end
end
