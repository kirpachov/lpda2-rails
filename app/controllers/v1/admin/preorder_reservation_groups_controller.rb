# frozen_string_literal: true

module V1::Admin
  class PreorderReservationGroupsController < ApplicationController
    before_action :find_item, only: %i[show update destroy]
    before_action :require_root, only: %i[create update destroy]
    after_action :clear_cache, only: %i[create update destroy]

    def index
      items = PreorderReservationGroup.visible.order(id: :desc)

      items = items.active_now if params[:active_now].to_s.in?(%w[true 1])

      items = items.where("title ILIKE ?", "%#{params[:query]}%") if params[:query].present?

      items = items.paginate(pagination_params)

      render json: {
        items: full_json(items),
        metadata: json_metadata(items)
      }
    end

    def show
      render json: { item: full_json(@item) }
    end

    def create
      @call = CreatePreorderGroup.run(params: params.permit!.to_h)

      return render_unprocessable_entity(@call) if @call.invalid?

      @item = @call.result

      @item.reload

      show
    end

    def update
      @call = UpdatePreorderGroup.run(params: params.permit!.to_h.merge(id: @item.id))

      @item.reload

      return render_unprocessable_entity(@call) if @call.invalid?

      show
    end

    def destroy
      return if @item.destroy!

      render_unprocessable_entity(@item)
    end

    private

    def find_item
      @item = PreorderReservationGroup.find_by(id: params[:id])
      return unless @item.nil?

      render_error(status: 404,
                   message: I18n.t("record_not_found", model: PreorderReservationGroup,
                                                       id: params[:id].inspect))
    end

    def full_json(item_or_items)
      if item_or_items.is_a?(ActiveRecord::Relation)
        return item_or_items.includes(:text_translations, dates: [:reservation_turn], turns: [], table_type_to_preorder_reservation_groups: :table_type).map do |item|
                 full_json(item)
               end
      end

      return single_item_full_json(item_or_items) if item_or_items.is_a?(::PreorderReservationGroup)

      raise ArgumentError,
            "Invalid params. PreorderReservationGroup or ActiveRecord::Relation expected, but #{item_or_items.class} given"
    end

    def single_item_full_json(item)
      item.as_json.merge(
        turns: item.turns.map(&:formatted_json),
        dates: item.dates.includes(:reservation_turn).map do |d|
                 d.as_json.merge(reservation_turn: d.reservation_turn.formatted_json)
               end,
        message: item.message,
        translations: item.translations_json,
        table_type_to_preorder_reservation_groups: item.table_type_to_preorder_reservation_groups.as_json(include: [:table_type])
      )
    end
  end
end
