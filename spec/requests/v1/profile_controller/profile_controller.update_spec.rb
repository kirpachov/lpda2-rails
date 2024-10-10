# frozen_string_literal: true

require "rails_helper"

RSpec.describe "PATCH /v1/profile" do
  include_context REQUEST_AUTHENTICATION_CONTEXT

  let(:default_headers) { auth_headers }
  let(:fullname) { "#{SecureRandom.hex} Mario Rossi" }
  let(:username) { "mario.rossi#{SecureRandom.hex}" }
  let(:default_params) { { fullname: fullname, username: username } }

  def req(headers: default_headers, params: default_params)
    patch "/v1/profile", headers:, params:
  end

  context "when user is not authenticated" do
    let(:default_headers) { {} }

    before { req }

    it { expect(json).to include(message: String) }
    it { expect(response).to have_http_status(:unauthorized) }
  end

  context "when updating the fullname" do
    let(:default_params) { { fullname: fullname } }

    it { expect { req }.to(change { current_user.reload.fullname }.to(fullname)) }

    it do
      req
      expect(response).to have_http_status(:ok)
    end
  end

  context "when updating the username" do
    let(:default_params) { { username: username } }

    it { expect { req }.to(change { current_user.reload.username }.to(username)) }

    it do
      req
      expect(response).to have_http_status(:ok)
    end
  end

  context "checking response" do
    before { req }

    it do
      expect(response).to have_http_status(:ok)
    end

    it { expect(json).to include(user: Hash) }

    it {
      expect(json[:user]).to include(id: Integer, email: String, fullname: String, status: String, root_at: nil,
                                     can_root: current_user.can_root, created_at: String, updated_at: String)
    }

    it { expect(json[:user]).not_to include(:password) }
    it { expect(json[:user]).not_to include(:password_digest) }
    it { expect(json[:user]).not_to include(:enc_otp_key) }
    it { expect(json[:user]).not_to include(:otp_key) }
  end
end
