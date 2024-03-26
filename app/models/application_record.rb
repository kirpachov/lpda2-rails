# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  class << self
    def log_table_info(args = {})
      puts TableInfo.run!(args.merge(model: self))
    end

    def ransackable_attributes(_auth_object = nil)
      return [] unless respond_to?(:mobility_attributes)

      mobility_attributes
    end
  end

  def translations_json
    res = {}
    text_translations.map do |text_translation|
      res[text_translation.key] ||= {}
      res[text_translation.key][text_translation.locale] = text_translation.value
    end

    res
  end

  def assign_translation(attribute, value, args = {})
    value = JSON.parse(value) if value.is_a?(String) && value.valid_json?

    errors.merge!(AssignTranslation.run(args.merge(record: self, attribute:, value:)))
    self
  end
end
