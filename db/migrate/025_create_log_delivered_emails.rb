# frozen_string_literal: true

class CreateLogDeliveredEmails < ActiveRecord::Migration[7.0]
  def change
    create_table :log_delivered_emails do |t|
      t.belongs_to :record, polymorphic: true, index: true, comment: %(Record this email is associated. Optional.), null: true
      t.text :text
      t.text :html
      t.text :subject
      t.jsonb :headers
      t.text :raw

      t.timestamps
    end
  end
end
