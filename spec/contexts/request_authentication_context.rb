# frozen_string_literal: true

REQUEST_AUTHENTICATION_CONTEXT = "request authentication"

RSpec.shared_context REQUEST_AUTHENTICATION_CONTEXT do
  let(:current_user_password) { SecureRandom.alphanumeric(20) }
  let(:current_user) { create(:user, :with_fullname, password: current_user_password) }
  let(:jwt) { current_refresh_token.generate_jwt }
  let(:auth_headers) { { "Authorization" => "Bearer #{jwt}" } }
  let(:jwt_data) { Auth::JsonWebToken.decode(jwt) }
  let(:current_refresh_token) { @current_refresh_token || create(:refresh_token, user: current_user) }

  let(:authenticate_by_login) do
    last_refresh_token_id = RefreshToken.order(id: :desc).limit(1).pluck(:id).last.to_i
    post login_auth_path, headers:, params: { email: current_user.email, password: current_user_password }

    if last_refresh_token_id.present?
      @current_refresh_token = RefreshToken.where("id > ?", last_refresh_token_id).first
    else
      @current_refresh_token = RefreshToken.last
    end
  end
end
