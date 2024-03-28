# frozen_string_literal: true

module Menu
  # Join table between Dish and Category models.
  class DishesInCategory < ApplicationRecord
    # ##############################
    # Associations
    # ##############################
    belongs_to :menu_dish, class_name: 'Menu::Dish', optional: false
    belongs_to :menu_category, class_name: 'Menu::Category', optional: true

    # ##############################
    # Aliases
    # ##############################
    alias_attribute :dish, :menu_dish
    alias_attribute :category, :menu_category

    alias_attribute :dish_id, :menu_dish_id
    alias_attribute :category_id, :menu_category_id

    # ##############################
    # Validations
    # ##############################
    validates :index, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true,
                      uniqueness: { scope: :category_id }
    validates :menu_dish_id, uniqueness: { scope: :menu_category_id }, if: -> { menu_category_id.present? }

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
      self.index = self.class.where(category:).order(index: :desc).first&.index.to_i + 1
    end
  end
end
