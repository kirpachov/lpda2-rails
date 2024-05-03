# frozen_string_literal: true

require "rails_helper"

RSpec.describe "GET /v1/profile" do
  include_context REQUEST_AUTHENTICATION_CONTEXT

  let(:default_headers) { auth_headers }
  let(:default_params) { {} }

  def req(headers: default_headers, params: default_params)
    get profile_path, headers:, params:
  end

  context "when user is not authenticated" do
    let(:default_headers) { {} }

    before { req }

    it { expect(json).to include(message: String) }
    it { expect(response).to have_http_status(:unauthorized) }
  end

  context "when user is authenticated" do
    before { req }

    it { expect(json).to include(user: Hash) }
    it { expect(json[:user]).to include(id: Integer, email: String, fullname: String, status: String, root_at: nil, can_root: current_user.can_root, created_at: String, updated_at: String) }

    it { expect(json[:user]).not_to include(:password) }
    it { expect(json[:user]).not_to include(:password_digest) }
    it { expect(json[:user]).not_to include(:enc_otp_key) }
    it { expect(json[:user]).not_to include(:otp_key) }
  end
end
