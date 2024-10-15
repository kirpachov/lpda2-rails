# frozen_string_literal: true

module V1
  class AuthController < ApplicationController
    skip_before_action :authenticate_user, except: [:logout]
    before_action :try_authenticate_user, only: %i[require_reset_password reset_password]

    # POST /v1/auth/login
    def login
      auth = Auth::AuthenticateUser.run(username: params[:username].presence || params[:email], password: params[:password])

      if auth.invalid?
        # Always add a delay when user fails to login.
        # https://devblogs.microsoft.com/oldnewthing/20100323-00/?p=14513
        sleep 5 unless Rails.env.test?

        return render_error status: 401, details: auth.errors, message: auth.errors.full_messages.join("; ")
      end

      # Invalidate previous refresh token
      invalidate_refresh_token!

      # Attach the cookie to the client.
      update_refresh_token_cookie(auth.result[:refresh_token])

      # If you were able to login, you won't need to reset the password anymore.
      auth.result[:user].reset_password_secrets.delete_all
      render json: { jwt: auth.result[:jwt] }
    end

    def refresh_token
      # Use RefreshJwtToken command to obtain a new JWT and a new RefreshToken
      refresh = Auth::RefreshJwtToken.run(refresh_token_secret: cookies.encrypted["refresh_token"])
      unless refresh.valid?
        return render_error status: 401,
                            details: refresh.errors,
                            message: refresh.errors.full_messages.join("; ")
      end

      # If refresh is successful, store new RefreshToken to a HttpOnly signed cookie
      cookies.encrypted["refresh_token"] = {
        value: refresh.result[:new_refresh_token],
        httponly: true,
        expires: 1.week.from_now.utc,
        same_site: Config.all[:cookie_same_site],
        secure: Config.all[:cookie_secure]
      }

      render json: refresh.result[:body]
    end

    def logout
      do_logout

      render json: { success: true } # , user: current_user.as_json
    end

    # def require_otp
    #   @user = User.active.where(email: params[:email]).first
    #   return render_error status: 400, message: I18n.t("errors.messages.user_not_found") unless @user
    #
    #   UserMailer.with(user_id: @user.id, otp: @user.generate_otp).otp.deliver_later
    #
    #   render json: { success: true }
    # end

    def require_reset_password
      # If you're logged in and you require reset password, something is wrong, so imma logout you to avoid complications.
      do_logout if current_user.present?

      user = User.active.where(email: params[:email]).first

      user.send_reset_password_email if user

      render json: { success: true }
    end

    # POST /v1/auth/reset_password
    # Provide:
    # - code / token / secret: the secret of the ResetPasswordSecret. Present in the email sent by require_reset_password.
    # - password: new password for that user.
    #
    # TODO: somebody may bruteforce this endpoint to set a password for some user. May protect with ip / cookies / delay (?)
    def reset_password
      do_logout if current_user.present?

      code = params[:code] || params[:token] || params[:secret]
      return render_error status: 400, message: I18n.t("errors.messages.secret_is_required") if code.blank?

      if params[:password].blank?
        return render_error status: 400,
                            message: I18n.t("errors.messages.password_is_required")
      end

      secret = ResetPasswordSecret.not_expired.where(secret: code).first
      return render_error status: 400, message: I18n.t("errors.messages.expired_secret") unless secret

      return render_record_errors secret.user unless secret.user.update(password: params[:password])

      secret.expire!

      UserMailer.with(user_id: secret.user&.id).password_updated.deliver_later

      render json: { success: true }
    end

    private

    def do_logout
      RefreshToken.where(user: current_user, secret: cookies.encrypted["refresh_token"]).first&.expire!

      cookies.delete :refresh_token
    end

    # Expire previous refresh token of this client, so that it won't be usable anymore.
    def invalidate_refresh_token!
      return if cookies.encrypted[:refresh_token].blank?

      RefreshToken.where(secret: cookies.encrypted[:refresh_token]).first&.expire!

      cookies.delete :refresh_token
    end

    # Update refresh token cookie with updated secret value
    def update_refresh_token_cookie(refresh_token)
      return if refresh_token.blank?

      cookies.encrypted[:refresh_token] = {
        value: refresh_token.secret,
        httponly: true,
        expires: 1.week.from_now.utc,
        same_site: Config.all[:cookie_same_site],
        secure: Config.all[:cookie_secure]
      }
    end
  end
end
