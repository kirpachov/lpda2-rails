# frozen_string_literal: true

module V1
  module Admin
    class SettingsController < ApplicationController
      # before_action :validate_key_exists, only: %i[value show update]
      before_action :find_item, only: %i[show update]

      # GET /v1/admin/settings
      def index
        render json: {
          # items: current_user.settings.map { |setting| setting_json(setting) }
          items: Setting.all.order(:key).map { |setting| setting_json(setting) }
        }
      end

      # GET /v1/admin/settings/hash
      def hash
        render json: Setting.all.order(:key).to_h { |p| [p.key, p.value || Setting.default(p.key)] }
      end

      # GET /v1/admin/settings/:key
      def show
        render json: setting_json(@item)
      end

      # PATCH /v1/admin/settings/:key
      def update
        return render_unprocessable_entity(@item) unless @item.update(value: params[:value])

        show
      end

      private

      def find_item
        @item = Setting.find_by(key: params[:key])
        return if @item.present?

        render json: { message: I18n.t("settings.key_not_found", key: params[:key].inspect) }, status: :not_found
      rescue ActiveRecord::RecordNotFound
        render json: { message: I18n.t("settings.key_not_found", key: params[:key].inspect) }, status: :not_found
      end

      def setting_json(setting)
        setting.as_json(except: %i[id created_at])
      end

      def validate_key_exists
        return if current_user.setting(params[:key])

        render json: { message: I18n.t("settings.key_not_found") },
               status: :not_found
      end
    end
  end
end
