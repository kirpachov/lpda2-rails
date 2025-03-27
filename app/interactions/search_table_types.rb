# frozen_string_literal: true

# Query TableTypes
class SearchTableTypes < ActiveInteraction::Base
  interface :params, methods: %i[[] merge! fetch each has_key?], default: {}

  def execute
    items = TableType.all

    if params[:query].present?
      items = items.where(
        id: ransack(name_cont: params[:query]).result.select(:id)
      ).or(
        items.where(
          id: ransack(description_cont: params[:query]).result.select(:id)
        )
      )
    end

    items
  end
end
