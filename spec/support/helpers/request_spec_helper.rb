# frozen_string_literal: true

module RequestSpecHelper
  attr_accessor :refresh_token_cookie

  def json
    JSON.parse(response.body).with_indifferent_access
  end

  def authenticate_user!(email, password)
    post login_v1_auth_path, params: { email:, password: }
    @refresh_token_cookie = response.cookies["refresh_token"]
  end

  def cookies_jar
    ActionDispatch::Cookies::CookieJar.build(request, cookies.to_hash)
  end

  # Delegate the `media_type` method to the `response` object (same as calling response.media_type).
  delegate :media_type, to: :response
end
