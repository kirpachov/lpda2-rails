# frozen_string_literal: true

class Preference
  class KeyValueValidator < ActiveModel::Validator
    attr_accessor :record

    def validate(record)
      @record = record
      return unless can_run?

      case record.key.to_sym
      when :language then validate_language
      when :known_languages then validate_known_languages
      when :timezone then validate_timezone
      else
        record.errors.add(:key, "Unknown key: #{record.key}")
      end
    end

    private

    def can_run?
      return false if record.key.to_s.blank?
      return false if record.value.nil?

      unless [String, Symbol].include?(record.key.class)
        record.errors.add(:value, "should be a string or symbol. got #{record.key.class.inspect}")
        return false
      end

      true
    end

    def validate_language
      return if I18n.available_locales.include?(record.value.to_sym)

      record.errors.add(:value, "#{record.value.to_s.inspect} is not a valid language")
    end

    def validate_known_languages
      array = record.value.to_s.split(",").map(&:strip).map(&:to_sym)
      return if array.all? { |item| I18n.available_locales.include?(item) }

      record.errors.add(:value, "#{record.value.to_s.inspect} contains invalid languages")
    end

    def validate_timezone
      return if ActiveSupport::TimeZone.all.map(&:name).include?(record.value.to_s)

      record.errors.add(:value, "#{record.value.to_s.inspect} is not a valid timezone")
    end
  end
end
