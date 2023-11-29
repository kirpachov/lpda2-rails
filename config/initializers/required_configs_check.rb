# frozen_string_literal: true

# This file is really useful: it checks if all required configs are present.
# If some of them are missing, it will raise an error.
# And app won't even start.

require_relative 'config'

%w[base_url].filter { |required_config| Config.public_send(required_config).blank? }.join(', ').tap do |required_configs|
  return unless required_configs.present?
  raise  <<-ERROR
    Required but missing configs: #{required_configs}"
    Please add them to config/app.yml or config/app.example.yml
  ERROR
end