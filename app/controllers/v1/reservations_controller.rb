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

      @item = call.result.reload

      show
    end

    def resend_confirmation_email
      @item.deliver_confirmation_email_later

      render json: { success: true }
    end

    def valid_times
      return render_error(status: 400, message: "Param 'date' is required") if params[:date].blank?

      items = ReservationTurn.all.where(weekday: Date.parse(params[:date].to_s).wday).includes(:preorder_reservation_groups).map do |turn|
        turn.as_json.merge(
          valid_times: turn.valid_times(date: params[:date]),
          preorder_reservation_group: turn.preorder_reservation_groups.first&.as_json(methods: %i[message])
        )
      end

      render json: items.flatten
    rescue Date::Error => e
      render_error(status: 400, message: e)
    end

    def valid_dates
      from_date = params[:from_date].present? ? Date.parse(params[:from_date].to_s) : (Time.zone.now.to_date)
      to_date = params[:to_date].present? ? Date.parse(params[:to_date].to_s) : (Time.zone.now.to_date + 30.days)

      # If from_date is in the past, set it to today
      from_date = Time.zone.now.to_date if from_date < Time.zone.now.to_date

      if Setting.where(key: :reservation_max_days_in_advance).first.present?
        if to_date > Time.zone.now.to_date + Setting.where(key: :reservation_max_days_in_advance).first.value.to_i.days
          to_date = Time.zone.now.to_date + Setting.where(key: :reservation_max_days_in_advance).first.value.to_i.days
        end
      end

      dates = []

      while from_date <= to_date
        date = from_date
        from_date += 1.day

        items = ReservationTurn.all.where(weekday: date.wday).map do |turn|
          turn.valid_times(date: date.to_s)
        end

        dates << date.strftime("%Y-%m-%d") if items.flatten.any?
      end

      render json: dates
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
      item.as_json(
        only: %i[id fullname datetime children adults email phone notes secret],
        include: {
          payment: {
            only: %w[hpp_url status]
          }
        }
      )
    end
  end
end
