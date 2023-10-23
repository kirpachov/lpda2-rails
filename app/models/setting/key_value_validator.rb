# frozen_string_literal: true

class Setting
  class KeyValueValidator < ActiveModel::Validator
    attr_accessor :record

    def validate(record)
      @record = record
      return unless can_run?

      case record.key.to_sym
      when :default_language then validate_default_language
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

    def validate_default_language
      return if I18n.available_locales.include?(record.value.to_sym)

      record.errors.add(:value, "#{record.value.to_s.inspect} is not a valid language")
    end
  end
end
