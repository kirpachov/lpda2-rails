# frozen_string_literal: true

class Setting
  DEFAULTS = {
    default_language: {
      # value: :en,
      default: I18n.default_locale,
    },
  }.with_indifferent_access.freeze
end
