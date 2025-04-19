# frozen_string_literal: true

module V1
  class PublicDataController < ApplicationController
    skip_before_action :authenticate_user

    def index
      common_data = cache_action_response do
        calc_public_data
      end

      reservation = Reservation.public_visible.find_by(
        secret: cookies[Reservation::PUBLIC_CREATE_COOKIE],
        datetime: Time.zone.now..
      )

      render json: common_data.merge(
        reservation: reservation.as_json(
          only: %w[id fullname datetime status secret children adults notes email phone created_at updated_at],
          include: [
            {
              payment: {
                only: %i[hpp_url preorder_type status value]
              }
            }
          ]
        )
      )
    end

    def calc_public_data
      {
        settings: Setting.all.where(key: Setting::PUBLIC_KEYS).pluck(:key, :value).to_h,
        public_messages: PublicMessage.visible.i18n.pluck(:key, :text).to_h,
        contacts: Contact.public_formatted
      }
    end
  end
end
