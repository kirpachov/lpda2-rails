# frozen_string_literal: true

class CreateMenuVisibilities < ActiveRecord::Migration[7.0]
  def change
    create_table :menu_visibilities do |t|
      t.boolean   :public_visible,    null: false, default: false
      t.timestamp :public_from,       null: true
      t.timestamp :public_to,         null: true
      t.boolean   :private_visible,   null: false, default: false
      t.timestamp :private_from,      null: true
      t.timestamp :private_to,        null: true

      t.time :daily_from, null: true, comment: %(
        From this time and until daily_to, the category will be visible in the public page.
        Useful in case you'd want to show "Lunch" menu only from 12:00 to 15:00.
        If daily_to is nil, it will be visible until the end of the day.
        If daily_from is nil, it will be visible from the beginning of the day.
      ).strip

      t.time :daily_to, null: true

      t.timestamps
    end
  end
end
