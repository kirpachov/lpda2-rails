# frozen_string_literal: true

module Auth
  # A SimpleCommand class for user authentication and JWT token generation
  class AuthenticateUser < ActiveInteraction::Base
    string :email, :password

    def execute
      {
        user:,
        refresh_token:,
        jwt:
      }
    end

    def refresh_token
      return nil unless user

      @refresh_token ||= user.generate_refresh_token
    end

    def jwt
      return nil unless user

      @jwt ||= refresh_token.generate_jwt
    end

    def user
      @user ||= find_user
    end

    protected

    # Find and authenticate user
    def find_user
      return @user if @find_user_called

      @find_user_called = true
      result = nil
      @user = User.find_by_email(email)

      # Check if user exists
      if @user.nil?
        errors.add :authentication, I18n.t(".errors.messages.invalid_email_or_password")
        return nil
      end

      # Check if user is blocked and throw :failed if so
      return nil if user_blocked?(@user)

      User.transaction do
        # Lock user in DB
        @user.lock!

        catch :failed do
          # Authenticate user or throw :failed on authentication failure
          authenticate!(@user)

          # If authentication is successful, return the user
          result = user
        end
      end

      result
    end

    # Check if user is blocked and throw :failed if so
    def user_blocked?(user)
      # return false unless user.blocked?

      errors.add :temporarily_blocked, I18n.t("errors.messages.account_tmp_locked") if user.temporarily_blocked?
      if user.deleted?
        errors.add :user_deleted, I18n.t("errors.messages.account_deleted")
        return true
      end

      false
    end

    # Verify user's password
    def authenticate!(user)
      if user.authenticate(password)
        # Password is correct, so reset failure data
        user.locked_at = nil
        user.failed_attempts = 0
        user.save!
      else
        # Wrong password, trace authentication failure and throw :failed
        authentication_failed!(user)
      end
    end

    # Trace authentication failure and block user if necessary.
    def authentication_failed!(user)
      errors.add :authentication, I18n.t("errors.messages.invalid_email_or_password")
      user.failed_attempts += 1

      max_attempts = Rails.configuration.app[:max_login_attempts].to_i
      if user.failed_attempts >= max_attempts
        user.temporarily_block!
        errors.add :account_blocked, I18n.t("errors.messages.too_failed_attempts")
      end

      user.save!

      throw :failed
    end
  end
end
