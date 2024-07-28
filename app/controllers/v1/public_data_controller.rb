# frozen_string_literal: true

module V1
  class PublicDataController < ApplicationController
    skip_before_action :authenticate_user

    def index
      reservation = Reservation.visible.where(secret: cookies[Reservation::PUBLIC_CREATE_COOKIE], datetime: Time.zone.now..).first

      render json: {
        reservation: reservation.as_json,
        settings: Setting.all.where(key: Setting::PUBLIC_KEYS).pluck(:key, :value).to_h,
        # public_messages: {
        #   openings_monday: "Lunedì dalle 12 alle 22",
        #   openings_tuesday: "Martedì dalle 12 alle 22",
        #   openings_wednesday: "Mercoledì dalle 12 alle 22",
        #   openings_thursday: "Giovedì dalle 12 alle 22",
        #   openings_friday: "Venerdì dalle 12 alle 22",
        #   openings_saturday: "Sabato dalle 12 alle 22",
        #   openings_sunday: "Domenica dalle 12 alle 22",
        # }
        public_messages: PublicMessage.all.map { |m| [m.key, m.text] }.to_h
      }
    end
  end
end
