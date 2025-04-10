# frozen_string_literal: true

if !Rails.env.production? && Rails.application.config.i18n.raise_on_missing_translations
  I18n.exception_handler = ->(msg, *) { raise msg }
end
