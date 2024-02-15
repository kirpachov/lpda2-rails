# frozen_string_literal: true

class CreateReservationTags < ActiveRecord::Migration[7.0]
  def change
    create_table :reservation_tags do |t|
      t.text :title,    null: false, index: { unique: true }
      t.text :bg_color, null: false
      t.text :color,    null: false

      t.timestamps
    end
  end
end
