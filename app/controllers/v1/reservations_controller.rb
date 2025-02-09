# frozen_string_literal: true

module V1
  class ReservationsController < ApplicationController
    before_action :find_item, only: %i[show cancel]
    before_action :find_next_and_active_reservation, only: %i[do_payment resend_confirmation_email]
    skip_before_action :authenticate_user

    def show
      # TODO: if reservation has a payment, should check for payment status from the payment provider
      render json: {
        item: full_json(@item)
      }
    end

    # GET /v1/reservations/:secret/do_payment
    def do_payment
      return item_not_found if @item.payment.blank?

      if @item.payment.paid? && @item.payment.success_url.present?
        Log::ReservationEvent.create!(reservation: @item, event_type: "redirect_payment_success")
        return redirect_to @item.payment.success_url, allow_other_host: true
      end

      if @item.payment.html.present?
        Log::ReservationEvent.create!(reservation: @item, event_type: "do_payment")
        return render plain: @item.payment.clean_html, content_type: "text/html"
      end

      raise "Don't know how to render payment for reservation"
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
      call = ValidTimesGroupByTurn.run(params:)
      if call.errors.any? || call.invalid?
        return render_error(status: 400,
                            message: call.errors.full_messages.join(", "))
      end

      render json: call.result
    end

    def valid_dates
      from_date = params[:from_date].present? ? Date.parse(params[:from_date].to_s) : Time.zone.now.to_date
      to_date = params[:to_date].present? ? Date.parse(params[:to_date].to_s) : (Time.zone.now.to_date + 30.days)

      # If from_date is in the past, set it to today
      from_date = Time.zone.now.to_date if from_date < Time.zone.now.to_date

      if Setting.where(key: :reservation_max_days_in_advance).first.present? && (to_date > Time.zone.now.to_date + Setting.where(key: :reservation_max_days_in_advance).first.value.to_i.days)
        to_date = Time.zone.now.to_date + Setting.where(key: :reservation_max_days_in_advance).first.value.to_i.days
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
      call = PublicCancelReservation.run(reservation: @item)

      return render_unprocessable_entity(call) unless call.errors.empty? && call.valid?

      @item.reload

      show
    end

    private

    def item_not_found
      render_error(status: 404,
                   message: I18n.t("record_not_found", model: Reservation,
                                                       id: params[:secret].inspect))
    end

    def find_item
      @item = ::Reservation.visible.public_visible.where(secret: params[:secret]).first
      return unless @item.nil?

      item_not_found
    end

    def find_next_and_active_reservation
      @item = ::Reservation.visible.where(secret: params[:secret]).active.next.first
      return unless @item.nil?

      item_not_found
    end

    def full_json(item)
      item.as_json(
        only: %i[id fullname datetime children adults email phone notes secret created_at updated_at],
        include: {
          payment: {
            only: %w[hpp_url status value]
          }
        }
      )
    end
  end
end
