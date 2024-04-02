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
      # Note: category_id can be nil.
      errors.add(:category_id, :invalid) if category_id.present? && category_id <= 0
      # errors.add(:category_id, :invalid) if category_id.to_i <= 0
      errors.add(:to_index, :missing) if to_index.nil?
      errors.add(:to_index, :invalid) if to_index.to_i.negative?
      errors.add(:base, "Dish is not in the category") unless association
    end

    def execute
      Menu::DishesInCategory.transaction do
        Menu::DishesInCategory.where(menu_category_id: category_id).update_all("index = index + 100000")

        items = Menu::DishesInCategory.where(menu_category_id: category_id).where.not(id: association.id)
                                      .order(:index).each_with_index
                                      .map do |dic, index|
          dic.index = index >= to_index ? index + 1 : index
          dic
        end

        Menu::DishesInCategory.import! items, on_duplicate_key_update: { conflict_target: %i[id], columns: %i[index] }

        association.update!(index: to_index)

        raise ActiveRecord::Rollback if errors.any? || invalid?
      end

      dish.reload
    end

    private

    def to_index
      @to_index ||= params[:to_index].present? ? params[:to_index].to_i : nil
    end

    def category_id
      @category_id ||= params[:category_id].present? ? params[:category_id].to_i : nil
    end

    def association
      @association ||= Menu::DishesInCategory.where(menu_dish: dish, menu_category_id: category_id).first
    end

    def siblings
      @siblings ||= Menu::DishesInCategory.where(menu_category_id: category_id).where.not(id: association&.id).order(:index)
    end
  end
end
