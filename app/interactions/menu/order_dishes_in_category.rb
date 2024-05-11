# frozen_string_literal: true

module Menu
  # Order all items by a field.
  class OrderDishesInCategory < ActiveInteraction::Base
    record :category, class: "Menu::Category"
    string :field, default: "id"

    validate do
      errors.add(:category, "is not a category") unless category.is_a?(Menu::Category)
      errors.add(:field, "is not a valid field. Got #{field.inspect}") unless %w[id name].include?(field)
    end

    def execute
      Menu::Dish.transaction do
        @dishes = category.dishes.to_ary.sort_by { |d| d.send(field) }
        # debugger
        Menu::DishesInCategory.where(category:).update_all("index = index + 100000")
        @dishes.each_with_index { |dish, index| Menu::DishesInCategory.where(dish:, category:).update!(index:) }
        # @dishes = @dishes.each_with_index.map do |dish, index|
        #   # dish.index = index
        #   # dish
        #   dish.update!(index: index)
        # end

        # import = Menu::Dish.import(@dishes, on_duplicate_key_update: { conflict_target: [:id], columns: [:index] })
        # raise ActiveRecord::Rollback unless import.failed_instances.empty?
      end
    end
  end
end
