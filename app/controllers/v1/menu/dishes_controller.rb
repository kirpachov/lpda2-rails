# frozen_string_literal: true

module V1::Menu
  # Will manage /v1/menu/dishes requests
  class DishesController < ApplicationController
    before_action :find_item, only: %i[show]
    skip_before_action :authenticate_user

    def index
      call = ::Menu::SearchDishes.run(params:)
      unless call.valid?
        return render_error(status: 400, details: call.errors.as_json,
                            message: call.errors.full_messages.join(", "))
      end

      items = call.result.paginate(pagination_params)

      render json: {
        items: full_json(items),
        metadata: json_metadata(items)
      }
    end

    def show
      render json: {
        item: full_json(@item)
      }
    end

    private

    def full_json(item_or_items)
      if item_or_items.is_a?(ActiveRecord::Relation) || item_or_items.is_a?(::Menu::Dish)
        return item_or_items.public_json(
          include_all: params[:include_all].to_s.true?,
          include_allergens: params[:include_allergens].to_s.true?,
          include_ingredients: params[:include_ingredients].to_s.true?,
          include_tags: params[:include_tags].to_s.true?,
          include_suggestions: params[:include_suggestions].to_s.true?
        )
      end

      raise ArgumentError,
            "Invalid params. Menu::Dish or ActiveRecord::Relation expected, but #{item_or_items.class} given"
    end

    def find_item
      @item = Menu::Dish.visible.find_by(id: params[:id])
      return unless @item.nil?

      render_error(status: 404,
                   message: I18n.t("record_not_found", model: Menu::Dish,
                                                       id: params[:id].inspect))
    end
  end
end
