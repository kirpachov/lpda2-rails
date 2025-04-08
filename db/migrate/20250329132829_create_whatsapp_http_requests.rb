# frozen_string_literal: true

class CreateWhatsappHttpRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :whatsapp_http_requests do |t|
      t.jsonb     :request_body,      null: false
      t.jsonb     :request_headers,   null: true
      t.jsonb     :response_headers,  null: true
      t.jsonb     :json_response,     null: true, comment: %(When response is json, will be stored here.)
      t.text      :html_response,     null: true, comment: %(When response is html, will be stored here.)
      t.text      :url,               null: false
      t.integer   :http_code,         null: false
      t.string    :http_method,       null: false
      t.timestamp :started_at,        null: false
      t.timestamp :ended_at,          null: false

      t.belongs_to :record, polymorphic: true, null: true,
                            comment: %(Optionally specify a record this http request belongs to)

      t.text :purpose, comment: %(Specify the reason this request was made, optional)

      t.timestamps
    end
  end
end
