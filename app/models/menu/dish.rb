# frozen_string_literal: true

module Menu
  class Dish < ApplicationRecord

    # ##############################
    # Constants, settings, modules, et...
    # ##############################
    VALID_STATUSES = %w[active].freeze

    enum status: VALID_STATUSES.map{ |s| [s, s] }.to_h

    # ##############################
    # Associations
    # ##############################
    has_many :menu_dishes_in_categories, class_name: 'Menu::DishesInCategory', foreign_key: :menu_dish_id, dependent: :destroy
    has_many :menu_categories, class_name: 'Menu::Category', through: :menu_dishes_in_categories

    alias_attribute :categories, :menu_categories

    # ##############################
    # Validators
    # ##############################
    validates :price, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
    validates :status, presence: true, inclusion: { in: VALID_STATUSES }

    # ##############################
    # Hooks
    # ##############################
    before_validation :assign_defaults, on: :create

    # ##############################
    # Instance methods
    # ##############################
    def status=(value)
      super
    rescue ArgumentError
      @attributes.write_cast_value("status", value)
    end

    def assign_defaults
      self.status = 'active' if status.blank?
      self.other = {} if other.nil?
    end
  end
end
