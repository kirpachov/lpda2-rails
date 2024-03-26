# frozen_string_literal: true

module V1
  module Admin::Menu
    class CategoriesController < ApplicationController
      before_action :find_category, only: %i[
        show update destroy visibility add_dish remove_dish add_category dashboard_data copy
        move
      ]

      before_action :check_if_can_publish, only: %i[visibility]

      def index
        call = ::Menu::SearchCategories.run(params:)
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

      def dashboard_data
        breadcrumb = [@item]
        parent = @item.parent
        while parent
          breadcrumb << parent
          parent = parent.parent
        end
        breadcrumb.reverse!
        render json: {
          breadcrumbs: breadcrumb.map { |item| item.as_json(only: %i[id]).merge(name: item.name) }
        }
      end

      def create
        @item = Menu::Category.new(create_params)
        @item.assign_translation('name', params[:name]) if params[:name].present?
        @item.assign_translation('description', params[:description]) if params[:description].present?

        return show if @item.errors.empty? && @item.valid? && @item.save

        render_unprocessable_entity(@item)
      end

      def update
        @item.assign_translation('name', params[:name]) if params.key?(:name)
        @item.assign_translation('description', params[:description]) if params.key?(:description)

        @item.assign_attributes(update_params)

        return show if @item.errors.empty? && @item.valid? && @item.save

        render_unprocessable_entity(@item)
      end

      def destroy
        return if @item.deleted!

        render_unprocessable_entity(@item)
      rescue ActiveRecord::RecordInvalid
        render_unprocessable_entity(@item)
      end

      def visibility
        # TODO: when is not root, should update parent's visibility?
        @item.visibility.assign_attributes(visibility_params)

        # Checking if can publish.
        # If not publishing, don't care if can publish.
        # If publishing, check if can publish.
        if @item.visibility.valid? && @item.visibility.save

          return show
        end

        render_unprocessable_entity(@item)
      end

      def add_dish
        Menu::Category.transaction do
          dish = Menu::Dish.visible.find(params[:dish_id])
          dish = dish.copy!(current_user:) if params[:copy].to_s == 'true'
          @item.dishes << dish
        end

        show
      rescue ActiveRecord::RecordInvalid => e
        render_error(status: 422, message: e.message)
      rescue ActiveRecord::RecordNotFound
        render_error(status: 404, message: I18n.t('record_not_found', model: Menu::Dish, id: params[:dish_id].inspect))
      end

      def move
        unless params.key?(:to_index) && params[:to_index].present?
          return render_error(status: 400, message: 'to_index is required')
        end

        unless @item.move(params[:to_index].to_i) && @item.valid? && @item.errors.empty?
          return render_unprocessable_entity(@item)
        end

        show
      end

      def copy
        copy_params = {
          old: @item,
          current_user:,
          copy_images: params[:copy_images],
          copy_dishes: params[:copy_dishes],
          copy_children: params[:copy_children],
        }

        copy_params.merge!(parent_id: params[:parent_id]) if params.key?(:parent_id)

        call = ::Menu::CopyCategory.run(params: copy_params)

        if call.valid?
          @item = call.result
          return show
        end

        render_error(status: 422, message: call.errors.full_messages.join(', '), details: call.errors.full_json)
      end

      def remove_dish
        @item.dishes.delete(Menu::Dish.find(params[:dish_id]))
        show
      rescue ActiveRecord::RecordNotFound
        render_error(status: 404, message: I18n.t('record_not_found', model: Menu::Dish, id: params[:dish_id].inspect))
      end

      def add_category
        Menu::Category.transaction do
          category = Menu::Category.visible.find(params[:category_child_id])
          category = category.copy!(current_user:)
          category.update!(visibility: nil, parent: @item)
        end

        show
      rescue ActiveRecord::RecordInvalid => e
        render_error(status: 422, message: e.message)
      rescue ActiveRecord::RecordNotFound
        render_error(status: 404, message: I18n.t('record_not_found', model: Menu::Category, id: params[:category_child_id].inspect))
      end

      private

      def check_if_can_publish
        return if force?

        publishing_now = [true, 1, 'true', '1', :true].include?(params[:public_visible])
        return unless publishing_now

        call = Menu::CanPublishCategory.run(category: @item)
        return if call.result

        render_error(
          status: :unprocessable_entity,
          message: "Cannot publish this category: #{call.reasons.full_messages.join(', ')}",
          details: call.reasons.full_json.merge(error_code: :cannot_publish)
        )
      end

      def force?
        [true, 1, 'true', '1', :true].include? params[:force]
      end

      def visibility_params
        params.permit(:public_visible, :public_from, :public_to, :private_visible, :private_from, :private_to, :daily_from, :daily_to)
      end

      def create_params
        params.permit(:parent_id)
      end

      def update_params
        update_params = params.permit(:parent_id, :secret_desc)
        update_params.merge!(visibility_id: nil) if update_params[:parent_id].is_a?(Integer) || update_params[:parent_id].is_a?(String)
        # update_params.merge!(index: nil) if update_params.key?(:parent_id) && update_params[:parent_id].blank?
        update_params
      end

      def find_category
        @item = Menu::Category.visible.where(id: params[:id]).first
        render_error(status: 404, message: I18n.t('record_not_found', model: Menu::Category, id: params[:id].inspect)) if @item.nil?
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
          images: item.images.map(&:full_json),
          # parent: item.parent ? full_json(item.parent) : nil
          parent: item.parent&.as_json,
          translations: item.translations_json
        )
      end
    end
  end
end
