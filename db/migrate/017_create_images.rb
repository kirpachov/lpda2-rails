# frozen_string_literal: true

class CreateImages < ActiveRecord::Migration[7.0]
  def change
    create_table :images do |t|
      t.text :filename,     null: false, index: true, unique: true
      t.text :status,       null: false
      t.text :tag,          null: true,
                            comment: %(Internal tag for image. A tag may be 'blur', 'thumbnail', ... May be nil when is original image.)
      t.references :original, null: true, foreign_key: { to_table: :images }
      t.jsonb :other,       null: false, default: {}

      # Initially the files will be loaded inside the application from seeds, but users will be able to update them.
      t.text :key,          null: true, comment: %(Key for finding the Image for a certain purpose.)

      t.integer :member_id

      t.timestamps
      t.index %i[tag original_id], unique: true, where: "original_id IS NOT NULL"
      t.index :key, unique: true, where: "key IS NOT NULL"
    end
  end
end
