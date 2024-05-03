# frozen_string_literal: true

module V1
  module Admin
    class PreferencesController < ApplicationController
      before_action :validate_key_exists, only: %i[value show update]

      # GET /v1/admin/preferences
      def index
        render json: {
          items: current_user.preferences.map { |preference| preference_json(preference) }
        }
      end

      # GET /v1/admin/preferences/hash
      def hash
        render json: current_user.preferences_hash
      end

      # GET /v1/admin/preferences/:key
      def show
        render json: preference_json(current_user.preference(params[:key]))
        # render json: current_user.preference(params[:key]).as_json(except: %i[id created_at]).merge(value: current_user.preference_value(params[:key]))
      end

      # PATCH /v1/admin/preferences/:key
      def update
        preference = current_user.preference(params[:key])

        return render_unprocessable_entity(preference) unless preference.update(value: params[:value])

        render json: preference_json(current_user.preference(params[:key]))
      end

      private

      def preference_json(preference)
        preference.as_json(except: %i[id created_at]).merge(value: preference.value_for(current_user))
      end

      def validate_key_exists
        return if current_user.preference(params[:key])

        render json: { message: I18n.t("preferences.key_not_found") },
               status: :not_found
      end

      def all
        current_user.preferences
      end
    end
  end
end
