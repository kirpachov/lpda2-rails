# frozen_string_literal: true

module Menu
  class SearchDishes < ActiveInteraction::Base
    interface :params, methods: %i[[] merge! fetch each has_key?], default: {}

    def execute
      filter_by_query(
        filter_by_description(
          filter_by_name(
            filter_by_price(
              filter_by_category(
                filter_by_status(items)
              )
            )
          )
        )
      )
    end

    private

    def items
      Dish.visible
    end

    def filter_by_category(items)
      return items unless params.key?(:category_id)

      items.where(
        id: Menu::DishesInCategory.where(
          menu_category_id: params[:category_id].present? ? params[:category_id].to_i : nil
        ).select(:menu_dish_id)
      )
    end

    def filter_by_price(items)
      return items unless params[:price].present?

      return items.where(price: params[:price].to_f) if params[:price].is_a?(String) || params[:price].is_a?(Numeric)

      lt = params[:price].key?(:less_than) ? params[:price][:less_than].to_f : nil
      gt = params[:price].key?(:more_than) ? params[:price][:more_than].to_f : nil

      return items.where("#{Dish.table_name}.price >= ? AND #{Dish.table_name}.price <= ?", gt, lt) if gt && lt

      return items.where("#{Dish.table_name}.price <= ?", lt) if lt

      return items.where("#{Dish.table_name}.price >= ?", gt) if gt

      items
    end

    def filter_by_name(items)
      return items unless params.key?(:name)

      items.where_name(params[:name].to_s)
    end

    def filter_by_description(items)
      return items unless params.key?(:description)

      items.where_description(params[:description].to_s)
    end

    def filter_by_status(items)
      return items unless params.key?(:status)

      items.where(status: params[:status])
    end

    def filter_by_query(items)
      return items unless params.key?(:query)

      items.filter_by_query(params[:query])
    end
  end
end
