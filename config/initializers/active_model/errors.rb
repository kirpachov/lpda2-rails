# frozen_string_literal: true

module ActiveModel
  # Opening ActiveModel::Errors to add a function
  class Errors
    def full_json(*args)
      result = errors.map { |er| [er.attribute, []] }.to_h

      errors.each do |er|
        result[er.attribute] << er.full_json(*args)
      end

      result
    end
  end
end
