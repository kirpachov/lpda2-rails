# frozen_string_literal: true

# User-level preferences, like language.
class Preference < ApplicationRecord
  belongs_to :user, inverse_of: :preferences, optional: false

  validates_with KeyValueValidator

  class << self
    def create_missing_for(user)
      DEFAULTS.each do |key, data|
        where(key: key, user: user).first_or_create!(data.as_json(except: :default))
      end
    end

    def default(key)
      DEFAULTS[key]&.[](:default)
    end
  end
end
