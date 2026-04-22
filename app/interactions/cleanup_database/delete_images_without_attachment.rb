# frozen_string_literal: true

module CleanupDatabase
  # Warning! Not tested.
  # Delete all Image records that do not have an attachment.
  # Usage from rails console:
  #   CleanupDatabase::DeleteImagesWithoutAttachment.run!(older_than: 2.months.ago.to_date, dry_run: true) # put dry_run: false to actually make changes
  class DeleteImagesWithoutAttachment < ActiveInteraction::Base
    date :older_than, default: 1.year.ago.to_date

    boolean :dry_run, default: true

    def execute
      return print_dry_run if dry_run

      images_without_attachment.map(&:deleted!)
    end

    private

    def print_dry_run
      msg = <<~MSG
        Running in dry run mode. Please provide dry_run: false to actually delete records.

        Images to be deleted (#{images_without_attachment.count})
      MSG

      puts msg
      Rails.logger.warn msg
    end

    def images_without_attachment
      Image.where("updated_at < ?", older_than).where.not(
        id: ActiveStorage::Attachment.where(record_type: "Image").select(:record_id)
      )
    end
  end
end
