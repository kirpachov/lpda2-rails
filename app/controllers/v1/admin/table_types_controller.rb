# frozen_string_literal: true

module V1::Admin
  # Manage /v1/admin/table_types requests
  class TableTypesController < ApplicationController
    before_action :find_item, only: %i[show update destroy update_status remove_from_preorder_reservation_groups]
    before_action :require_root, except: %i[index]
    after_action :clear_cache, except: %i[index]

    # GET /v1/admin/table_types
    def index
      call = ::SearchTableTypes.run(params:)
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

    # GET /v1/admin/table_types/<id>
    def show
      render json: { item: full_json(@item) }
    end

    # POST /v1/admin/table_types
    def create
      @item = TableType.new(create_params)
      @item.assign_translation("name", params[:name]) if params[:name].present?
      @item.assign_translation("description", params[:description]) if params[:description].present?

      return show if @item.errors.empty? && @item.valid? && @item.save

      render_unprocessable_entity(@item)
    end

    # PATCH /v1/admin/table_types/<id>/
    def update
      @item.assign_attributes(update_params)
      @item.assign_translation("name", params[:name]) if params.key?(:name)
      @item.assign_translation("description", params[:description]) if params.key?(:description)

      return show if @item.errors.empty? && @item.valid? && @item.save

      render_unprocessable_entity(@item)
    end

    # DELETE /v1/admin/table_types/<id>
    def destroy
      return if @item.destroy

      render_unprocessable_entity(@item)
    end

    # DESTROY /v1/admin/table_types/<id>/preorder_reservation_groups
    def remove_from_preorder_reservation_groups
      TableTypeToPreorderReservationGroup.where(
        table_type: @item
      ).destroy_all
    end

    # PATCH /v1/admin/table_types/<id>/update_status
    def update_status
      return show if @item.update(status: params[:status])

      render_unprocessable_entity(@item)
    end

    private

    def create_params
      params.permit(:default_price, :default_people_per_turn, :notes)
    end

    def update_params
      params.permit(:default_price, :default_people_per_turn, :notes)
    end

    def find_item
      @item = TableType.find(params[:id])
    end

    def full_json(item_or_items)
      if item_or_items.is_a?(ActiveRecord::Relation)
        return item_or_items.includes(:text_translations).map do |item|
                 full_json(item)
               end
      end

      return single_item_full_json(item_or_items) if item_or_items.is_a?(TableType)

      raise ArgumentError,
            "Invalid params. TableType or ActiveRecord::Relation expected, but #{item_or_items.class} given"
    end

    def single_item_full_json(item)
      item.as_json.merge(
        name: item.name,
        description: item.description,
        translations: item.translations_json,

        # TODO include preorder_reservation_groups
      )
    end
  end
end
