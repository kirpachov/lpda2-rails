# frozen_string_literal: true

require "rails_helper"

RSpec.describe "POST /v1/auth/reset_password" do
  include_context REQUEST_AUTHENTICATION_CONTEXT

  let(:reset_password_secret) { create(:reset_password_secret, user: current_user) }
  let(:password) { SecureRandom.hex }

  let(:default_headers) { {} }
  let(:default_params) { { code: reset_password_secret.secret, password: } }

  def req(headers: default_headers, params: default_params)
    post reset_password_auth_path, headers:, params:
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
      expect { req }.to have_enqueued_mail(UserMailer, :password_updated).once
    end

    it do
      default_params
      expect { req }.to(change { current_user.reset_password_secrets.not_expired.count }.by(-1))
    end

    it do
      expect { req }.to(change { reset_password_secret.reload.expires_at })
    end

    it do
      req
      expect(response).to have_http_status(:ok)
    end

    it do
      req
      expect(json).to include(success: true)
    end

    it do
      expect(current_user.reload.authenticate(password)).to eq false
      req
      expect(current_user.reload.authenticate(password)).to be_a(User)
    end

    it do
      # Simulating that .not_expired returned empty dataset
      allow(ResetPasswordSecret).to receive("not_expired").and_return(ResetPasswordSecret.where("id < 0"))

      req
      expect(response).to have_http_status(:bad_request)
      expect(json).to include(message: I18n.t("errors.messages.expired_secret"))
    end
  end

  context "when user is not authenticated" do
    let(:default_headers) { {} }

    it do
      expect { req }.to have_enqueued_mail(UserMailer, :password_updated).once
    end

    it do
      expect { req }.to(change { reset_password_secret.reload.expires_at })
    end

    it do
      req
      expect(response).to have_http_status(:ok)
    end

    it do
      req
      expect(json).to include(success: true)
    end

    it do
      expect(current_user.reload.authenticate(password)).to eq false
      req
      expect(current_user.reload.authenticate(password)).to be_a(User)
    end

    it do
      # Simulating that .not_expired returned empty dataset
      allow(ResetPasswordSecret).to receive("not_expired").and_return(ResetPasswordSecret.where("id < 0"))

      req
      expect(response).to have_http_status(:bad_request)
      expect(json).to include(message: I18n.t("errors.messages.expired_secret"))
    end
  end

  context "when not providing code" do
    let(:default_params) { super().merge(code: nil) }

    it do
      default_params
      expect { req }.not_to(change { ResetPasswordSecret.all.order(:id).pluck(:updated_at) })
    end

    it do
      req
      expect(response).to have_http_status(:bad_request)
    end

    it do
      req
      expect(json).to include(message: I18n.t("errors.messages.secret_is_required"))
    end
  end

  context "when the provided code cannot be found" do
    let(:default_params) { super().merge(code: SecureRandom.hex) }

    it do
      default_params
      expect { req }.not_to(change { ResetPasswordSecret.all.order(:id).pluck(:updated_at) })
    end

    it do
      req
      expect(response).to have_http_status(:bad_request)
    end

    it do
      req
      expect(json).to include(message: I18n.t("errors.messages.expired_secret"))
    end
  end

  context "when not providing password" do
    let(:default_params) { super().merge(password: nil) }

    it do
      default_params
      expect { req }.not_to(change { ResetPasswordSecret.all.order(:id).pluck(:updated_at) })
    end

    it do
      req
      expect(response).to have_http_status(:bad_request)
    end

    it do
      req
      expect(json).to include(message: I18n.t("errors.messages.password_is_required"))
    end
  end
end
