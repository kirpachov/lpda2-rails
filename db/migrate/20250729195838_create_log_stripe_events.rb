# frozen_string_literal: true

class CreateLogStripeEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :log_stripe_events do |t|
      t.float :duration
      t.integer :http_status
      t.text :method
      t.integer :num_retries
      t.text :path
      t.text :request_id
      t.jsonb :user_data
      t.jsonb :response_header
      t.jsonb :response_body
      t.jsonb :request_header
      t.jsonb :request_body
      t.jsonb :raw

      t.timestamps
    end
  end
end
