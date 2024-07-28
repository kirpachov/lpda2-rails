# frozen_string_literal: true

class CreatePublicMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :public_messages do |t|
      t.text :key, null: false, index: { unique: true }, comment: %(position id where the message should be shown)
      t.text :status, null: false, default: :active

      t.timestamps
    end
  end
end
