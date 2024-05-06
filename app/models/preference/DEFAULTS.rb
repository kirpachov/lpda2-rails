# frozen_string_literal: true

class Preference
  DEFAULTS = {
    language: {
      # value: :en,
      default: I18n.default_locale
    },

    known_languages: {
      # value: [:en],
      default: I18n.available_locales
    },

    # NOTE: Server is always in UTC.
    timezone: {
      # value: nil,
      default: Rails.configuration.time_zone
    },

  }.with_indifferent_access.freeze
end
