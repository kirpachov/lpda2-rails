# frozen_string_literal: true

module V1::Menu
  # Will menage /v1/menu/categories requests
  class CategoriesController < ApplicationController
    before_action :find_category, only: %i[show]
    skip_before_action :authenticate_user

    def index
      data = cache_action_response do
        call = ::Menu::SearchCategories.run!(params:, public: true)

        items = call.paginate(pagination_params)

        {
          items: full_json(items),
          metadata: json_metadata(items)
        }
      end

      render json: data
    rescue ActiveInteraction::InvalidInteractionError => e
      render_error(status: 400, details: e)
    end

    def show
      data = cache_action_response do
        {
          item: full_json(@item)
        }
      end

      render json: data
    end

    private

    def find_category
      @item = Menu::Category.visible.public_visible.find_by(id: params[:id]) || Menu::Category.visible.private_visible.find_by(secret: params[:id])
      return unless @item.nil?

      render_error(status: 404,
                   message: I18n.t("record_not_found", model: Menu::Category,
                                                       id: params[:id].inspect))
    end

    def full_json(item_or_items)
      if item_or_items.is_a?(ActiveRecord::Relation)
        return item_or_items.includes(:text_translations, :images, :parent).map do |item|
                 full_json(item)
               end
      end

      return single_item_full_json(item_or_items) if item_or_items.is_a?(::Menu::Category)

      raise ArgumentError,
            "Invalid params. Menu::Category or ActiveRecord::Relation expected, but #{item_or_items.class} given"
    end

    def single_item_full_json(item)
      item.as_json(only: %w[id status index price secret parent_id created_at updated_at]).merge(
        name: item.name,
        description: item.description,
        images: item.images.map(&:full_json),
        parent: item.parent&.as_json,
        translations: item.translations_json
      )
    end
  end
end
