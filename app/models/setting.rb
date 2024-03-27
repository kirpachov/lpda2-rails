# frozen_string_literal: true

# App-level settings are stored in the database.
# Some of the settings may require root mode to change.
class Setting < ApplicationRecord
  # ################################
  # Validations
  # ################################
  validates_with KeyValueValidator
  validates :key, presence: true
  validates :key, uniqueness: { case_sensitive: false }
  validates :key, inclusion: { in: DEFAULTS.keys.map(&:to_s) + DEFAULTS.keys.map(&:to_sym) }
  validates :parser, inclusion: { in: %w[json], allow_nil: true }

  # ##############################
  # Class methods
  # ##############################
  class << self
    def all_hash
      DEFAULTS.keys.index_with { |key| self[key] }.with_indifferent_access
    end

    def default(key)
      DEFAULTS[key]&.[](:default)
    end

    def [](key)
      where(key:).first&.value || default(key)
    end

    def create_missing
      DEFAULTS.each do |key, data|
        data[:value] ||= data[:default]
        where(key:).first_or_create!(data.as_json(except: :default))
      end
    end
  end

  # ##############################
  # Instance methods
  # ##############################
  def value
    val = super
    val = parse_json(val).with_indifferent_access if parser.to_s == 'json'

    val
  end

  def value=(val)
    val = val.to_json if parser.to_s == 'json' && val.is_a?(Hash)

    super(val)
  end

  def parse_json(value)
    return {} if value.nil?

    JSON.parse(value)
  rescue JSON::ParserError => e
    msg = "Error parsing Setting[#{key}] as JSON: #{e.message}"
    Rails.logger.error msg
    puts msg

    {}
  end
end
