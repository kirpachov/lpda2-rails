# frozen_string_literal: true

class CreateRefreshTokens < ActiveRecord::Migration[7.0]
  def change
    create_table :refresh_tokens do |t|
      t.text :secret,          unique: true, index: true, null: false
      t.timestamp :expires_at, null: false
      t.references :user,      null: false, foreign_key: true

      t.timestamps
    end
  end
end
