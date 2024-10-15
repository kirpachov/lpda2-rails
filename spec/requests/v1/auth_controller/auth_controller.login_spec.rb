# frozen_string_literal: true

require "rails_helper"

RSpec.describe "POST /v1/auth/login" do
  let(:password) { SecureRandom.hex }
  let(:email) { Faker::Internet.email }
  let(:username) { "user#{SecureRandom.hex}" }
  let(:user) { create(:user, password:, email:) }

  let(:default_headers) { {} }
  let(:default_params) { { password:, email: } }

  def req(headers: default_headers, params: default_params)
    post login_auth_path, headers:, params:
  end

  context "when providing correct email and password" do
    before { user }

    it do
      expect { req }.to(change { RefreshToken.count }.by(1))
    end

    it do
      req
      expect(response).to have_http_status(:ok)
    end

    it do
      req
      expect(json).to include(jwt: String)
    end
  end

  context "when providing correct username and password" do
    before { user.update!(username:) }
    let(:default_params) { { password:, username: } }

    it do
      expect { req }.to(change { RefreshToken.count }.by(1))
    end

    it do
      req
      expect(response).to have_http_status(:ok)
    end

    it do
      req
      expect(json).to include(jwt: String)
    end
  end

  context "when providing correct username but calling param as email ({ email: <username> })" do
    before { user.update!(username:) }
    let(:default_params) { { password:, email: username } }

    it do
      expect { req }.to(change { RefreshToken.count }.by(1))
    end

    it do
      req
      expect(response).to have_http_status(:ok)
    end

    it do
      req
      expect(json).to include(jwt: String)
    end
  end

  context "when providing correct email but calling param as username ({ username: <email> })" do
    before { user.update!(username:) }
    let(:default_params) { { password:, username: email } }

    it do
      expect { req }.to(change { RefreshToken.count }.by(1))
    end

    it do
      req
      expect(response).to have_http_status(:ok)
    end

    it do
      req
      expect(json).to include(jwt: String)
    end
  end

  context "when user had already valid refresh tokens" do
    before do
      user
      req
    end

    it do
      expect { req }.to(change { RefreshToken.expired.count }.by(1))
    end

    it do
      expect { req }.to(change { RefreshToken.count }.by(1))
    end

    it do
      req
      expect(response).to have_http_status(:ok)
    end

    it do
      req
      expect(json).to include(jwt: String)
    end

    it do
      expect { req }.to(change { response.cookies["refresh_token"] })
    end

    it do
      expect(RefreshToken.not_expired.where(user:).count).to eq 1
    end

    it do
      req
      expect(RefreshToken.not_expired.where(user:).count).to eq 1
    end
  end

  context "when providing incorrect email and correct password" do
    before { user }

    let(:default_params) { { password:, email: Faker::Internet.email } }

    it do
      expect { req }.not_to(change { RefreshToken.count })
    end

    it do
      req
      expect(response).to have_http_status(:unauthorized)
    end

    it do
      req
      expect(json[:message]).to be_a(String)
      expect(json[:message]).to include("Email or password")
    end
  end

  context "when providing correct email and incorrect password" do
    before { user }

    let(:default_params) { { password: SecureRandom.hex, email: } }

    it do
      expect { req }.not_to(change { RefreshToken.count })
    end

    it do
      req
      expect(response).to have_http_status(:unauthorized)
    end

    it do
      req
      expect(json[:message]).to be_a(String)
      expect(json[:message]).to include("Email or password")
    end

    it do
      expect { req }.to change { user.reload.failed_attempts }.by(1)
    end
  end

  context "when providing incorrect email and correct password or vice versa, message should be the same" do
    before do
      user
      req(params: default_params.merge(email: Faker::Internet.email))
      expect(response).to have_http_status(:unauthorized)
      msg
    end

    let(:msg) { json[:message] }

    it { expect(msg).to be_a(String) }
    it { expect(msg).to be_present }

    it do
      req(params: default_params.merge(password: SecureRandom.hex))
      expect(json[:message]).to eq msg
    end
  end

  context "when user had some valid reset password, they should be deleted or expired" do
    before do
      user
      create(:reset_password_secret, user:)
      create(:reset_password_secret, user: create(:user))
    end

    it do
      expect(user.reset_password_secrets.count).to eq 1
    end

    it do
      expect { req }.to(change { ResetPasswordSecret.not_expired.count }.by(-1))
    end
  end

  context "after many attempts, user will be temporarily locked." do
    before do
      user
      15.times do
        req(params: default_params.merge(password: SecureRandom.hex))
        expect(response).to have_http_status(:unauthorized)
      end
    end

    it do
      req
      expect(response).to have_http_status(:unauthorized)
    end

    it do
      req
      expect(json[:message]).to include("locked")
    end

    it "messages includes 'try again'" do
      req
      expect(json[:message]).to include("try again")
    end

    it "if tries to login with wrong credentials after some time, will get 401" do
      travel_to(1.hour.from_now) do
        req(params: default_params.merge(password: SecureRandom.hex))
        expect(response).to have_http_status(:unauthorized)
      end
    end

    it "if correct password, user's failed_attempts will be set to 0" do
      travel_to(1.hour.from_now) do
        expect { req(params: default_params) }.to(change { user.reload.failed_attempts }.to(0))
      end
    end

    it "if correct password, user's locked_at field will be set to nil" do
      travel_to(1.hour.from_now) do
        expect { req(params: default_params) }.to(change { user.reload.locked_at }.to(nil))
      end
    end

    it do
      travel_to(1.hour.from_now) do
        req(params: default_params)
        expect(response).to have_http_status(:ok)
      end
    end
  end

  context "when failing many times, user will be blocked after as many attempts as max_login_attempts config" do
    before { user }

    let(:default_params) { { email:, password: SecureRandom.hex } }

    it { expect(user.failed_attempts).to eq 0 }
    it { expect(user.locked_at).to be_nil }

    it do
      (Rails.configuration.app[:max_login_attempts].to_i - 1).times do
        expect { req }.to change { user.reload.failed_attempts }.by(1)
      end

      expect { req }.to(change { user.reload.locked_at }.from(nil))
    end
  end
end
