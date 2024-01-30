# frozen_string_literal: true

class CreateMenuDishes < ActiveRecord::Migration[7.0]
  def change
    create_table :menu_dishes do |t|
      t.text    :status, null: false
      t.float   :price,  null: true, comment: %(The price of the dish. Can be null or 0 some cases, for example when the dish is inside a category with a fixed price.)
      t.jsonb   :other,  null: false, default: {}

      t.timestamps
    end
  end
end
