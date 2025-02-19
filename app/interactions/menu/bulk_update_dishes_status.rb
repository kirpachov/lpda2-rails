# frozen_string_literal: true

module Menu
  # Update the status of many dishes.
  # Params:
  # - dish_ids: array of integers, ids of the dishes to update
  # - status: string, new status of the dishes
  class BulkUpdateDishesStatus < ActiveInteraction::Base
    interface :params, methods: %i[to_h merge]

    validate :dishes_are_present
    validate :dishes_can_be_updated

    def execute
      Dish.transaction do
        dishes.map(&:save!)
      end

      dishes
    rescue ActiveRecord::RecordInvalid => e
      errors.add(:base, e.message)
    end

    def dishes
      @dishes ||= Dish.where(
        id: dish_ids
      ).includes(:text_translations)
    end

    def dish_ids
      @dish_ids ||= ParseIdsParams.run!(params:, variants: %i[dish_ids dish_id dish_ids dishes dish])
    end

    # ### Validations ###
    def dishes_are_present
      return if dishes.any? && dishes.count == dish_ids.count

      errors.add(:base, "some dishes are missing or invalid. Provide { dish_ids: [1, 2, 3, ...] }")
    end

    def dishes_can_be_updated
      invalid_dishes = dishes.reject do |dish|
        dish.status = params[:status]
        dish.valid?
      end

      return if invalid_dishes.empty?

      errors.add(:dish_ids, "some dishes cannot be updated: #{invalid_dishes.map{|j| "#{j.id}: #{j.errors.full_messages.join(',')}" }.join("; ")}")
    end
  end
end
