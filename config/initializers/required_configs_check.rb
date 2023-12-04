# frozen_string_literal: true

# This file is really useful: it checks if all required configs are present.
# If some of them are missing, it will raise an error.
# And app won't even start.

require_relative 'config'

if Rails.application.credentials.secret_key_base.nil?
  raise <<-ERROR

  Error
  Rails.application.credentials.secret_key_base is nil.
  This may be caused by missing credentials.yml.enc file.
  You can update configs by running in terminal:
  EDITOR=nano rails credentials:edit
  
  ERROR
end

%w[base_url temporary_block_duration].filter { |required_config| Config.public_send(required_config).blank? }.join(', ').tap do |required_configs|
  return unless required_configs.present?
  raise  <<-ERROR


    Required but missing configs: #{required_configs}
    Please add them to config/app.yml or config/app.example.yml


  ERROR
end