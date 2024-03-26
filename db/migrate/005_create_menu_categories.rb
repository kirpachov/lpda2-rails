# frozen_string_literal: true

class CreateMenuCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :menu_categories do |t|
      t.text    :status,      null: false
      t.integer :index,       null: false
      t.text    :secret,      null: false, unique: true, index: true
      t.text    :secret_desc, null: true
      t.jsonb   :other,       null: false, default: {}
      t.float   :price,       null: true
      t.bigint :parent_id,    null: true, index: true,
                              foreign_key: { to_table: :menu_categories, on_delete: :cascade }, class_name: 'Menu::Category'
      t.belongs_to :menu_visibility, null: true, foreign_key: true, index: true, on_delete: :cascade,
                                     class_name: 'Menu::Visibility'

      t.timestamps
      t.index %w[index parent_id], unique: true
      t.index :secret_desc, unique: true, where: 'secret_desc IS NOT NULL'
    end
  end
end
