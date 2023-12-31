# frozen_string_literal: true

class CreateImageToRecords < ActiveRecord::Migration[7.0]
  def change
    create_table :image_to_records do |t|
      t.references :image, null: false, foreign_key: true
      t.references :record, null: false, polymorphic: true

      t.timestamps
      t.index [:record_type, :record_id, :image_id], unique: true, name: 'index_image_to_records_on_record_and_image'
    end
  end
end
