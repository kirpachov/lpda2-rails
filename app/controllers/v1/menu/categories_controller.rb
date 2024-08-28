# frozen_string_literal: true

module V1::Menu
  # Will menage /v1/menu/categories requests
  class CategoriesController < ApplicationController
    before_action :find_category, only: %i[show]
    skip_before_action :authenticate_user

    def index
      call = ::Menu::SearchCategories.run(params:)
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

    def find_category
      @item = Menu::Category.visible.find_by(id: params[:id])
      return unless @item.nil?

      render_error(status: 404,
                   message: I18n.t("record_not_found", model: Menu::Category,
                                                       id: params[:id].inspect))
    end

    def full_json(item_or_items)
      return item_or_items.map { |item| full_json(item) } if item_or_items.is_a?(ActiveRecord::Relation)

      return single_item_full_json(item_or_items) if item_or_items.is_a?(::Menu::Category)

      raise ArgumentError,
            "Invalid params. Menu::Category or ActiveRecord::Relation expected, but #{item_or_items.class} given"
    end

    def single_item_full_json(item)
      item.as_json(only: %w[id status index price parent_id created_at updated_at]).merge(
        name: item.name,
        description: item.description,
        images: item.images.map(&:full_json),
        parent: item.parent&.as_json,
        translations: item.translations_json
      )
    end
  end
end
