# frozen_string_literal: true

module CleanupDatabase
  # Warning! Not tested.
  # Delete all Image records that raise an ActiveStorage::FileNotFoundError when trying to download the attached file.
  # Usage from rails console:
  #   CleanupDatabase::DeleteImagesWithBrokenFile.run!(older_than: 2.months.ago.to_date, dry_run: true) # put dry_run: false to actually make changes
  class DeleteImagesWithBrokenFile < ActiveInteraction::Base
    date :older_than, default: 1.year.ago.to_date

    boolean :dry_run, default: true

    def execute
      return print_dry_run if dry_run

      images_with_broken_file.map(&:deleted!)
    end

    private

    def print_dry_run
      msg = <<~MSG
        Running in dry run mode. Please provide dry_run: false to actually delete records.

        Images to be deleted (#{images_with_broken_file.count})
      MSG

      puts msg
      Rails.logger.warn msg
    end

    def images_with_broken_file
      Image.where("updated_at < ?", older_than).includes(:attached_image_blob).find_each.select do |image|
        begin
          image.download
          false
        rescue ActiveStorage::FileNotFoundError => _e
          # Rails.logger.warn "Image with ID #{image.id} has a broken attachment: #{e.message}"
          true
        end
      end
    end
  end
end
