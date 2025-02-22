# frozen_string_literal: true

class RoutesBasicAuth
  class << self
    def call(klass, username:, password:)
      raise ArgumentError, 'klass must be a class' unless klass.is_a?(Class)

      Rack::Builder.new do
        if username.is_a?(String) && username.present? && password.is_a?(String) && password.present?
          use Rack::Auth::Basic do |provided_username, provided_password|
            ActiveSupport::SecurityUtils.secure_compare(provided_username, username) &&
              ActiveSupport::SecurityUtils.secure_compare(provided_password, password)
          end
        else
          puts "No username or password provided. Basic auth is disabled for #{klass}."
          Rails.logger.warn "No username or password provided. Basic auth is disabled for #{klass}."
        end

        map '/' do
          run klass
        end
      end
    end
  end
end
