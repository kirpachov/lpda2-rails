# frozen_string_literal: true

module V1::Admin::Menu
  class TagsController < ApplicationController
    before_action :find_item, only: %i[show update destroy copy]

    def index
      call = ::Menu::SearchTags.run(params:, current_user:)
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

    def create
      @item = Menu::Tag.new
      @item.assign_translation('name', params[:name]) if params[:name].present?
      @item.assign_translation('description', params[:description]) if params[:description].present?

      return show if @item.errors.empty? && @item.valid? && @item.save

      render_unprocessable_entity(@item)
    end

    def update
      @item.assign_translation('name', params[:name]) if params.key?(:name)
      @item.assign_translation('description', params[:description]) if params.key?(:description)

      return show if @item.errors.empty? && @item.valid? && @item.save

      render_unprocessable_entity(@item)
    end

    def destroy
      return if @item.deleted!

      render_unprocessable_entity(@item)
    rescue ActiveRecord::RecordInvalid
      render_unprocessable_entity(@item)
    end

    def copy
        call = ::Menu::CopyTag.run(
          old: @item,
          current_user:,
          copy_image: params[:copy_image],
        )

        if call.valid?
          @item = call.result
          return show
        end

        render_error(status: 422, message: call.errors.full_messages.join(', '), details: call.errors.full_json)
      end

    private

    def find_item
      @item = Menu::Tag.visible.where(id: params[:id]).first
      render_error(status: 404, message: I18n.t('record_not_found', model: Menu::Tag, id: params[:id].inspect)) if @item.nil?
    end

    def full_json(item_or_items)
      return item_or_items.map { |item| full_json(item) } if item_or_items.is_a?(ActiveRecord::Relation)

      return single_item_full_json(item_or_items) if item_or_items.is_a?(::Menu::Tag)

      raise ArgumentError, "Invalid params. Menu::Tag or ActiveRecord::Relation expected, but #{item_or_items.class} given"
    end

    def single_item_full_json(item)
      item.as_json.merge(
        name: item.name,
        description: item.description,
        image: item.image&.full_json
      )
    end
  end
end
