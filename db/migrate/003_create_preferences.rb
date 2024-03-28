# frozen_string_literal: true

class CreatePreferences < ActiveRecord::Migration[7.0]
  def change
    create_table :preferences do |t|
      t.text :key, null: false
      t.text :value
      t.belongs_to :user, null: false, foreign_key: true
      t.boolean :require_root, default: true, null: false, comment: "Require user to be root to change this setting"

      t.timestamps
      t.index %i[user_id key], unique: true
    end
  end
end
