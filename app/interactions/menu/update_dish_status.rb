# frozen_string_literal: true

module Menu
  # Utility to update a dish status, and perform after-update actions.
  class UpdateDishStatus < ActiveInteraction::Base
    record :dish, class: Menu::Dish
    string :new_status

    delegate :menu_categories, to: :dish

    def execute
      return true if dish.status == new_status

      dish.status = new_status

      if dish.valid? && dish.save
        after_update_actions
        return true
      end

      errors.merge!(dish.errors)
      false
    end

    def after_update_actions
      menu_categories.each do |category|
        compose(
          AdjustDishesInCategoryOrder,
          category:
        )
      end
    end
  end
end
