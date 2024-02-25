require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Lpda2
  class Application < Rails::Application
    config.load_defaults 7.0

    config.app = config_for('app.example').symbolize_keys
    config.app.merge!(config_for('app').symbolize_keys) if File.exist?('config/app.yml')

    config.time_zone = 'UTC'

    config.generators do |generate|
      generate.test_framework :rspec,
                              fixtures: true,
                              view_specs: false,
                              helper_specs: true,
                              routing_specs: true,
                              controller_specs: true,
                              request_specs: false

      generate.fixture_replacement :factory_bot, dir: "spec/factories"
    end

    config.eager_load_paths << Rails.root.join('lib')
    config.eager_load_paths << Rails.root.join('test', 'mailers', 'previews')

    # config.session_store :cookie_store, key: '_interslice_session'
    # config.middleware.use ActionDispatch::Cookies
    # config.middleware.use config.session_store, config.session_options
    # This also configures session_options for use below
    config.middleware.use ActionDispatch::Cookies

    config.session_store :cookie_store, key: '_interslice_session'
    # Required for all session management (regardless of session_store)
    config.middleware.use config.session_store, config.session_options

    # config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]
    config.active_record.default_timezone = :utc
    config.i18n.default_locale = :en
    config.i18n.available_locales = %i[it en]

    smtp = Rails.configuration.app[:smtp]
    imap = Rails.configuration.app[:imap]
    Mail.defaults do
      if imap
        retriever_method :imap, :address        => imap[:address],
                                :port           => imap[:port],
                                :user_name      => imap[:user_name],
                                :password       => imap[:password],
                                :enable_ssl     => imap[:enable_ssl]
      end

      if smtp
        delivery_method :smtp, :address         => smtp[:address],
                                :port           => smtp[:port],
                                :authentication => smtp[:authentication],
                                :password       => smtp[:password],
                                :user_name      => smtp[:user_name]
      end
    end
    if smtp
      config.action_mailer.delivery_method = :smtp
      config.action_mailer.smtp_settings = smtp
    end

    Rails.application.routes.default_url_options[:host] = Rails.configuration.app[:base_url]

    config.hosts = Rails.configuration.app[:origins]

    config.active_job.queue_adapter = :sidekiq

    config.api_only = true
  end
end
