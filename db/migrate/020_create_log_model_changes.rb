# frozen_string_literal: true

# Creating ModelChange's table
class CreateLogModelChanges < ActiveRecord::Migration[7.0]
  def change
    create_table :log_model_changes, id: "bigserial" do |t| # rubocop:disable Metrics/BlockLength
      t.references  :record,
                    polymorphic: true,
                    null: false,
                    index: true,
                    comment: %(Record that was changed.)

      t.references  :user,
                    null: true,
                    foreign_key: { to_table: :users },
                    index: true,
                    comment: %(User who made the change.)

      t.string      :change_type,
                    null: false,
                    index: true,
                    comment: %(Type of change. One of: create, update, destroy.)

      t.jsonb       :record_changes,
                    null: false,
                    comment: %(Changes made to the record. Format: { field_name: [old_value, new_value] })

      t.string      :changed_fields,
                    array: true,
                    comment: %(List of fields that were changed. Format: [field_name1, field_name2, ...])

      t.integer     :version,
                    null: false,
                    comment: %(Version of the record. Incremented on each change.)

      t.jsonb       :other,
                    null: true,
                    default: {}

      t.timestamps
    end
  end
end
