# frozen_string_literal: true

# Given a hash of params, try to export valid array of ids.
# Usage:
#   ParseIdsParams.run!(params: params, variants: [:dish_ids, :dish_id, :dish_ids, :dishes, :dish])
class ParseIdsParams < ActiveInteraction::Base
  interface :params, methods: %i[to_h merge]

  array :variants

  def execute
    ids = nil

    variants.each do |variant|
      ids ||= params[variant] if params[variant].present?
    end

    ids = ids.split(",") if ids.is_a?(String)

    ids = ids.map(&:to_i) if ids.is_a?(Array)

    ids
  end
end
