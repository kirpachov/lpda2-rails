# frozen_string_literal: true

module V1
  class PublicDataController < ApplicationController
    skip_before_action :authenticate_user

    def index
      reservation = Reservation.visible.where(secret: cookies[Reservation::PUBLIC_CREATE_COOKIE], datetime: Time.zone.now..).first

      render json: {
        reservation: reservation.as_json
      }
    end
  end
end
