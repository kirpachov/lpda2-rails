# frozen_string_literal: true

# Convert a string into a ActiveSupport::Duration.
# Example:
#  StringToDuration.run!(string: '1 day')
class StringToDuration < ActiveInteraction::Base
  string :string, default: nil

  def duration
    return unless string

    return number.to_i.send(unit) if unit.present? && number.present? && AVALIABLE_UNITS.include?(unit)

    nil
  end

  def clean_string
    @clean_string ||= string.downcase.strip
  end

  def unit
    clean_string.split(' ').second&.gsub(/\d/, '')
  end

  def number
    clean_string.split(' ').first&.gsub(/\D/, '')
  end

  private

  AVALIABLE_UNITS = %w[seconds second minutes minute hours hour days day weeks week months month years year].freeze

  def validate!
    errors.add(:string, 'is not a string') unless string.is_a?(String)
    errors.add(:number, 'is not a number') unless number.is_a?(String) && number.match?(/\d/)
    errors.add(:unit, 'is not a unit') unless unit.is_a?(String) && AVALIABLE_UNITS.include?(unit)
    errors.add(:string, 'should respect the format: 1 day') unless clean_string.match?(/\A\d+ [a-z]+\z/)
    errors.add(:string, 'should respect the format: 1 day') if clean_string.split(' ').count != 2
  end

  def execute
    validate!

    return nil if errors.any?

    duration
  end
end
