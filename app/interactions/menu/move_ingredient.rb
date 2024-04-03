# frozen_string_literal: true

module Menu
  # Moving a ingredient to a new index in a dish.
  class MoveIngredient < ActiveInteraction::Base
    record :ingredient, class: "Menu::Ingredient"

    # Params:
    # - dish_id: Integer
    # - to_index: Integer
    interface :params, methods: %i[[] merge! fetch each has_key?], default: {}

    validate do
      errors.add(:ingredient, :missing) if ingredient.blank?
      errors.add(:dish_id, :invalid) if dish_id.blank? || dish_id.to_i <= 0
      errors.add(:to_index, :invalid) if to_index.blank? || to_index.to_i.negative?
      errors.add(:base, "Ingredient is not in the dish") unless association
    end

    def execute
      Menu::IngredientsInDish.transaction do
        Menu::IngredientsInDish.where(dish_id:).update_all("index = index + 100000")

        items = Menu::IngredientsInDish.where(dish_id:).where.not(id: association.id)
                                       .order(:index).each_with_index
                                       .map do |dic, index|
          dic.index = index >= to_index ? index + 1 : index
          dic
        end

        Menu::IngredientsInDish.import! items, on_duplicate_key_update: { conflict_target: %i[id], columns: %i[index] }

        association.update!(index: to_index)

        raise ActiveRecord::Rollback if errors.any? || invalid?
      end

      ingredient.reload
    end

    private

    def to_index
      @to_index ||= params[:to_index].present? ? params[:to_index].to_i : nil
    end

    def dish_id
      @dish_id ||= params[:dish_id].present? ? params[:dish_id].to_i : nil
    end

    def association
      @association ||= Menu::IngredientsInDish.where(menu_ingredient: ingredient, dish_id:).first
    end

    def siblings
      @siblings ||= Menu::IngredientsInDish.where(dish_id:).where.not(id: association&.id).order(:index)
    end
  end
end
