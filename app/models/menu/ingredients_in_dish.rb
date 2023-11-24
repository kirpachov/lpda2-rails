# frozen_string_literal: true

module Menu
  class IngredientsInDish < ApplicationRecord
    # ##############################
    # Associations
    # ##############################
    belongs_to :menu_dish, class_name: "Menu::Dish", optional: false
    belongs_to :menu_ingredient, class_name: "Menu::Ingredient", optional: false

    alias_attribute :dish, :menu_dish
    alias_attribute :ingredient, :menu_ingredient

    alias_attribute :dish_id, :menu_dish_id
    alias_attribute :ingredient_id, :menu_ingredient_id

    # ##############################
    # Validations
    # ##############################
    validates :index, numericality: { greater_than_or_equal_to: 0 }, allow_nil: false, uniqueness: { scope: :dish_id }

    # ##############################
    # Callbacks
    # ##############################
    before_validation :assign_defaults, on: :create
    before_validation :assign_valid_index, on: :update

    # ##############################
    # Instance methods
    # ##############################
    def assign_defaults
      assign_valid_index if index.to_i <= 0
    end

    def assign_valid_index
      self.index = self.class.where(dish: dish).order(index: :desc).first&.index.to_i + 1
    end
  end
end
