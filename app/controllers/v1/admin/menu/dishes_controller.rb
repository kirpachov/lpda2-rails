# frozen_string_literal: true

module V1
  module Admin::Menu
    class DishesController < ApplicationController
      before_action :find_item, only: %i[
        show update destroy copy
        add_ingredient remove_ingredient add_tag remove_tag add_allergen remove_allergen
        add_image remove_image
        update_status
        remove_from_category
      ]

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

      def create
        @item = ::Menu::Dish.new(price: params.key?(:price) ? params[:price].to_f : nil)
        @item.assign_translation("name", params[:name]) if params.key?(:name)
        @item.assign_translation("description", params[:description]) if params.key?(:description)

        if @item.valid? && @item.save
          if params.key? :category_id
            ::Menu::DishesInCategory.create!(menu_dish: @item,
                                             menu_category_id: params[:category_id].present? ? params[:category_id].to_i : nil)
          end

          return show
        end

        render_error(status: 400, details: @item.errors.as_json, message: @item.errors.full_messages.join(", "))
      end

      def update
        @item.assign_translation("name", params[:name]) if params.key?(:name)
        @item.assign_translation("description", params[:description]) if params.key?(:description)
        @item.price = params[:price].present? ? params[:price].to_f : nil if params.key?(:price)

        return show if @item.valid? && @item.save

        render_error(status: 400, details: @item.errors.as_json, message: @item.errors.full_messages.join(", "))
      end

      def update_status
        return show if @item.update(status: params[:status].to_s)

        render_error(status: 400, details: @item.errors.as_json, message: @item.errors.full_messages.join(", "))
      end

      def destroy
        return if @item.deleted!

        render_unprocessable_entity(@item)
      rescue ActiveRecord::RecordInvalid
        render_unprocessable_entity(@item)
      end

      def remove_from_category
        Menu::DishesInCategory.where(menu_dish_id: @item.id,
                                     menu_category_id: params[:category_id].blank? ? nil : params[:category_id].to_i).destroy_all
        show
      end

      def copy
        call = ::Menu::CopyDish.run(
          old: @item,
          current_user:,
          copy_images: params[:copy_images],
          copy_allergens: params[:copy_allergens],
          copy_ingredients: params[:copy_ingredients],
          copy_tags: params[:copy_tags]
        )

        if call.valid?
          @item = call.result
          return show
        end

        render_error(status: 422, message: call.errors.full_messages.join(", "), details: call.errors.full_json)
      end

      def add_ingredient
        Menu::Dish.transaction do
          ingredient = Menu::Ingredient.visible.find(params[:ingredient_id])
          ingredient = ingredient.copy!(current_user:) if params[:copy].to_s == "true"
          @item.ingredients << ingredient
        end

        show
      rescue ActiveRecord::RecordInvalid => e
        render_error(status: 422, message: e.message)
      rescue ActiveRecord::RecordNotFound
        render_error(status: 404,
                     message: I18n.t("record_not_found", model: Menu::Ingredient,
                                                         id: params[:ingredient_id].inspect))
      end

      def remove_ingredient
        @item.ingredients.delete(Menu::Ingredient.find(params[:ingredient_id]))
        show
      rescue ActiveRecord::RecordNotFound
        render_error(status: 404,
                     message: I18n.t("record_not_found", model: Menu::Ingredient,
                                                         id: params[:ingredient_id].inspect))
      end

      def add_tag
        Menu::Dish.transaction do
          tag = Menu::Tag.visible.find(params[:tag_id])
          tag = tag.copy!(current_user:) if params[:copy].to_s == "true"
          @item.tags << tag
        end

        show
      rescue ActiveRecord::RecordInvalid => e
        render_error(status: 422, message: e.message)
      rescue ActiveRecord::RecordNotFound
        render_error(status: 404, message: I18n.t("record_not_found", model: Menu::Tag, id: params[:tag_id].inspect))
      end

      def remove_tag
        @item.tags.delete(Menu::Tag.find(params[:tag_id]))
        show
      rescue ActiveRecord::RecordNotFound => e
        render_error(status: 404, message: I18n.t("record_not_found", model: Menu::Tag, id: params[:tag_id].inspect))
      end

      def add_allergen
        Menu::Dish.transaction do
          allergen = Menu::Allergen.visible.find(params[:allergen_id])
          allergen = allergen.copy!(current_user:) if params[:copy].to_s == "true"
          @item.allergens << allergen
        end

        show
      rescue ActiveRecord::RecordInvalid => e
        render_error(status: 422, message: e.message)
      rescue ActiveRecord::RecordNotFound
        render_error(status: 404,
                     message: I18n.t("record_not_found", model: Menu::Allergen,
                                                         id: params[:allergen_id].inspect))
      end

      def remove_allergen
        @item.allergens.delete(Menu::Allergen.find(params[:allergen_id]))
        show
      rescue ActiveRecord::RecordNotFound => e
        render_error(status: 404,
                     message: I18n.t("record_not_found", model: Menu::Allergen,
                                                         id: params[:allergen_id].inspect))
      end

      def add_image
        Menu::Dish.transaction do
          image = Image.visible.find(params[:image_id])
          image = image.copy!(current_user:) if params[:copy].to_s == "true"
          @item.images << image
        end

        show
      rescue ActiveRecord::RecordInvalid => e
        render_error(status: 422, message: e.message)
      rescue ActiveRecord::RecordNotFound
        render_error(status: 404, message: I18n.t("record_not_found", model: Image, id: params[:image_id].inspect))
      end

      def remove_image
        @item.images.delete(Image.find(params[:image_id]))
        show
      rescue ActiveRecord::RecordNotFound => e
        render_error(status: 404, message: I18n.t("record_not_found", model: Image, id: params[:image_id].inspect))
      end

      private

      def full_json(item_or_items)
        return item_or_items.map { |item| full_json(item) } if item_or_items.is_a?(ActiveRecord::Relation)

        return single_item_full_json(item_or_items) if item_or_items.is_a?(::Menu::Dish)

        raise ArgumentError,
              "Invalid params. Menu::Dish or ActiveRecord::Relation expected, but #{item_or_items.class} given"
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
        return unless @item.nil?

        render_error(status: 404,
                     message: I18n.t("record_not_found", model: Menu::Dish,
                                                         id: params[:id].inspect))
      end
    end
  end
end
