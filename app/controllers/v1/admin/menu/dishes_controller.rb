# frozen_string_literal: true

module V1
  module Admin::Menu
    class DishesController < ApplicationController
      before_action :find_item, only: %i[show update destroy]

      def index
        call = ::Menu::SearchDishes.run(params:, current_user:)
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
        @item.assign_translation('name', params[:name]) if params.key?(:name)
        @item.assign_translation('description', params[:description]) if params.key?(:description)
        @item.price = params[:price].present? ? params[:price].to_f : nil if params.key?(:price)

        return show if @item.valid? && @item.save

        render_error(status: 400, details: @item.errors.as_json, message: @item.errors.full_messages.join(', '))
      end

      def create
        @item = ::Menu::Dish.new(price: params.key?(:price) ? params[:price].to_f : nil)
        @item.assign_translation('name', params[:name]) if params.key?(:name)
        @item.assign_translation('description', params[:description]) if params.key?(:description)

        return show if @item.valid? && @item.save

        render_error(status: 400, details: @item.errors.as_json, message: @item.errors.full_messages.join(', '))
      end

      def destroy
        return if @item.deleted!

        render_unprocessable_entity(@item)
      rescue ActiveRecord::RecordInvalid
        render_unprocessable_entity(@item)
      end

      private

      def full_json(item_or_items)
        return item_or_items.map { |item| full_json(item) } if item_or_items.is_a?(ActiveRecord::Relation)

        return single_item_full_json(item_or_items) if item_or_items.is_a?(::Menu::Dish)

        raise ArgumentError, "Invalid params. Menu::Dish or ActiveRecord::Relation expected, but #{item_or_items.class} given"
      end

      def single_item_full_json(item)
        item.as_json.merge(
          name: item.name,
          description: item.description,
          images: item.images.map { |image| image.as_json.merge(url: image.url) }
        )
      end

      def find_item
        @item = Menu::Dish.visible.where(id: params[:id]).first
        render_error(status: 404, message: I18n.t('record_not_found', model: Menu::Dish, id: params[:id].inspect)) if @item.nil?
      end
    end
  end
end

