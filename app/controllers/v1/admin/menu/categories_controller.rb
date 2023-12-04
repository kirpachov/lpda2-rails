# frozen_string_literal: true

module V1
  module Admin::Menu
    class CategoriesController < ApplicationController
      before_action :find_category, only: %i[show update destroy]

      def index
        call = ::Menu::SearchCategories.run(params:, current_user:)
        return render_error(status: 400, details: call.errors.as_json, message: call.errors.full_messages.join(', ')) unless call.valid?

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

      def update
        raise 'Not implemeted.'
      end

      def destroy
        raise 'not implemented.'
      end

      private

      def find_category
        @item = Menu::Category.visible.where(id: params[:id]).first
        return render_error(status: 404, message: I18n.t('record_not_found', model: Menu::Category, id: params[:id].inspect)) if @item.nil?
      end

      def full_json(item_or_items)
        return item_or_items.map { |item| full_json(item) } if item_or_items.is_a?(ActiveRecord::Relation)

        return single_item_full_json(item_or_items) if item_or_items.is_a?(::Menu::Category)

        raise ArgumentError, "Invalid params. Menu::Category or ActiveRecord::Relation expected, but #{item_or_items.class} given"
      end

      def single_item_full_json(item)
        item.as_json.merge(
          name: item.name,
          description: item.description,
          visibility: item.visibility.as_json,
          images: item.images.map(&:full_json)
        )
        # item.as_json.merge(
        #   image_url: item.image_url,
        #   provider: item.provider.as_json,
        #   stats: item.stats.as_json,
        #   values: item.values,
        #   value_type: item.value_type,
        #   image: item.image&.as_json
        # )
      end
    end
  end
end
