# frozen_string_literal: true

class Setting
  DEFAULTS = {
    default_language: {
      # value: :en,
      default: I18n.default_locale,
    },

    available_locales: {
      default: I18n.available_locales
    }
  }.with_indifferent_access.freeze
end
