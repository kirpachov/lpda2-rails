# frozen_string_literal: true

module V1
  class AuthController < ApplicationController
    skip_before_action :authenticate_user, except: [:logout]

    def login
      auth = Auth::AuthenticateUser.run(email: params[:email], password: params[:password])

      if auth.valid?
        invalidate_refresh_token!
        update_refresh_token_cookie(auth.result[:refresh_token])
        render json: { jwt: auth.result[:jwt] }
      else
        render_error status: 401, details: auth.errors, message: auth.errors.full_messages.join("; ")
      end
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
        expires: 1.week.from_now.utc
      }

      render json: refresh.result[:body]
    end

    def logout
      RefreshToken.where(user: current_user, secret: cookies.encrypted["refresh_token"]).first&.expire!

      cookies.delete :refresh_token

      render json: { success: true, user: current_user.as_json }
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
      user = User.active.where(email: params[:email]).first

      user.send_reset_password_email if user

      render json: { success: true }
    end

    def reset_password
      code = params[:code] || params[:token] || params[:secret]
      return render_error status: 400, message: I18n.t("errors.messages.secret_is_required") if code.blank?

      return render_error status: 400, message: I18n.t("errors.messages.password_is_required") if params[:password].blank?

      secret = ResetPasswordSecret.not_expired.where(secret: code).first
      return render_error status: 400, message: I18n.t("errors.messages.expired_secret") unless secret

      return render_record_errors secret.user unless secret.user.update(password: params[:password])

      secret.expire!

      UserMailer.with(user_id: secret.user&.id).password_updated.deliver_later

      render json: { success: true }
    end

    private

    # Expire previous refresh token of this client, so that it won't be usable anymore.
    def invalidate_refresh_token!
      return unless cookies.encrypted[:refresh_token].present?

      RefreshToken.where(secret: cookies.encrypted[:refresh_token]).first&.expire!

      cookies.delete :refresh_token
    end

    # Update refresh token cookie with updated secret value
    def update_refresh_token_cookie(refresh_token)
      return unless refresh_token.present?

      cookies.encrypted[:refresh_token] = {
        value: refresh_token.secret,
        httponly: true,
        expires: 1.week.from_now.utc
      }
    end
  end
end
