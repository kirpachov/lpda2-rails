# frozen_string_literal: true

REQUEST_AUTHENTICATION_CONTEXT = "request authentication"

RSpec.shared_context REQUEST_AUTHENTICATION_CONTEXT do
  let(:current_user_password) { SecureRandom.alphanumeric(20) }
  let(:current_user) { create(:user, :with_fullname, password: current_user_password) }
  let(:jwt) { current_refresh_token.generate_jwt }
  let(:auth_headers) { { "Authorization" => "Bearer #{jwt}" } }
  let(:jwt_data) { Auth::JsonWebToken.decode(jwt) }
  let(:current_refresh_token) { create(:refresh_token, user: current_user) }
end
