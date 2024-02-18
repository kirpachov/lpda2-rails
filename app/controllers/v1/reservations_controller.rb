# frozen_string_literal: true

module V1
  class ReservationsController < ApplicationController
    before_action :find_item, only: %i[show cancel]
    skip_before_action :authenticate_user

    def create
      call = PublicCreateReservation.run(params: params.permit!.to_h)

      return render_error(status: 422, details: call.errors.full_json, message: call.errors.full_messages.join(', ')) unless call.valid?

      # TODO send mail

      @item = call.result
      show
    end

    def cancel
      return show if @item.cancelled!

      render_unprocessable_entity(@item)
    end

    def show
      render json: {
        item: full_json(@item)
      }
    end

    private

    def find_item
      @item = ::Reservation.visible.where(secret: params[:secret]).first
      render_error(status: 404, message: I18n.t('record_not_found', model: Reservation, id: params[:secret].inspect)) if @item.nil?
    end

    def full_json(item)
      item.as_json(only: %i[id fullname datetime people email phone notes])
    end
  end
end
