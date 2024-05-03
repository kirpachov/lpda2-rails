# frozen_string_literal: true

class CreateResetPasswordSecrets < ActiveRecord::Migration[7.0]
  def change
    create_table :reset_password_secrets do |t|
      t.text :secret, null: false
      t.belongs_to :user, null: false, foreign_key: true
      t.timestamp :expires_at, null: false, default: -> { "NOW() + '15 minutes'::interval" }

      t.timestamps
      t.index :secret, unique: true
    end
  end
end
