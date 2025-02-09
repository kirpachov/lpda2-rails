# frozen_string_literal: true

module Menu
  # Will alow user to update many dishes prices at once.
  # Params:
  # - filters: key-value object with filters to search dishes. If not present, all dishes will be updated. Format of the object is the same as in GET /v1/admin/menu/dishes
  # - percent: float, percentage to increase/decrease the price. If positive, the price will be increased, if negative, decreased.
  # - amount: float, amount to increase/decrease the price. If positive, the price will be increased, if negative, decreased.
  # either percent OR amount must be present
  class UpdateDishesPrices < ActiveInteraction::Base
    interface :params, methods: %i[to_h merge]

    validate do
      errors.add(:base, "neither :percent nor :amount are present") if percent.zero? && amount.zero?
      errors.add(:base, "percent and amount cannot be both present") if percent.positive? && amount.positive?
      errors.add(:base, "percent must be between -100 and 100") unless percent.between?(-100, 100)
      if params[:percent].present? && !params[:percent].to_s.match?(/\A-?\d+\z/)
        errors.add(:base,
                   "percent must be an integer")
      end
    end

    def execute
      Dish.transaction do
        items.each do |item|
          next if item.update(price: (pr = new_price(item.price).round(2)) >= 0 ? pr : 0)

          if item.errors.any?
            errors.add(:base,
                       "error updating dish #{item.id}: #{item.errors.full_messages.join(", ")}")
          end
        end

        raise ActiveRecord::Rollback if errors.any? || params[:dry_run].to_s == "true"
      end

      items.map { |j| { id: j.id, price: j.price } }
    end

    private

    def items
      @items ||= SearchDishes.run!(params: params[:filters] || {})
    end

    def new_price(price)
      price = price.to_f
      return price + amount unless amount.zero?
      return price * (1 + (percent / 100)) unless percent.zero?

      raise "neither :percent nor :amount are present"
    end

    def percent
      params[:percent].to_f
    end

    def amount
      params[:amount].to_f
    end
  end
end
