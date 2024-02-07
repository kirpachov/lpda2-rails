# frozen_string_literal: true

module Menu
  class SearchTags < ActiveInteraction::Base
    record :current_user, class: User
    interface :params, methods: %i[[] merge! fetch each has_key?], default: {}

    def execute
      filter_by_query(
        filter_by_description(
          filter_by_name(
            filter_by_status(items)
          )
        )
      )
    end

    private

    def items
      Tag.visible
    end

    def filter_by_name(items)
      return items unless params.has_key?(:name)

      items.where_name(params[:name].to_s)
    end

    def filter_by_description(items)
      return items unless params.has_key?(:description)

      items.where_description(params[:description].to_s)
    end

    def filter_by_status(items)
      return items unless params.has_key?(:status)

      items.where(status: params[:status])
    end

    def filter_by_query(items)
      return items unless params.has_key?(:query)

      items.filter_by_query(params[:query])
    end
  end
end
