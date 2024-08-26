# frozen_string_literal: true

module V1
  class PublicDataController < ApplicationController
    skip_before_action :authenticate_user

    def index
      reservation = Reservation.visible.where(secret: cookies[Reservation::PUBLIC_CREATE_COOKIE], datetime: Time.zone.now..).first

      render json: {
        reservation: reservation.as_json,
        settings: Setting.all.where(key: Setting::PUBLIC_KEYS).pluck(:key, :value).to_h,
        public_messages: PublicMessage.visible.i18n.pluck(:key, :text).to_h,
      }
    end
  end
end
