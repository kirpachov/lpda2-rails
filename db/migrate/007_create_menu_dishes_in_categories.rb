# frozen_string_literal: true

class CreateMenuDishesInCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :menu_dishes_in_categories, id: :bigint do |t|
      t.belongs_to :menu_dish,        null: false, index: true, foreign_key: { to_table: :menu_dishes }
      t.bigint  :menu_category_id,    null: true, index: true
      t.integer :index,               null: false, index: true,
                                      comment: %(Index of the element in the list. Starts at 0.)

      t.timestamps

      # Two different elements in the same category cannot have the same index.
      t.index %i[index menu_category_id], unique: true, where: "menu_category_id IS NOT NULL",
                                          name: "index_index_menu_category_id"
      t.index %i[menu_dish_id menu_category_id], unique: true, where: "menu_category_id IS NOT NULL",
                                                 name: "index_menu_dish_id_menu_category_id"
    end
  end
end
