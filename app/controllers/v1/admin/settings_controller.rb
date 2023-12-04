# frozen_string_literal: true

module V1
  module Admin
    class SettingsController < ApplicationController
      before_action :validate_key_exists, only: %i[value show update]

      attr_reader :setting

      def index
        render json: Setting.all_hash
      end

      def show
        render json: setting_json(setting)
      end

      def value
        render json: { value: setting.value.to_s }
      end

      def update
        updated = setting.update(value: params[:value])

        unless updated
          return render json: {
            message: "#{I18n.t('settings.update_failed')}:#{setting.errors.full_messages.join('; ')}",
            details: setting.errors.as_json
          }, status: 422
        end

        render json: setting_json(setting.reload)
      end

      private

      def setting_json(setting)
        setting.as_json(except: %i[id created_at]).merge(value: (setting.value || Setting.default(setting.key)).to_s)
      end

      def validate_key_exists
        render json: { message: I18n.t('preferences.key_not_found') }, status: 404 unless (@setting = Setting.where(key: params[:key]).first).present?
      end
    end
  end
end
