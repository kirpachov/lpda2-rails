# frozen_string_literal: true

module V1::Admin
  class ReservationTurnMessagesController < ApplicationController
    before_action :find_item, only: %i[show update destroy]

    def index
      call = ::SearchReservationTurnMessages.run(params:)
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
      render json: { item: full_json(@item) }
    end

    def create
      ReservationTurnMessage.transaction do
        @item = ReservationTurnMessage.new(from_date: params[:from_date], to_date: params[:to_date])
        @item.assign_translation("message", params[:message]) if params[:message].present?
        @item.turns = ReservationTurn.where(id: params[:turn_ids]) if @item.valid? && @item.save
      end

      return show if @item.valid? && @item.persisted?

      render_unprocessable_entity(@item)
    end

    def update
      ReservationTurnMessage.transaction do
        @item.assign_attributes(from_date: params[:from_date], to_date: params[:to_date])
        @item.assign_translation("message", params[:message]) if params[:message].present?
        @item.turns = ReservationTurn.where(id: params[:turn_ids]) if @item.valid? && @item.save
      end

      return show if @item.valid?

      render_unprocessable_entity(@item)
    end

    def destroy
      nil if @item.destroy!
    end

    private

    def find_item
      @item = ReservationTurnMessage.where(id: params[:id]).first
      return unless @item.nil?

      render_error(status: 404,
                   message: I18n.t("record_not_found", model: ReservationTurnMessage,
                                                       id: params[:id].inspect))
    end

    def full_json(item_or_items)
      return item_or_items.map { |item| full_json(item) } if item_or_items.is_a?(ActiveRecord::Relation)

      return single_item_full_json(item_or_items) if item_or_items.is_a?(::ReservationTurnMessage)

      raise ArgumentError,
            "Invalid params. ReservationTurn or ActiveRecord::Relation expected, but #{item_or_items.class} given"
    end

    def single_item_full_json(item)
      item.as_json(methods: %i[message]).merge(
        translations: item.translations_json,
        turns: item.turns.map { |t| t.as_json(only: %w[id name weekday]) }
      )
    end
  end
end
