# frozen_string_literal: true

# Generate a unique token for a model field.
class GenToken < ActiveInteraction::Base
  # ###################################
  # Class methods
  # ###################################
  class << self
    def for!(model, field, options = {})
      GenToken.run!(options.merge(model:, field:))
    end
  end

  # ###################################
  # Inputs/Filters
  # ###################################
  object :model, class: Class
  interface :field, methods: [:to_s]
  interface :token_generator, methods: [:call], default: -> { -> { SecureRandom.uuid } }

  # ###################################
  # Validations
  # ###################################
  validate :validate_field

  # ###################################
  # Instance methods
  # ###################################
  def execute
    count = 0
    loop do
      count += 1
      token = new_token
      break token unless model.exists?(field => token)

      break errors.add(:base, 'Too many attempts to generate a unique token.') if count > 10
    end
  end

  def new_token
    return token_generator.call if token_generator.respond_to?(:call)

    SecureRandom.uuid
  end

  # ###################################
  # Private instance methods
  # ###################################
  private

  def validate_field
    return errors.add(:field, 'Must be a string or a symbol.') if field.class != String && field.class != Symbol

    errors.add(:field, "Not in list of columns for #{model}.") unless model.column_names.include?(field.to_s)
  end
end
