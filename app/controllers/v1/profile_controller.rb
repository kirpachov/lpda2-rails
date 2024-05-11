# frozen_string_literal: true

module V1
  class ProfileController < ApplicationController
    # GET /v1/profile
    def index
      render json: {
        user: current_user.as_json
      }
    end
  end
end
