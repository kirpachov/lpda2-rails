# frozen_string_literal: true

module Dev
  # Will delete all blobs from ActiveStorage.
  class RunDevSetup::DeleteAllBlobs < ActiveInteraction::Base
    def execute
      raise "It's production!" if Rails.env.production?

      %w[
        active_storage_attachments
        active_storage_blobs
        active_storage_variant_records
      ].each do |table_name|
        ActiveRecord::Base.connection.execute("DELETE FROM #{table_name}")
      end
    end
  end
end
