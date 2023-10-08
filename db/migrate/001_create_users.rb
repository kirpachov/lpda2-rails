# frozen_string_literal: true

# Users of the application.
class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.text      :fullname,        null: true
      t.text      :username,        null: true, index: { unique: true, where: 'username IS NOT NULL' }
      t.text      :email,           null: false, index: { unique: true }
      t.text      :password_digest, null: false
      t.timestamp :root_at
      t.integer   :failed_attempts, default: 0, null: false
      t.text      :enc_otp_key
      t.timestamp :locked_at

      t.timestamps
    end
  end
end
