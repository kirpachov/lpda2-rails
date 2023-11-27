# frozen_string_literal: true

class CreateImages < ActiveRecord::Migration[7.0]
  def change
    create_table :images do |t|
      t.text :filename,     null: false, index: true, unique: true
      t.text :status,       null: false
      t.text :tag,          null: true, comment: %(Internal tag for image. A tag may be 'blur', 'thumbnail', ... May be nil when is original image.)
      t.references :original, null: true, foreign_key: { to_table: :images }
      t.jsonb :other,       null: false, default: {}

      t.timestamps
      t.index %i[tag original_id], unique: true, where: 'original_id IS NOT NULL'
    end
  end
end
