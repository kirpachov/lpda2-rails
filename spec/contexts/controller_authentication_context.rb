# frozen_string_literal: true

CONTROLLER_AUTHENTICATION_CONTEXT = "controller authentication"

RSpec.shared_context CONTROLLER_AUTHENTICATION_CONTEXT do
  attr_accessor :current_user

  def authenticate_request(user: nil)
    user ||= create(:user)
    @refresh_token = create(:refresh_token, user:)
    @current_user = user.reload

    @request.headers["Authorization"] = "Bearer #{Auth::JsonWebToken.encode_refresh_token_data(@refresh_token)}"
  end
end
