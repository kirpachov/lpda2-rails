# frozen_string_literal: true

module Auth
  class RefreshJwtToken < ActiveInteraction::Base
    string :refresh_token_secret

    def execute
      return unless validate_and_refresh_token

      {
        body: {
          token: @result[:jwt]
        },
        new_refresh_token: @result[:new_secret]
      }
    end

    private

    def validate_and_refresh_token
      @result = nil
      return secret_blank! if secret.nil? || secret.blank?

      RefreshToken.transaction do
        return refresh_token_not_found! if refresh_token.nil?

        return user_not_found! if user.nil? || user.deleted?

        jwt = JsonWebToken.encode(user_id: user.id, can_root: user.can_root, root_at: user.root_at, refresh_token_id: refresh_token.id)
        refresh_token.secret = SecureRandom.urlsafe_base64(32)
        if refresh_token.save
          @result = { jwt:, new_secret: refresh_token.secret }
        else
          errors.add :failed_to_refresh_token, refresh_token.errors.full_messages[0]
        end
      end

      @result
    end

    def secret_blank!
      errors.add :missing_refresh_token, I18n.t("errors.messages.missing_refresh_token")
      nil
    end

    def refresh_token_not_found!
      errors.add :invalid_refresh_token, I18n.t("errors.messages.invalid_refresh_token")
      nil
    end

    def user_not_found!
      errors.add :user_not_found, I18n.t("errors.messages.user_not_found")
      nil
    end

    def refresh_token
      @refresh_token ||= find_refresh_token
    end

    def find_refresh_token
      RefreshToken.not_expired.lock(true).find_by(secret: secret)
    end

    def secret
      refresh_token_secret
    end

    def user
      refresh_token&.user
    end
  end
end
