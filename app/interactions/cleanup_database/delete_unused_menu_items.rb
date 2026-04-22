# frozen_string_literal: true

module CleanupDatabase
  # Warning! Not tested.
  # All records older than a specified date and not visible in the public menu page, will be marked as deleted.
  # Usage from rails console:
  #   CleanupDatabase::DeleteUnusedMenuItems.run!(older_than: 2.months.ago.to_date, dry_run: true) # put dry_run: false to actually make changes
  class DeleteUnusedMenuItems < ActiveInteraction::Base
    date :older_than, default: 1.year.ago.to_date

    boolean :dry_run, default: true

    def execute
      return print_dry_run if dry_run

      invisible_menu_categories.map(&:deleted!)
      invisible_dishes.map(&:deleted!)
      invisible_menu_tags.map(&:deleted!)
      invisible_allergens.map(&:deleted!)
      invisible_ingredients.map(&:deleted!)
    end

    private

    def do_spider_check
      allergen_ids = []
      tag_ids = []
      ingredient_ids = []

      Menu::Category.visible.find_each do |j|
        j.dishes.visible.find_each do |dish|
          allergen_ids += dish.allergens.visible.pluck(:id)
          tag_ids += dish.tags.visible.pluck(:id)
          ingredient_ids += dish.ingredients.visible.pluck(:id)
        end
      end

      still_visible_allergens = Menu::Allergen.visible.where.not(id: allergen_ids)
      still_visible_tags = Menu::Tag.visible.where.not(id: tag_ids)
      still_visible_ingredients = Menu::Ingredient.visible.where.not(id: ingredient_ids)

      return if still_visible_allergens.empty? && still_visible_tags.empty? && still_visible_ingredients.empty?

      errors.add(:base,
      <<~MSG
        Spider check failed.
        Theese records should probably not be visible but they are.
        Allergens: #{still_visible_allergens.count}. Example: #{still_visible_allergens.sample(5).map(&:id)}
        Tags: #{still_visible_tags.count}. Example: #{still_visible_tags.sample(5).map(&:id)}
        Ingredients: #{still_visible_ingredients.count}. Example: #{still_visible_ingredients.sample(5).map(&:id)}
      MSG
      )
      # if still_visible_allergens.any? || still_visible_tags.any? || still_visible_ingredients.any?

        # errors.add(:base, "Spider check failed! There are still visible allergens, tags or ingredients that are not associated to any visible dish. Please investigate before running the cleanup.")
      # end
    end

    def print_dry_run
      msg = <<~MSG
        Running in dry run mode. Please provide dry_run: false to actually delete records.
        Note that the counts are probably understimated, as they don't take into account the cascading effect of deleting menu categories and dishes.

        Menu categories to be deleted (#{invisible_menu_categories.count})
        Dishes to be deleted (#{invisible_dishes.count})
        Menu tags to be deleted (#{invisible_menu_tags.count})
        Allergens to be deleted (#{invisible_allergens.count})
        Ingredients to be deleted (#{invisible_ingredients.count})
      MSG

      puts msg
      Rails.logger.warn msg
    end

    def invisible_menu_categories
      Menu::Category.not_deleted.where("updated_at < ?", older_than).where(parent_id: Menu::Category.deleted.select(:id)).or(
        Menu::Category.not_deleted.where("updated_at < ?", older_than).where(root_id: Menu::Category.deleted.select(:id))
      )
    end

    def invisible_dishes
      Menu::Dish.not_deleted.where("updated_at < ?", older_than).where.not(
        id: Menu::DishesInCategory.where(category_id: Menu::Category.visible.select(:id)).select(:dish_id)
      )
    end

    def invisible_menu_tags
      Menu::Tag.not_deleted.where("updated_at < ?", older_than).where.not(
        id: Menu::TagsInDish.where(dish_id: Menu::Dish.visible.select(:id)).select(:tag_id)
      )
    end

    def invisible_allergens
      Menu::Allergen.not_deleted.where("updated_at < ?", older_than).where.not(
        id: Menu::AllergensInDish.where(dish_id: Menu::Dish.visible.select(:id)).select(:allergen_id)
      )
    end

    def invisible_ingredients
      Menu::Ingredient.not_deleted.where("updated_at < ?", older_than).where.not(
        id: Menu::IngredientsInDish.where(dish_id: Menu::Dish.visible.select(:id)).select(:ingredient_id)
      )
    end
  end
end
