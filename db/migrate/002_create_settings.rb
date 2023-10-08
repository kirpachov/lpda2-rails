# frozen_string_literal: true

class CreateSettings < ActiveRecord::Migration[7.0]
  def change
    create_table :settings do |t|
      t.text :key, null: false, index: { unique: true }
      t.text :value
      t.boolean :require_root, default: true, null: false, comment: 'Require user to be root to change this setting'

      t.timestamps
    end
  end
end
