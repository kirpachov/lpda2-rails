# frozen_string_literal: true

module Menu
  class SearchTags < ActiveInteraction::Base
    interface :params, methods: %i[[] merge! fetch each has_key?], default: {}

    def execute
      filter_by_query(
        filter_by_description(
          filter_by_name(
            filter_by_status(
              filter_by_avoid_associated_dish_id(
                filter_by_associated_dish_id(
                  order_by_index_in_associated_dish_id(
                    items
                  )
                )
              )
            )
          )
        )
      )
    end

    private

    def filter_by_associated_dish_id(items)
      return items if params[:associated_dish_id].blank?

      items.where(id: Menu::TagsInDish.where(menu_dish_id: params[:associated_dish_id]).select(:tag_id))
    end

    def order_by_index_in_associated_dish_id(items)
      return items if params[:associated_dish_id].blank?

      items.joins(:menu_tags_in_dishes).where(menu_tags_in_dishes: { menu_dish_id: params[:associated_dish_id] }).order("menu_tags_in_dishes.index")
    end

    def filter_by_avoid_associated_dish_id(items)
      return items if params[:avoid_associated_dish_id].blank?

      items.where.not(id: Menu::TagsInDish.where(menu_dish_id: params[:avoid_associated_dish_id]).select(:tag_id))
    end

    def items
      Tag.visible
    end

    def filter_by_name(items)
      return items unless params.has_key?(:name)

      items.where_name(params[:name].to_s)
    end

    def filter_by_description(items)
      return items unless params.has_key?(:description)

      items.where_description(params[:description].to_s)
    end

    def filter_by_status(items)
      return items unless params.has_key?(:status)

      items.where(status: params[:status])
    end

    def filter_by_query(items)
      return items unless params.has_key?(:query)

      items.filter_by_query(params[:query])
    end
  end
end
