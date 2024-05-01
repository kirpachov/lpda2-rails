# frozen_string_literal: true

require "rails_helper"

RSpec.describe "POST /v1/auth/require_reset_password" do
  include_context REQUEST_AUTHENTICATION_CONTEXT

  let(:other_user) { create(:user) }

  let(:default_headers) { auth_headers }
  let(:default_params) { { email: other_user.email } }

  def req(headers: default_headers, params: default_params)
    post require_reset_password_auth_path, headers:, params:
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
      expect { req }.to have_enqueued_mail(UserMailer, :reset_password).once
    end

    it do
      expect { req }.to(change { current_user.refresh_tokens.not_expired.count }.by(-1))
    end

    it do
      req
      expect(response).to have_http_status(:ok)
    end

    it do
      req
      expect(json).to include(success: true)
    end

    context "when providing invalid email" do
      let(:default_params) { { email: nil } }

      it do
        expect { req }.not_to have_enqueued_mail(UserMailer, :reset_password)
      end

      it do
        expect { req }.to(change { current_user.refresh_tokens.not_expired.count }.by(-1))
      end

      it do
        expect { req }.to(change { response.cookies["refresh_token"] }.to(nil))
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

  context "when user is not authenticated" do
    let(:default_headers) { {} }

    it do
      expect { req }.to have_enqueued_mail(UserMailer, :reset_password).once
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
