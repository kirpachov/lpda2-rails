# frozen_string_literal: true

require "rails_helper"

RSpec.describe "POST /v1/auth/logout" do
  include_context REQUEST_AUTHENTICATION_CONTEXT

  let(:default_headers) { {} }
  let(:default_params) { {} }

  def req(headers: default_headers, params: default_params)
    post logout_auth_path, headers:, params:
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
  end

  context "when user is authenticated correctly" do
    let(:default_headers) { auth_headers }

    before do
      authenticate_by_login
      auth_headers
    end

    it do
      expect { req }.to(change { response.cookies["refresh_token"] }.to(nil))
    end

    it do
      expect { req }.to(change { current_user.refresh_tokens.not_expired.count }.by(-1))
    end

    it do
      req
      expect(current_user.refresh_tokens.not_expired.count).to eq 0
    end

    it do
      req
      expect(response).to have_http_status(:ok)
    end

    it do
      req
      expect(json).to include(success: true)
    end
  end
end
