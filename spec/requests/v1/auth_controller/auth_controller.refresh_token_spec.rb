# frozen_string_literal: true

require "rails_helper"

RSpec.describe "POST /v1/auth/refresh_token" do
  include_context REQUEST_AUTHENTICATION_CONTEXT

  let(:default_headers) { {} }
  let(:default_params) { {} }

  def req(headers: default_headers, params: default_params)
    post refresh_token_auth_path, headers:, params:
  end

  context "when making requests without a refresh token" do
    let(:default_headers) { {} }

    it do
      req
      expect(response).to have_http_status(:unauthorized)
    end

    it do
      expect { req }.not_to(change { RefreshToken.all.order(:id).pluck(:updated_at) })
    end

    it do
      expect { req }.not_to(change { User.all.order(:id).pluck(:updated_at) })
    end

    it do
      req
      expect(json[:message]).to include("Refresh token")
    end
  end

  context "when making requests with a invalid refresh token" do
    let(:default_headers) { { "Authorization" => "Bearer some-invalid-refresh-token" } }

    it do
      req
      expect(response).to have_http_status(:unauthorized)
    end

    it do
      expect { req }.not_to(change { RefreshToken.all.order(:id).pluck(:updated_at) })
    end

    it do
      expect { req }.not_to(change { User.all.order(:id).pluck(:updated_at) })
    end

    it do
      req
      expect(json[:message]).to include("Refresh token")
    end
  end

  context "when request is successful" do
    before do
      authenticate_by_login
    end

    it do
      req
      expect(response).to have_http_status(:ok)
    end

    it do
      req
      expect(json).to include(token: String)
    end

    it do
      expect { req }.not_to(change { RefreshToken.all.order(:id).pluck(:id) })
    end

    it do
      expect { req }.to(change { current_user.refresh_tokens.order(:id).pluck(:secret) })
    end

    it do
      expect { req }.to(change { response.cookies["refresh_token"] })
      expect(response.cookies["refresh_token"]).to be_present
    end
  end

  context "when user has status deleted" do
    before do
      authenticate_by_login
      current_user.deleted!
    end

    it do
      req
      expect(response).to have_http_status(:unauthorized)
    end

    it do
      expect { req }.not_to(change { RefreshToken.all.order(:id).pluck(:id) })
    end

    it do
      expect { req }.not_to(change { current_user.refresh_tokens.order(:id).pluck(:secret) })
    end
  end
end
