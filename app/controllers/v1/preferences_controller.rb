# frozen_string_literal: true

module V1
  class PreferencesController < ApplicationController
    before_action :validate_key_exists, only: %i[value show update]

    def index
      render json: current_user.preferences_hash
    end

    def show
      render json: preference_json(current_user.preference(params[:key]))
      # render json: current_user.preference(params[:key]).as_json(except: %i[id created_at]).merge(value: current_user.preference_value(params[:key]))
    end

    def value
      render json: current_user.preference_value(params[:key])
    end

    def update
      preference = current_user.preference(params[:key])
      updated = preference.update(value: params[:value])

      unless updated
        return render json: { message: "#{I18n.t('preferences.update_failed')}:#{preference.errors.full_messages.join('; ')}", details: preference.errors.as_json }, status: 422
      end
      # current_user.preference(params[:key]).update(value: params[:value])

      render json: preference_json(current_user.preference(params[:key]))
    end

    private

    def preference_json(preference)
      preference.as_json(except: %i[id created_at]).merge(value: preference.value_for(current_user))
    end

    def validate_key_exists
      render json: { message: I18n.t('preferences.key_not_found') }, status: 404 unless current_user.preference(params[:key])
    end

    def all
      current_user.preferences
    end
  end
end