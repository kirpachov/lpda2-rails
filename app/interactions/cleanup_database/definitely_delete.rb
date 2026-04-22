# frozen_string_literal: true

module CleanupDatabase
  # Warning! Not tested.
  # Deleting all records marked as deleted and older than a specified date.
  # Usage from rails console:
  #   CleanupDatabase::DefinitelyDelete.run!(older_than: 2.months.ago.to_date,  dry_run: true) # put dry_run: false to actually make changes
  class DefinitelyDelete < ActiveInteraction::Base
    date :older_than, default: 1.year.ago.to_date

    boolean :dry_run, default: true

    def execute
      return print_dry_run if dry_run

      dishes_to_delete.map(&:destroy!)
      categories_to_delete.map(&:destroy!)
      tags_to_delete.map(&:destroy!)
      ingredients_to_delete.map(&:destroy!)
      allergens_to_delete.map(&:destroy!)
      reservations_to_delete.map(&:destroy!)
      users_to_delete.map(&:destroy!)
      Log::ImagePixel.where(image_id: images_to_delete.select(:id)).destroy_all
      images_to_delete.map(&:destroy!)
      table_types_to_delete.map(&:destroy!)
    end

    # private

    def print_dry_run
      msg = <<~MSG
        Running in dry run mode. Please provide dry_run: false to actually delete records.

        Dishes to be deleted (#{dishes_to_delete.count})
        Categories to be deleted (#{categories_to_delete.count})
        Tags to be deleted (#{tags_to_delete.count})
        Ingredients to be deleted (#{ingredients_to_delete.count})
        Allergens to be deleted (#{allergens_to_delete.count})
        Reservations to be deleted (#{reservations_to_delete.count})
        Users to be deleted (#{users_to_delete.count})
        Images to be deleted (#{images_to_delete.count})
        Table types to be deleted (#{table_types_to_delete.count})
      MSG

      puts msg
      Rails.logger.warn msg
    end

    def dishes_to_delete
      Menu::Dish.deleted.where("updated_at < ?", older_than)
    end

    def categories_to_delete
      Menu::Category.deleted.where("updated_at < ?", older_than).where.not(
        id: Menu::Category.where.not(parent_id: nil).select(:parent_id)
      ).where.not(
        id: Menu::Category.where.not(root_id: nil).select(:root_id)
      )
    end

    def tags_to_delete
      Menu::Tag.deleted.where("updated_at < ?", older_than)
    end

    def ingredients_to_delete
      Menu::Ingredient.deleted.where("updated_at < ?", older_than)
    end

    def allergens_to_delete
      Menu::Allergen.deleted.where("updated_at < ?", older_than)
    end

    def reservations_to_delete
      Reservation.deleted.where("updated_at < ?", older_than)
    end

    def users_to_delete
      User.deleted.where("updated_at < ?", older_than)
    end

    def images_to_delete
      Image.deleted.where("updated_at < ?", older_than)
    end

    def table_types_to_delete
      TableType.deleted.where("updated_at < ?", older_than)
    end
  end
end
