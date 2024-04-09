# frozen_string_literal: true

module Menu
  # Deep copy for a Menu::Dish record.
  class CopyDish < ActiveInteraction::Base
    record :old, class: Dish
    record :current_user, class: User

    # Category where to add the new dish.
    record :category, class: Menu::Category, default: nil

    string :copy_images, default: "full"
    string :copy_ingredients, default: "full"
    string :copy_tags, default: "full"
    string :copy_allergens, default: "full"

    validates :copy_images, inclusion: { in: %w[full link none] }
    validates :copy_ingredients, inclusion: { in: %w[full link none] }
    validates :copy_tags, inclusion: { in: %w[full link none] }
    validates :copy_allergens, inclusion: { in: %w[full link none] }

    DONT_COPY_ATTRIBUTES = %w[id created_at updated_at].freeze

    attr_reader :new

    def execute
      ::Log::ModelChange.with_current_user(current_user) do
        @new = Dish.new

        Dish.transaction do
          raise ActiveRecord::Rollback unless do_copy_dish &&
                                              do_copy_images &&
                                              do_copy_ingredients &&
                                              do_copy_tags &&
                                              do_copy_allergens &&
                                              do_add_to_category
        end

        @new
      end
    end

    private

    def do_copy_dish
      I18n.available_locales.each do |locale|
        Mobility.with_locale(locale) do
          @new.name = old.name
          @new.description = old.description
        end
      end

      @new.assign_attributes(old.attributes.except(*DONT_COPY_ATTRIBUTES))

      return true if @new.valid? && @new.save

      errors.merge!(@new.errors)
      false
    end

    def do_copy_images
      return true unless copy_images.in?(%w[full link]) && old.images.any?

      old.images.filter { |img| img.attached_image.attached? }.each do |old_image|
        if copy_images == "full"
          @new.images << old_image.copy!(current_user:)
        elsif copy_images == "link"
          @new.images << old_image
        end
      end

      true
    rescue ActiveRecord::RecordInvalid => e
      errors.add(:base, "Cannot copy image: #{e.message}", details: e)
      false
    end

    def do_copy_ingredients
      return true unless copy_ingredients.in?(%w[full link]) && old.ingredients.any?

      old.ingredients.each do |old_ingredient|
        if copy_ingredients == "full"
          @new.ingredients << old_ingredient.copy!(current_user:)
        elsif copy_ingredients == "link"
          @new.ingredients << old_ingredient
        end
      end

      true
    rescue ActiveRecord::RecordInvalid => e
      errors.add(:base, "Cannot copy ingredient: #{e.message}", details: e)
      false
    end

    def do_copy_tags
      return true unless copy_tags.in?(%w[full link]) && old.tags.any?

      old.tags.each do |old_tag|
        if copy_tags == "full"
          @new.tags << old_tag.copy!(current_user:)
        elsif copy_tags == "link"
          @new.tags << old_tag
        end
      end

      true
    rescue ActiveRecord::RecordInvalid => e
      errors.add(:base, "Cannot copy tag: #{e.message}", details: e)
      false
    end

    def do_add_to_category
      return true if category.nil?

      category.dishes << @new
    end

    def do_copy_allergens
      return true unless copy_allergens.in?(%w[full link]) && old.allergens.any?

      old.allergens.each do |old_allergen|
        if copy_allergens == "full"
          @new.allergens << old_allergen.copy!(current_user:)
        elsif copy_allergens == "link"
          @new.allergens << old_allergen
        end
      end

      true
    rescue ActiveRecord::RecordInvalid => e
      errors.add(:base, "Cannot copy allergen: #{e.message}", details: e)
      false
    end
  end
end
