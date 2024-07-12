# frozen_string_literal: true

module Menu
  class CanPublishCategory < ActiveInteraction::Base
    record :category, class: ::Menu::Category
    array :available_locales, default: nil

    attr_reader :reasons

    def execute
      @reasons = ActiveModel::Errors.new(Category)

      check_category_name
      category_not_root! if category.parent.present?
      category_invalid! unless category.valid?
      missing_dishes! if category.dishes.visible.empty?
      missing_price! if missing_price?
      category_missing_images! if category.images.visible.empty?

      category.dishes.visible.each do |dish|
        check_dish_name(dish)
        dish_invalid!(dish) unless dish.valid?
        dish_without_images!(dish) if dish.images.visible.empty?
        dish_without_ingredients!(dish) if dish.ingredients.visible.empty?
      end

      @reasons.empty?
    end

    private

    def locales
      @locales ||= (available_locales || Setting[:available_locales]).split(",")
    end

    def check_category_name
      locales.each do |locale|
        name = Mobility.with_locale(locale) { category.name }

        reason(:missing_name, "Category has no name for locale #{locale.inspect}", locale:) if name.to_s.blank?
      end
    end

    def check_dish_name(dish)
      locales.each do |locale|
        name = Mobility.with_locale(locale) { dish.name }

        if name.to_s.blank?
          reason(:dish_missing_name, "Dish has no name for locale #{locale.inspect}", locale:,
                                                                                      dish_id: dish.id)
        end
      end
    end

    def category_missing_images!
      reason(:category_has_no_images, "Category '#{category.name}' has no images", { category_id: category.id })
    end

    def category_not_root!
      reason(:category_not_root,
             "Category '#{category.name}' is not a root category: has a parent category '#{category.parent.name}'", { parent_category_id: category.parent.id })
    end

    def missing_price!
      reason(:missing_price, "Category '#{category.name}' has no price. Price is missing in some of the dishes too. Either place a price on all of the dishes, or place a price for the category.", {
               category_id: category.id,
               dishes_without_price: category.dishes.visible.where(price: nil).pluck(:id)
             })
    end

    def missing_price?
      return false if category.dishes.count.zero?
      return false if category.price.present? && category.price.to_i > 0
      return false if category.dishes.visible.where(price: nil).empty? && category.dishes.visible.map(&:price).all? do |price|
                        price.to_i >= 0
                      end && category.dishes.count.positive?

      true
    end

    def category_invalid!
      reason(:category_invalid, "Category is invalid: #{category.errors.full_messages.join(", ")}")
    end

    def missing_dishes!
      reason(:missing_dishes, "Category has no dishes")
    end

    def dish_without_ingredients!(dish)
      reason(:dish_missing_ingredients, "Dish '#{dish.name}' has no ingredients", { dish_id: dish.id })
    end

    def dish_without_images!(dish)
      reason(:dish_has_no_images, "Dish '#{dish.name}' has no image(s)", { dish_id: dish.id })
    end

    def dish_invalid!(dish)
      reason(:dish_invalid, "Dish '#{dish.name}' is invalid: #{dish.errors.full_messages.join(", ")}",
             { dish_id: dish.id })
    end

    def reason(code, message, details = {})
      details[:code] = code
      @reasons.add(:base, message, **details)
    end
  end
end
