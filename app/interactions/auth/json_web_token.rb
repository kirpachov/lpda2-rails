# frozen_string_literal: true

module Auth
  class JsonWebToken
    class << self

      def encode_refresh_token_data(refresh_token)
        encode(user_id: refresh_token.user.id, refresh_token_id: refresh_token.id)
      end

      def encode(payload, exp = 15.minutes.from_now)
        payload[:exp] = exp.to_i
        payload[:ttl] = exp.to_i - Time.now.to_i
        JWT.encode(payload, Rails.application.credentials.secret_key_base)
      end

      def decode(token)
        body = JWT.decode(token, Rails.application.credentials.secret_key_base)[0]
        HashWithIndifferentAccess.new body
      rescue JWT::DecodeError
        nil
      end
    end
  end
end
