# frozen_string_literal: true

# App-level settings are stored in the database.
# Some of the settings may require root mode to change.
class Setting < ApplicationRecord

  # ################################
  # Validations
  # ################################
  validates_with KeyValueValidator
  validates_presence_of :key
  validates_uniqueness_of :key, case_sensitive: false
  validates_inclusion_of :key, in: DEFAULTS.keys.map(&:to_s)

  class << self
    def all_hash
      all.map { |s| [s.key, (s.value || default(s.key)).to_s] }.to_h.with_indifferent_access
    end

    def default(key)
      DEFAULTS[key]&.[](:default)
    end

    def create_missing
      DEFAULTS.each do |key, data|
        where(key: key).first_or_create!(data.as_json(except: :default))
      end
    end
  end
end
