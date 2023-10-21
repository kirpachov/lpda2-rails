# frozen_string_literal: true

module V1
  class SettingsController < ApplicationController
    def index
      render json: {
        general: {
          name: 'My App',
        }
      }
    end
  end
end
