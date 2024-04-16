# frozen_string_literal: true

class CreateMenuAllergens < ActiveRecord::Migration[7.0]
  def change
    create_table :menu_allergens do |t|
      t.text :status, null: false
      t.jsonb :other, null: false, default: {}
      t.integer :member_id

      t.timestamps
    end
  end
end
