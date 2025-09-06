# frozen_string_literal: true

module Menu
  # Will ensure valid :index values Menu::DishesInCategory for a given category.
  # Given a category_id, will ensure that:
  # - inactive dishes will be last
  # - indexes are sequential, starting from 0
  class AdjustDishesInCategoryOrder < ActiveInteraction::Base
    # ################################
    # Inputs
    # ################################
    record :category, class: "Menu::Category"

    delegate :menu_dishes_in_categories, to: :category

    def execute
      menu_dishes_in_categories.where(dish: Menu::Dish.where(status: %w[deleted inactive])).update_all("index = index + 100000")

      items = menu_dishes_in_categories.order(:index).each_with_index.map do |join, idx|
        join.index = idx
        join
      end

      Menu::DishesInCategory.import! items, on_duplicate_key_update: { conflict_target: %i[id], columns: %i[index] }
    end
  end
end
