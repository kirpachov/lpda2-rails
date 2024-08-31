# frozen_string_literal: true

module V1
  class ReservationsController < ApplicationController
    before_action :find_item, only: %i[show cancel]
    before_action :find_next_and_active_reservation, only: %i[resend_confirmation_email]
    skip_before_action :authenticate_user

    def show
      render json: {
        item: full_json(@item)
      }
    end

    def create
      call = PublicCreateReservation.run(params: params.permit!.to_h)

      unless call.valid?
        return render_error(status: 422, details: call.errors.full_json,
                            message: call.errors.full_messages.join(", "))
      end

      call.result.deliver_confirmation_email_later

      cookies[Reservation::PUBLIC_CREATE_COOKIE] = {
        value: call.result.secret,
        expires: 90.days.from_now,
        http_only: true
      }

      @item = call.result
      show
    end

    def resend_confirmation_email
      @item.deliver_confirmation_email_later

      render json: { success: true }
    end

    def valid_times
      return render_error(status: 400, message: "Param 'date' is required") if params[:date].blank?

      items = ReservationTurn.all.where(weekday: Date.parse(params[:date].to_s).wday).map do |turn|
        turn.as_json.merge(valid_times: turn.valid_times)
      end

      render json: items.flatten
    rescue Date::Error => e
      render_error(status: 400, message: e)
    end

    def cancel
      return show if @item.cancelled!

      render_unprocessable_entity(@item)
    end

    private

    def find_item
      @item = ::Reservation.visible.where(secret: params[:secret]).first
      return unless @item.nil?

      render_error(status: 404,
                   message: I18n.t("record_not_found", model: Reservation,
                                                       id: params[:secret].inspect))
    end

    def find_next_and_active_reservation
      @item = ::Reservation.visible.where(secret: params[:secret]).active.next.first
      return unless @item.nil?

      render_error(status: 404,
                   message: I18n.t("record_not_found", model: Reservation,
                                                       id: params[:secret].inspect))
    end

    def full_json(item)
      item.as_json(only: %i[id fullname datetime children adults email phone notes secret])
    end
  end
end
