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
      return item_or_items.includes(:text_translations, image: :attached_image_blob).map { |item| full_json(item) } if item_or_items.is_a?(ActiveRecord::Relation)

      return single_item_full_json(item_or_items) if item_or_items.is_a?(::Menu::Ingredient)

      raise ArgumentError,
            "Invalid params. Menu::Ingredient or ActiveRecord::Relation expected, but #{item_or_items.class} given"
    end

    def single_item_full_json(item)
      item.as_json(only: %w[id status created_at updated_at]).merge(
        name: item.name,
        description: item.description,
        image: item.image&.full_json,
        translations: item.translations_json
      )
    end

    def find_item
      @item = Menu::Ingredient.visible.find_by(id: params[:id])
      return unless @item.nil?

      render_error(status: 404,
                    message: I18n.t("record_not_found", model: Menu::Ingredient,
                                                        id: params[:id].inspect))
    end
  end
end
