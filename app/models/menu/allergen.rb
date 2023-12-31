# frozen_string_literal: true

module Menu
  class Allergen < ApplicationRecord

    # ##############################
    # Constants, settings, modules, et...
    # ##############################
    VALID_STATUSES = %w[active deleted].freeze
    include HasImageAttached
    include TrackModelChanges

    extend Mobility
    translates :name
    translates :description

    enum status: VALID_STATUSES.map { |s| [s, s] }.to_h

    # ##############################
    # Associations
    # ##############################
    has_many :menu_allergens_in_dishes, class_name: 'Menu::AllergensInDish', foreign_key: :menu_allergen_id, dependent: :destroy
    has_many :menu_dishes, class_name: 'Menu::Dish', through: :menu_allergens_in_dishes
    alias_attribute :dishes, :menu_dishes

    # ##############################
    # Validators
    # ##############################
    validates :status, presence: true, inclusion: { in: VALID_STATUSES }
    validate :other_cannot_be_nil

    # ##############################
    # Callbacks
    # ##############################
    before_validation :assign_defaults, on: :create

    # ##############################
    # Scopes
    # ##############################
    scope :visible, -> { not_deleted }

    # ##############################
    # Instance methods
    # ##############################
    def assign_defaults
      self.other = {} if other.nil?
      self.status = 'active' if status.blank?
    end

    def status=(value)
      super
    rescue ArgumentError
      @attributes.write_cast_value("status", value)
    end

    private

    def other_cannot_be_nil
      return unless other.nil?

      errors.add(:other, "can't be nil")
    end
  end
end
