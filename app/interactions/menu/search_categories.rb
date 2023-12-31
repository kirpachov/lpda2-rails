# frozen_string_literal: true

module Menu
  class SearchCategories < ActiveInteraction::Base
    record :current_user, class: User
    interface :params, methods: %i[[] merge! fetch each has_key?], default: {}

    def execute
      categories = Category.all

      if params.has_key?(:parent_id)
        categories = categories.where(parent_id: params[:parent_id].present? ? params[:parent_id] : nil)
      end

      if params[:query].present? && params[:query].is_a?(String)
        categories = categories.where(id: Category.filter_by_query(params[:query]).select(:id))
      end

      if params[:fixed_price].present?
        value = params[:fixed_price].to_s.downcase == 'true'
        categories = value ? categories.with_fixed_price : categories.without_fixed_price
      end

      categories = categories.order(:index)

      categories
    end
  end
end
