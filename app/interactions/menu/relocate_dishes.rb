# frozen_string_literal: true

module Menu
  # Move many dishes from one category to another.
  # Will remove dishes from from_category and add them to to_category.
  # Params:
  # - from_category_id: integer, id of the category to remove dishes from
  # - to_category_id: integer, id of the category to add dishes to
  # - dish_ids: array of integers, ids of the dishes to move
  class RelocateDishes < ActiveInteraction::Base
    interface :params, methods: %i[to_h merge]

    validate :all_dishes_present_in_from_category
    validate :dishes_are_present
    validate :from_category
    validate :to_category

    def execute
      Dish.transaction do
        dishes.each do |dish|
          dish.categories.delete(from_category) if from_category.present?
          dish.categories << to_category if to_category.present? && !to_category.dishes.exists?(dish.id)
        end
      end

      dishes
    rescue ActiveRecord::RecordInvalid => e
      errors.add(:base, e.message)
    end

    def from_category
      return @from_category if defined?(@from_category)

      @from_category = nil
      if params.key?(:from_category_id)
        @from_category = Category.find_by(id: params[:from_category_id])
        errors.add(:from_category_id, "category not found") if @from_category.nil?
      end

      @from_category
    end

    def to_category
      return @to_category if defined?(@to_category)

      @to_category = nil
      if params.key?(:to_category_id)
        @to_category = Category.find_by(id: params[:to_category_id])
        errors.add(:to_category_id, "category not found") if @to_category.nil?
      end

      @to_category
    end

    def dishes
      @dishes ||= Dish.where(id: dish_ids)
    end

    def dish_ids
      @dish_ids ||= ParseIdsParams.run!(params:, variants: %i[dish_ids dish_id dish_ids dishes dish])
    end

    # ###########
    # Validations
    # ###########
    def all_dishes_present_in_from_category
      return if dishes.empty?
      return if from_category.blank?

      not_in_from_category = dishes.reject { |d| from_category.dishes.exists?(d.id) }
      return if not_in_from_category.empty?

      errors.add(:base, "not all dishes are present in from category: #{not_in_from_category.map(&:id).join(", ")}")
    end

    def dishes_are_present
      return if dishes.any? && dishes.count == dish_ids.count

      errors.add(:base, "some dishes are missing or invalid. Provide { dish_ids: [1, 2, 3, ...] }")
    end
  end
end
