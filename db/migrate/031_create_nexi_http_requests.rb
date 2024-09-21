# frozen_string_literal: true

# Create Nexi::HttpRequests table
class CreateNexiHttpRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :nexi_http_requests do |t|
      t.jsonb     :request_body,  null: false
      t.jsonb     :response_body, null: false
      t.text      :url,           null: false
      t.integer   :http_code,     null: false
      t.string    :http_method,   null: false
      t.timestamp :started_at,    null: false
      t.timestamp :ended_at,      null: false

      t.timestamps
    end
  end
end
