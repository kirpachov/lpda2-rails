# frozen_string_literal: true

class CreateMenuTagsInDishes < ActiveRecord::Migration[7.0]
  def change
    create_table :menu_tags_in_dishes do |t|
      t.references :menu_dish, null: false, foreign_key: true
      t.references :menu_tag, null: false, foreign_key: true
      t.integer :index, null: false

      t.timestamps
      t.index %i[menu_dish_id menu_tag_id], unique: true, name: :index_menu_tags_in_dishes_on_dish_and_tag
      t.index %i[menu_dish_id index], unique: true
    end
  end
end
