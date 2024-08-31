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
    has_many :menu_allergens_in_dishes, class_name: "Menu::AllergensInDish", foreign_key: :menu_allergen_id,
                                        dependent: :destroy
    has_many :menu_dishes, class_name: "Menu::Dish", through: :menu_allergens_in_dishes
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
    # Class methods
    # ##############################
    class << self
      def filter_by_query(query)
        return all unless query.present?

        where_name(query).or(where_description(query))
      end

      def where_name(query)
        return all unless query.present?

        where(id: ransack(name_cont: query).result.select(:id))
      end

      def where_description(query)
        return all unless query.present?

        where(id: ransack(description_cont: query).result.select(:id))
      end

      def adjust_indexes_for_dish(dish_id)
        items = Menu::Allergen.where(id: Menu::AllergensInDish.where(menu_dish_id: dish_id).order(:index).select(:menu_allergen_id).limit(1))
        return if items.empty?

        items.first.move!(to_index: 0, dish_id:)
      end

      def public_json(options = {})
        includes(:text_translations, image: :attached_image_blob).map { |item| item.public_json(options) }
      end
    end

    # ##############################
    # Instance methods
    # ##############################
    def public_json(_options = {})
      as_json(only: %w[id status created_at updated_at]).merge(
        name:,
        description:,
        image: image&.public_json,
        translations: translations_json
      )
    end

    def assign_defaults
      self.other = {} if other.nil?
      self.status = "active" if status.blank?
    end

    # @param [Hash] options
    # @option options [User] :current_user
    def copy!(options = {})
      CopyAllergen.run!(options.merge(old: self))
    end

    # @param [Hash] options
    # @option options [User] :current_user
    def copy(options = {})
      CopyAllergen.run(options.merge(old: self))
    end

    def status=(value)
      super
    rescue ArgumentError
      @attributes.write_cast_value("status", value)
    end

    def move!(to_index:, dish_id:)
      MoveAllergen.run!(allergen: self, params: { to_index:, dish_id: })
    end

    def move(to_index:, dish_id:)
      MoveAllergen.run(allergen: self, params: { to_index:, dish_id: })
    end

    private

    def other_cannot_be_nil
      return unless other.nil?

      errors.add(:other, "can't be nil")
    end
  end
end
