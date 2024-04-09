# frozen_string_literal: true

class CreateMenuDishSuggestions < ActiveRecord::Migration[7.0]
  def change
    create_table :menu_dish_suggestions do |t|
      t.belongs_to :dish, null: false, foreign_key: { to_table: :menu_dishes }
      t.belongs_to :suggestion, null: false, foreign_key: { to_table: :menu_dishes }
      t.integer :index, null: false

      t.timestamps
      t.index %w[dish_id suggestion_id], unique: true
      t.index %w[dish_id index], unique: true
      # I want to make sure that dish_id is always != suggestion_id
      t.check_constraint "dish_id != suggestion_id", name: "dish_id_not_equal_suggestion_id"
    end
  end
end
