# frozen_string_literal: true

module V1::Admin
  class ReservationTurnsController < ApplicationController
    before_action :find_item, only: %i[show update destroy]

    def index
      call = ::SearchReservationTurns.run(params:)
      unless call.valid?
        return render_error(status: 400, details: call.errors.as_json,
                            message: call.errors.full_messages.join(', '))
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
      @item = ReservationTurn.new(create_params)

      return show if @item.valid? && @item.save

      render_unprocessable_entity(@item)
    end

    def update
      return show if @item.update(update_params)

      render_unprocessable_entity(@item)
    end

    def destroy
      nil if @item.destroy!

      #   render_unprocessable_entity(@item)
      # rescue ActiveRecord::RecordInvalid
      #   render_unprocessable_entity(@item)
    end

    private

    def create_params
      params.permit(:weekday, :starts_at, :ends_at, :name)
    end

    def update_params
      params.permit(:weekday, :starts_at, :ends_at, :name)
    end

    def find_item
      @item = ReservationTurn.where(id: params[:id]).first
      return unless @item.nil?

      render_error(status: 404,
                   message: I18n.t('record_not_found', model: ReservationTurn,
                                                       id: params[:id].inspect))
    end

    def full_json(item_or_items)
      return item_or_items.map { |item| full_json(item) } if item_or_items.is_a?(ActiveRecord::Relation)

      return single_item_full_json(item_or_items) if item_or_items.is_a?(::ReservationTurn)

      raise ArgumentError,
            "Invalid params. ReservationTurn or ActiveRecord::Relation expected, but #{item_or_items.class} given"
    end

    def single_item_full_json(item)
      item.as_json.merge(
        starts_at: item.starts_at.strftime('%k:%M'),
        ends_at: item.ends_at.strftime('%k:%M')
      )
    end
  end
end
