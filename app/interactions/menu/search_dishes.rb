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
                filter_by_status(
                  order(items)
                )
              )
            )
          )
        )
      )
    end

    private

    def order(items)
      return order_by_index_in_category(items) if params.key?(:category_id)

      items
    end

    def order_by_index_in_category(items)
      items.joins(:menu_dishes_in_categories).where(
        menu_dishes_in_categories: {
          category_id: params[:category_id].present? ? params[:category_id].to_i : nil
        }
      ).order("#{Menu::DishesInCategory.table_name}.index ASC")
    end

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
      # WARNING:
      # if filtering by price_not: 15 and we have [nil, 15, 30] as prices,
      # would expect to get [nil, 30] as result, but we get [30] instead.
      # TODO: check why and fix this. (issue #7)
      items = items.where.not(price: params[:price_not].present? ? params[:price_not].to_f : nil) if params.key?(:price_not)

      items = items.where(price: params[:price].present? ? params[:price].to_f : nil) if params.key?(:price) && (params[:price].is_a?(String) || params[:price].is_a?(Numeric))

      lt = nil
      lt = params[:price][:less_than].to_f if params[:price].present? && params[:price].respond_to?(:key?) && params[:price].key?(:less_than)
      lt = params[:price_less_than].to_f if params[:price_less_than].present? && lt.blank?

      gt = nil
      gt = params[:price][:more_than].to_f if params[:price].present? && params[:price].respond_to?(:key?) && params[:price].key?(:more_than)
      gt = params[:price_more_than].to_f if params[:price_more_than].present? && gt.blank?

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
