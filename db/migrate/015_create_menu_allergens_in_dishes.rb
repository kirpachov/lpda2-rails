class CreateMenuAllergensInDishes < ActiveRecord::Migration[7.0]
  def change
    create_table :menu_allergens_in_dishes do |t|
      t.references :menu_dish, null: false, foreign_key: true
      t.references :menu_allergen, null: false, foreign_key: true
      t.integer :index, null: false

      t.timestamps
      t.index %i[menu_dish_id menu_allergen_id], unique: true, name: :index_menu_allergens_in_dishes_on_dish_and_allergen
      t.index %i[menu_dish_id index], unique: true
    end
  end
end
