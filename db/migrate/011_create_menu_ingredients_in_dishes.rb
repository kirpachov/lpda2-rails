# frozen_string_literal: true

class CreateMenuIngredientsInDishes < ActiveRecord::Migration[7.0]
  def change
    create_table :menu_ingredients_in_dishes do |t|
      t.references :menu_dish, null: false, foreign_key: true
      t.references :menu_ingredient, null: false, foreign_key: true
      t.integer :index, null: false

      t.timestamps
      t.index %i[menu_dish_id menu_ingredient_id], unique: true,
                                                   name: :index_menu_ingredients_in_dishes_on_dish_and_ingredient
      t.index %i[menu_dish_id index], unique: true
    end
  end
end
