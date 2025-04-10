# frozen_string_literal: true

# Query TableTypes
class SearchTableTypes < ActiveInteraction::Base
  interface :params, methods: %i[[] merge! fetch each has_key?], default: {}

  def execute
    items = TableType.visible

    if params[:query].present?
      items = items.filter_by_query(params[:query])
    end

    items
  end
end
