# frozen_string_literal: true

class CreateMenuTags < ActiveRecord::Migration[7.0]
  def change
    create_table :menu_tags do |t|
      t.text :color,    null: false
      t.text :status,   null: false
      t.jsonb :other, null: false, default: {}
      t.integer :member_id

      t.timestamps
    end
  end
end
