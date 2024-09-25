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

      t.belongs_to :record, polymorphic: true, null: true, comment: %(Optionally specify a record this http request belongs to)
      t.text :purpose, comment: %(Specify the reason this request was made, optional)

      t.timestamps
    end
  end
end
