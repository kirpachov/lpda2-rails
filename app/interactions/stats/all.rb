# frozen_string_literal: true

module Stats
  # Can provide:
  # Stats::All.run!(params: { keys: 'status-count' })
  # Stats::All.run!(params: { status-count: true })
  class All < ActiveInteraction::Base
    interface :params, methods: %i[keys []], default: {}
    validate :keys_all_valid?

    VALID_KEYS = %w[reservations-by-hour reservations-count].freeze

    def execute
      keys.index_with { |key| process_key(key) }
    end

    def keys
      return @keys if defined?(@keys)

      @keys = [params[:keys]].flatten.map { |s| s.to_s.split(",") }.flatten
      (params.keys.map(&:to_s) & VALID_KEYS).each { |key| @keys << key }
      @keys = VALID_KEYS if @keys.empty?
      @keys = @keys.map(&:strip).filter(&:present?).uniq
    end

    def process_key(key)
      case key
      when "reservations-by-hour"
        Stats::ReservationsByHour.run!(params:)
      when "reservations-count"
        Stats::ReservationsCount.run!(params:)
      else
        errors.add(:key, "Unknown key #{key}")
      end
    end

    def keys_all_valid?
      return if keys.all? { |key| VALID_KEYS.include?(key.to_s) }

      errors.add(:keys, "must be a subset of #{VALID_KEYS.join(", ")}. got: #{keys.join(", ")}")
    end
  end
end
