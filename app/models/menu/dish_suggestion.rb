# frozen_string_literal: true

module Menu
  # You may want to suggest your customers a pair of dishes that go well together.
  # This model allows you to do that.
  class DishSuggestion < ApplicationRecord
    # ##############################
    # Associations
    # ##############################
    # "dish" is the dish that user is looking at.
    belongs_to :dish, class_name: "Menu::Dish"
    # "suggestion" is the dish that is suggested to go with the dish.
    belongs_to :suggestion, class_name: "Menu::Dish"

    # ##############################
    # Validations
    # ##############################
    validate :dish_id_not_equal_suggestion_id
    validates :dish_id, uniqueness: { scope: :suggestion_id }, if: -> { dish_id.present? && suggestion_id.present? }

    private

    def dish_id_not_equal_suggestion_id
      return if dish_id.blank? || suggestion_id.blank?
      return if dish_id != suggestion_id

      errors.add(:base, "Dish and suggestion should not be the same")
    end
  end
end
