# frozen_string_literal: true

module Menu
  class AllergensInDish < ApplicationRecord
    # ##############################
    # Associations
    # ##############################
    belongs_to :menu_dish, class_name: "Menu::Dish", optional: false
    belongs_to :menu_allergen, class_name: "Menu::Allergen", optional: false

    alias_attribute :dish, :menu_dish
    alias_attribute :allergen, :menu_allergen

    alias_attribute :dish_id, :menu_dish_id
    alias_attribute :allergen_id, :menu_allergen_id

    # ##############################
    # Validations
    # ##############################
    validates :index, numericality: { greater_than_or_equal_to: 0 }, allow_nil: false, uniqueness: { scope: :dish_id }
    validates :menu_dish_id, uniqueness: { scope: :menu_allergen_id }

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
