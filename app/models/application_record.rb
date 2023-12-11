# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  class << self
    def log_table_info(args = {})
      puts TableInfo.run!(args.merge(model: self))
    end

    def ransackable_attributes(auth_object = nil)
      return [] unless respond_to?(:mobility_attributes)

      mobility_attributes
    end
  end

  def assign_translation(attribute, value, args = {})
    # validate
    # AssignTranslation.run(args.merge(record: self, attribute:, value:))
    errors.merge!(AssignTranslation.run(args.merge(record: self, attribute:, value:)))
    self
  end
end
