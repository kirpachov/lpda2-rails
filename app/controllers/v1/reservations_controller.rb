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

      if (@item.payment.paid? || @item.payment.authorized?) && @item.payment.success_url.present?
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

    # GET /v1/reservations/valid_times
    # @deprecated
    def valid_times
      call = ValidTimesGroupByTurn.run(params:)
      if call.errors.any? || call.invalid?
        return render_error(status: 400,
                            message: call.errors.full_messages.join(", "))
      end

      render json: call.result
    end

    # GET /v1/reservations/datetime_requires_payment
    # Check if for a given date/time/people count a payment is required, and if any table_types are available
    # for the reservation group.
    #
    # @param date [String] Date in YYYY-MM-DD format
    # @param time [String] Time in HH:MM format
    # @param people [Integer] Number of people
    #
    # @return [Hash] Reservation group with payment and table types information
    # Response example:
    # {
    #  "preorder_reservation_group": {
    #  "id": 1,
    #  "payment_value": 100.0,
    #  "table_types": [ { id: 1, name: "Table type 1" } ]
    #  }
    # }
    def datetime_requires_payment
      call = DateTimeRequiresPayment.run(date: params[:date], time: params[:time], people: params[:people])

      if call.errors.any? || call.invalid?
        return render_error(status: 400,
                            message: call.errors.full_messages.join(", "))
      end

      if call.result.nil?
        return render json: { preorder_reservation_group: nil }
      end

      render json: {
        preorder_reservation_group: call.result.as_json.merge(
          table_types: call.result.table_types.includes(:text_translations,
          { images: :attached_image_blob,
            table_type_to_preorder_reservation_groups: :preorder_reservation_group }).map do |table_type|
            table_type.as_json.merge(
              name: table_type.name,
              description: table_type.description,
              translations: table_type.translations_json,
              images: table_type.images.map(&:full_json),
              # table_type_to_preorder_reservation_groups: table_type.table_type_to_preorder_reservation_groups.as_json(include: [:preorder_reservation_group])
            )
          end
        )
      }
    end

    # GET
    # /v1/reservations/valid_dates?from_date=2025-03-01&to_date=2025-03-31
    def valid_dates
      dates = cache_action_response do
        ValidDatesForReservation.run!(params: params.permit!.to_h)
      end

      render json: dates
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
            only: %w[hpp_url preorder_type status value]
          }
        }
      )
    end
  end
end
