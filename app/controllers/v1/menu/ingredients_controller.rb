# frozen_string_literal: true

module V1::Menu
  # Will manage /v1/menu/ingredients requests
  class IngredientsController < ApplicationController
    before_action :find_item, only: %i[show]
    skip_before_action :authenticate_user

    def index
      call = ::Menu::SearchIngredients.run(params:)
      unless call.valid?
        return render_error(status: 400, details: call.errors.as_json,
                            message: call.errors.full_messages.join(", "))
      end

      items = call.result.paginate(pagination_params)

      render json: {
        items: items.public_json,
        metadata: json_metadata(items)
      }
    end

    def show
      render json: {
        item: @item.public_json
      }
    end

    private

    def find_item
      @item = Menu::Ingredient.visible.find_by(id: params[:id])
      return unless @item.nil?

      render_error(status: 404,
                   message: I18n.t("record_not_found", model: Menu::Ingredient,
                                                       id: params[:id].inspect))
    end
  end
end
