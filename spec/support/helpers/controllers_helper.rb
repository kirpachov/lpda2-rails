# frozen_string_literal: true

# Implements some custom helper methods for controllers specs.
module ControllersHelper
  def json
    JSON.parse(response.body).with_indifferent_access
  end
end
