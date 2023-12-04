# frozen_string_literal: true

module Menu
  class SearchCategories < ActiveInteraction::Base
    record :current_user, class: User
    interface :params, methods: %i[[] merge! fetch each], default: {}

    def execute
      categories = Category.all

      categories = categories.order(:index)

      categories
    end
  end
end
