# frozen_string_literal: true

module Menu
  # Moving a dish to a new index in a category.
  # A dish may be shared between categories, so the index is unique within a category.
  # So when we 'move a dish', we actually move it to a new index in a category, we don't update the index of the dish itself.
  class MoveDish < ActiveInteraction::Base
    record :dish, class: "Menu::Dish"

    # Params:
    # - category_id: Integer
    # - to_index: Integer
    interface :params, methods: %i[[] merge! fetch each has_key?], default: {}

    validate do
      # NOTE: category_id can be nil.
      errors.add(:category_id, :invalid) if category_id.present? && category_id <= 0
      # errors.add(:category_id, :invalid) if category_id.to_i <= 0
      errors.add(:to_index, :missing) if to_index.nil?
      errors.add(:to_index, :invalid) if to_index.to_i.negative?
      errors.add(:base, "Dish is not in the category") unless association
    end

    def execute
      Menu::DishesInCategory.transaction do
        # smaller_index = [from_index, to_index].min
        # larger_index = [from_index, to_index].max
        # interested_indexes = (smaller_index..larger_index).to_a
        # going_up = to_index < from_index

        # items = siblings.where(index: interested_indexes).map do |join|
        #   join.index += going_up ? 1 : -1
        #   join
        # end

        # items << association.tap { |a| a.index = to_index }

        # Menu::DishesInCategory.where(id: items.map(&:id)).update_all("index = index + 100000")

        # Menu::DishesInCategory.import! items, on_duplicate_key_update: { conflict_target: %i[id], columns: %i[index] }

        ensure_sequential_indexes

        Menu::DishesInCategory.where(menu_category_id: category_id).update_all("index = index + 100000")

        items = Menu::DishesInCategory.where(menu_category_id: category_id).where.not(id: association.id)
                                      .order(:index).each_with_index
                                      .map do |dic, index|
          dic.index = index >= to_index ? index + 1 : index
          dic
        end

        Menu::DishesInCategory.import! items, on_duplicate_key_update: { conflict_target: %i[id], columns: %i[index] }

        association.update!(index: to_index)

        ensure_sequential_indexes

        raise ActiveRecord::Rollback if errors.any? || invalid?
      end

      dish.reload
    end

    private

    def ensure_sequential_indexes
      compose(
        AdjustDishesInCategoryOrder,
        category: association.category
      )
    end

    def to_index
      @to_index ||= params[:to_index].present? ? params[:to_index].to_i : nil
    end

    def from_index
      association.index
    end

    def category_id
      @category_id ||= params[:category_id].present? ? params[:category_id].to_i : nil
    end

    def association
      Menu::DishesInCategory.where(menu_dish: dish, menu_category_id: category_id).first
    end

    def siblings
      Menu::DishesInCategory.where(menu_category_id: category_id).where.not(id: association&.id)
    end
  end
end
