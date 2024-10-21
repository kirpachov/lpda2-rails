# frozen_string_literal: true

class CreateHolidays < ActiveRecord::Migration[7.0]
  def change
    create_table :holidays do |t|
      t.timestamp :from_timestamp, null: false, comment: %(From this moment on, the holiday is considered active)
      t.timestamp :to_timestamp, comment: %(If present, the holiday is considered active until this moment)
      t.time :weekly_from, comment: %(If present, the holiday is considered active until 'weekly_to', but only after from_timestamp.)
      t.time :weekly_to
      t.integer :weekday, comment: %(If present, the holiday is considered active only on this weekday.)

      t.timestamps
    end
  end
end
