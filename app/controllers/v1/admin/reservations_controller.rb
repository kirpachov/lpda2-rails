# frozen_string_literal: true

module V1::Admin
  class ReservationsController < ApplicationController
    before_action :find_item, only: %i[show update destroy]

    def index
      call = ::SearchReservations.run(params:, current_user:)
      return render_error(status: 400, details: call.errors.as_json, message: call.errors.full_messages.join(', ')) unless call.valid?

      items = call.result.paginate(pagination_params)

      render json: {
        items: full_json(items),
        metadata: json_metadata(items)
      }
    end

    def show
      render json: { item: full_json(@item) }
    end

    def update
      return show if @item.update(update_params)

      render_error(status: 400, details: @item.errors.as_json, message: @item.errors.full_messages.join(', '))
    end

    def create
      @item = ::Reservation.new(create_params)

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

    def create_params
      params.permit(:fullname, :datetime, :people, :table, :notes, :email, :phone)
    end

    def update_params
      params.permit(:fullname, :datetime, :people, :table, :notes, :email, :phone)
    end

    def full_json(item_or_items)
      return item_or_items.map { |item| full_json(item) } if item_or_items.is_a?(ActiveRecord::Relation)

      return single_item_full_json(item_or_items) if item_or_items.is_a?(::Reservation)

      raise ArgumentError, "Invalid params. Reservation or ActiveRecord::Relation expected, but #{item_or_items.class} given"
    end

    def single_item_full_json(item)
      item.as_json
    end

    def find_item
      @item = Reservation.visible.where(id: params[:id]).first
      render_error(status: 404, message: I18n.t('record_not_found', model: Reservation, id: params[:id].inspect)) if @item.nil?
    end
  end
end
