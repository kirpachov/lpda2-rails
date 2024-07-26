# frozen_string_literal: true

# Implements some custom helper methods for controllers specs.
module ControllersHelper
  def json
    json = response.body.to_s.valid_json? ? JSON.parse(response.body) : {}
    json.is_a?(Hash) ? json.with_indifferent_access : json
  end
end
