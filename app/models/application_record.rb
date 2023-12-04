# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  class << self
    def log_table_info(args = {})
      puts TableInfo.run!(args.merge(model: self))
    end
  end
end
