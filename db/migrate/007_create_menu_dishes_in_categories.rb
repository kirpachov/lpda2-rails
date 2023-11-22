# frozen_string_literal: true

class CreateMenuDishesInCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :menu_dishes_in_categories, id: :bigint do |t|
      t.bigint  :menu_dish_id,       null: false, index: true
      t.bigint  :menu_category_id,   null: false, index: true
      t.bigint  :menu_visibility_id, null: false, index: true
      t.integer :index,         null: false, index: true, comment: %(Index of the element in the list. Starts at 0.)

      t.timestamps

      # Two different elements in the same category cannot have the same index.
      t.index %i[index menu_category_id], unique: true
    end
  end
end
