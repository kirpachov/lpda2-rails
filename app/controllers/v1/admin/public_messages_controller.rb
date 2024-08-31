# frozen_string_literal: true

module V1::Admin
  # CRUD PublicMessage
  class PublicMessagesController < ApplicationController
    # before_action :find_item, only: %i[show update destroy]

    def index
      items = PublicMessage.all.order(:key)

      items = items.where("key = ?", params[:key]) if params[:key].present?

      items = items.where("key ILIKE ?", "%#{params[:query]}%") if params[:query].present?

      items = items.paginate(pagination_params)

      render json: {
        items: full_json(items),
        metadata: json_metadata(items)
      }
    end

    def show
      @item ||= PublicMessage.find_by(key: params[:key])

      unless @item
        return render json: { message: I18n.t("record_not_found", model: PublicMessage, id: params[:key]) },
                      status: :not_found
      end

      render json: { item: full_json(@item) }
    end

    def update
      @item = PublicMessage.find_or_create_by!(key: params[:key])

      @item.assign_translation("text", params[:text])

      render_unprocessable_entity(@item) unless @item.valid? && @item.save

      show
    end

    def create
      update
    end

    private

    def full_json(item_or_items)
      return item_or_items.map { |item| full_json(item) } if item_or_items.is_a?(ActiveRecord::Relation)

      return single_item_full_json(item_or_items) if item_or_items.is_a?(::PublicMessage)

      raise ArgumentError,
            "Invalid params. PublicMessage or ActiveRecord::Relation expected, but #{item_or_items.class} given"
    end

    def single_item_full_json(item)
      item.as_json(only: %i[key]).merge(
        translations: item.translations_json,
        text: item.text
      )
    end
  end
end
