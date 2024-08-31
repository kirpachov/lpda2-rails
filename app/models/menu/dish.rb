# frozen_string_literal: true

module Menu
  class Dish < ApplicationRecord
    # ##############################
    # Constants, settings, modules, et...
    # ##############################
    include HasImagesAttached
    include TrackModelChanges
    extend Mobility
    translates :name
    translates :description

    VALID_STATUSES = %w[active inactive deleted].freeze

    enum status: VALID_STATUSES.map { |s| [s, s] }.to_h

    # ##############################
    # Associations
    # ##############################
    has_many :menu_dishes_in_categories, class_name: "Menu::DishesInCategory", foreign_key: :menu_dish_id,
                                         dependent: :destroy
    has_many :menu_categories, class_name: "Menu::Category", through: :menu_dishes_in_categories
    has_many :menu_ingredients_in_dishes, class_name: "Menu::IngredientsInDish", foreign_key: :menu_dish_id,
                                          dependent: :destroy
    has_many :menu_ingredients, class_name: "Menu::Ingredient", through: :menu_ingredients_in_dishes,
                                after_remove: :after_remove_ingredient
    has_many :menu_allergens_in_dishes, class_name: "Menu::AllergensInDish", foreign_key: :menu_dish_id,
                                        dependent: :destroy
    has_many :menu_allergens, class_name: "Menu::Allergen", through: :menu_allergens_in_dishes,
                              after_remove: :after_remove_allergen
    has_many :menu_tags_in_dishes, class_name: "Menu::TagsInDish", foreign_key: :menu_dish_id, dependent: :destroy
    has_many :menu_tags, class_name: "Menu::Tag", through: :menu_tags_in_dishes, after_remove: :after_remove_tag

    has_many :dish_suggestions, class_name: "Menu::DishSuggestion", dependent: :destroy
    has_many :suggestions, class_name: "Menu::Dish", through: :dish_suggestions, source: :suggestion

    alias_attribute :categories, :menu_categories
    alias_attribute :ingredients, :menu_ingredients
    alias_attribute :allergens, :menu_allergens
    alias_attribute :tags, :menu_tags

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
    # Scopes
    # ##############################
    scope :visible, -> { not_deleted }

    # ##############################
    # CLass methods
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

      def adjust_indexes_for_category(category_id)
        items = Menu::Dish.where(id: Menu::DishesInCategory.where(menu_category_id: category_id).order(:index).select(:menu_dish_id).limit(1))
        return if items.empty?

        items.first.move!(to_index: 0, category_id:)
      end

      def public_json(options = {})
        to_include = [:text_translations, { images: :attached_image_blob }]
        to_include << { suggestions: to_include.dup } if options[:include_suggestions] || options[:include_all]
        if options[:include_ingredients] || options[:include_all]
          to_include << { menu_ingredients: [:text_translations,
                                             { image: :attached_image_blob }] }
        end
        if options[:include_allergens] || options[:include_all]
          to_include << { menu_allergens: [:text_translations,
                                           { image: :attached_image_blob }] }
        end
        if options[:include_tags] || options[:include_all]
          to_include << { menu_tags: [:text_translations,
                                      { image: :attached_image_blob }] }
        end
        includes(to_include).map { |item| item.public_json(options) }
      end
    end

    # ##############################
    # Instance methods
    # ##############################
    def status=(value)
      super
    rescue ArgumentError
      @attributes.write_cast_value("status", value)
    end

    def after_remove_allergen(_allergen)
      Menu::Allergen.adjust_indexes_for_dish(id)
    end

    def after_remove_tag(_tag)
      Menu::Tag.adjust_indexes_for_dish(id)
    end

    def after_remove_ingredient(_ingredient)
      Menu::Ingredient.adjust_indexes_for_dish(id)
    end

    # @param [Hash] options
    # @option options [User] :current_user
    def copy!(options = {})
      CopyDish.run!(options.merge(old: self))
    end

    # @param [Hash] options
    # @option options [User] :current_user
    def copy(options = {})
      CopyDish.run(options.merge(old: self))
    end

    def assign_defaults
      self.status = "active" if status.blank?
      self.other = {} if other.nil?
    end

    def move!(to_index:, category_id:)
      MoveDish.run!(dish: self, params: { to_index:, category_id: })
    end

    def move(to_index:, category_id:)
      MoveDish.run(dish: self, params: { to_index:, category_id: })
    end

    def public_json(options = {})
      optional_data = {}
      if options[:include_ingredients] || options[:include_all]
        optional_data[:ingredients] = ingredients.map { |ingredient| ingredient.public_json }
      end

      optional_data[:tags] = tags.map { |tag| tag.public_json } if options[:include_tags] || options[:include_all]

      if options[:include_allergens] || options[:include_all]
        optional_data[:allergens] = allergens.map { |allergen| allergen.public_json }
      end

      if options[:include_suggestions] || options[:include_all]
        optional_data[:suggestions] = suggestions.map { |suggestion| suggestion.public_json }
      end

      as_json(only: %w[id status price created_at updated_at]).merge(
        name:,
        description:,
        images: images.map { |image| image.public_json },
        translations: translations_json
      ).merge(optional_data)
    end

    def references_json
      categories = []
      menu_categories.each do |category|
        categories << category.as_json(only: %i[id]).merge(name: category.name, breadcrumbs: category.breadcrumbs_json)
      end

      {
        categories:
      }
    end
  end
end
