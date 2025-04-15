# frozen_string_literal: true

# Query TableTypes
class SearchTableTypes < ActiveInteraction::Base
  interface :params, methods: %i[[] merge! fetch each has_key?], default: {}

  def execute
    items = TableType.visible

    items = items.filter_by_query(params[:query]) if params[:query].present?

    items
  end
end
