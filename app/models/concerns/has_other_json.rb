# frozen_string_literal: true

# Use this concern in models that have a "other" field that is a JSON
module HasOtherJson
  extend ActiveSupport::Concern

  def update_other(data)
    update(other: merge_other(data))
  end

  def merge_other(new_data)
    raise "Hash expected, got #{new_data.class.inspect}" unless new_data.is_a?(Hash)

    self.other = (other || {}).merge(new_data)
  end

  # def merge_other(new_data)
  #   return other if new_data.nil? || !new_data.is_a?(Hash)
  #   return new_data if other.nil? || !other.is_a?(Hash)
  #
  #   other.merge(new_data)
  # end
end
