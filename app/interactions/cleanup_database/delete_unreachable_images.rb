# frozen_string_literal: true

module CleanupDatabase
  # Warning! Not tested.
  # Delete all Image records that are not linked to any other record.
  # Usage from rails console:
  #   CleanupDatabase::DeleteUnreachableImages.run!(older_than: 2.months.ago.to_date, dry_run: true) # put dry_run: false to actually make changes
  class DeleteUnreachableImages < ActiveInteraction::Base
    date :older_than, default: 1.year.ago.to_date

    boolean :dry_run, default: true

    def execute
      return print_dry_run if dry_run

      images.map(&:deleted!)
    end

    private

    def print_dry_run
      msg = <<~MSG
        Running in dry run mode. Please provide dry_run: false to actually delete records.

        Images to be deleted (#{images.count})
      MSG

      puts msg
      Rails.logger.warn msg
    end

    def images
      Image.where("updated_at < ?", older_than).where.not(
        id: ImageToRecord.all.select(:image_id)
      )
    end
  end
end
