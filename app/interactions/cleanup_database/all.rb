# frozen_string_literal: true

module CleanupDatabase
  # Warning! Not tested.
  #
  # Run all cleanup interactions.
  # First, will delete old records marked as "deleted",
  # then will mark as "deleted" all records that are either not visible or are not valid anymore.
  # Usage from rails console:
  #   CleanupDatabase::All.run!(older_than: 2.months.ago.to_date, dry_run: true) # put dry_run: false to actually make changes
  # To make a brutal cleanup, in the sense of deleting all invalid/unreachable records regardless of their age, you can run:
  #   CleanupDatabase::All.run!(dry_run: true, older_than: 1.day.from_now.to_date)
  class All < ActiveInteraction::Base
    boolean :dry_run, default: true

    date :older_than, default: 1.year.ago.to_date

    def execute
      CleanupDatabase::DefinitelyDelete.run!(older_than:, dry_run:)

      CleanupDatabase::DeleteImagesWithBrokenFile.run!(older_than:, dry_run:)
      CleanupDatabase::DeleteUnusedMenuItems.run!(older_than:, dry_run:)
      CleanupDatabase::DeleteUnreachableImages.run!(older_than:, dry_run:)
      CleanupDatabase::DeleteImagesWithoutAttachment.run!(older_than:, dry_run:)
    end
  end
end
