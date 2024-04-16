# frozen_string_literal: true

module Menu
  class TagsInDish < ApplicationRecord
    # ##############################
    # Associations
    # ##############################
    belongs_to :menu_dish, class_name: "Menu::Dish", optional: false
    belongs_to :menu_tag, class_name: "Menu::Tag", optional: false

    alias_attribute :dish, :menu_dish
    alias_attribute :tag, :menu_tag

    alias_attribute :dish_id, :menu_dish_id
    alias_attribute :tag_id, :menu_tag_id

    # ##############################
    # Validations
    # ##############################
    validates :index, numericality: { greater_than_or_equal_to: 0 }, allow_nil: false, uniqueness: { scope: :dish_id }
    validates :menu_tag_id, uniqueness: { scope: :menu_dish_id }

    # ##############################
    # Callbacks
    # ##############################
    after_initialize :assign_valid_index, if: -> { new_record? }

    # ##############################
    # Instance methods
    # ##############################
    def assign_valid_index
      return if index.present? && index.to_i >= 0

      self.index = self.class.where(dish_id:).count
    end
  end
end
