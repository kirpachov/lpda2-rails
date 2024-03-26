# frozen_string_literal: true

# User-level preferences, like language.
class Preference < ApplicationRecord
  # ################################
  # Associations
  # ################################
  belongs_to :user, inverse_of: :preferences, optional: false

  # ################################
  # Validations
  # ################################
  validates_with KeyValueValidator
  validates_presence_of :key
  validates_uniqueness_of :key, scope: :user_id, case_sensitive: false
  validates_inclusion_of :key, in: DEFAULTS.keys.map(&:to_s)

  # ################################
  # Class methods
  # ################################
  class << self
    def create_missing_for(user)
      DEFAULTS.each do |key, data|
        where(key:, user:).first_or_create!(data.as_json(except: :default))
      end
    end

    def default(key)
      DEFAULTS[key]&.[](:default)
    end
  end

  # ################################
  # Instance methods
  # ################################
  def value_for(user)
    user.preference_value(key)
  end
end
