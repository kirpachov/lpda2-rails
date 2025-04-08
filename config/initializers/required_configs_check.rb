# frozen_string_literal: true

# This file is really useful: it checks if all required configs are present.
# If some of them are missing, it will raise an error.
# And app won't even start.

require_relative "config"

MANDATORY_CONFIGS = %w[
  base_url frontend_base_url show_reservation_url
  processed_payment_reservation_url cancelled_payment_reservation_url
  temporary_block_duration
].freeze

WARNING_CONFIGS = %w[
  whatsapp_reservation_confirmation_template_name
  whatsapp_api_url
  whatsapp_phone_number_id
  whatsapp_access_token

  nexi_mac_key
  nexi_alias_merchant
].freeze

if Rails.application.credentials.secret_key_base.nil?
  raise <<-ERROR

  Error
  Rails.application.credentials.secret_key_base is nil.
  This may be caused by missing credentials.yml.enc file.
  You can update configs by running in terminal:

  EDITOR=nano rails credentials:edit

  ERROR
end

MANDATORY_CONFIGS.filter { |required_config| Config.public_send(required_config).blank? }.join(", ").tap do |required_configs|
  next unless required_configs.present?

  raise <<-ERROR


    Required but missing configs: #{required_configs}
    Please add them to config/app.yml or config/app.example.yml


  ERROR
end

WARNING_CONFIGS.filter { |required_config| Config.public_send(required_config).blank? }.join(", ").tap do |required_configs|
  next unless required_configs.present?

  puts <<-WARNING

    WARNING: The following configs are empty: #{required_configs}
    Please check them in config/app.yml or config/app.example.yml

  WARNING
end

#
# [
#   [:frontend_urls, :cancel_reservation]
# ].map{|keys| [keys, Config.hash.dig(*keys)] }.each do |keys, value|
#   next if value.present?
#   raise  <<-ERROR
#
#     REQUIRED CONFIG MISSING: #{keys.join('.')}
#
#   ERROR
# end
