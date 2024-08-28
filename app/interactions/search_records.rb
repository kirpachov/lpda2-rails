# frozen_string_literal: true

# Common class for searching libraries using user-provided params.
class SearchRecords < ActiveInteraction::Base
  interface :params, methods: %i[[] merge! fetch each has_key?], default: {}

  def param_true?(*param_names)
    param_names.flatten.any? do |param_name|
      params[param_name].to_s.downcase.in?(%w[true 1 yes t])
    end
  end

  def param_false?(*param_names)
    param_names.flatten.any? do |param_name|
      params[param_name].to_s.downcase.in?(%w[false 0 no f])
    end
  end
end
