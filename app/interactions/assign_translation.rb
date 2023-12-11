# frozen_string_literal: true

class AssignTranslation < ActiveInteraction::Base
  object :record, class: ApplicationRecord
  string :attribute
  interface :value, methods: Hash.new.methods & String.new.methods & ActionController::Parameters.new.methods, default: nil

  validates :record, presence: true
  validates :attribute, presence: true

  validate :value_is_valid
  validate :attribute_is_translatable

  def execute
    assign_value_hash if value.is_a?(Hash) || value.is_a?(ActionController::Parameters)
    assign_value_string if value.is_a?(String) || value.is_a?(NilClass)
    record
  end

  def assign_value_string
    record.send("#{attribute}=", value.to_s)
  end

  def assign_value_hash
    value.each do |locale, value|
      Mobility.with_locale(locale) do
        record.send("#{attribute}=", value.to_s)
      end
    end
  end

  private

  def attribute_is_translatable
    return if record.class.respond_to?(:mobility_attributes) && record.class.mobility_attributes.include?(attribute.to_s)

    errors.add(:attribute, :not_translatable)
  end

  def value_is_valid
    return if value.is_a?(String) || value.is_a?(NilClass)
    return validate_value_hash if value.is_a?(Hash) || value.is_a?(ActionController::Parameters)

    errors.add(:value, :invalid)
  end

  def validate_value_hash
    value.keys.reject { |locale| I18n.available_locales.include?(locale.to_sym) }.each do |invalid_key|
      errors.add(attribute, I18n.t("errors.messages.invalid_locale", lang: invalid_key))
    end
  end
end