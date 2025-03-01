# frozen_string_literal: true

module Menu
  class SearchCategories < SearchRecords
    interface :all, methods: %i[visible without_parent], default: -> { Category.all }

    # when true, only public categories will be returned
    boolean :public, default: false

    def execute
      categories = all.visible
      categories = categories.public_visible if public

      return categories if categories.empty?

      categories = categories.without_parent.public_visible if param_true?(:root, :without_parent, :root_only)

      categories = categories.having_public_dishes.or(categories.having_non_empty_children) if param_true?(:skip_empty_categories)

      categories = categories.having_public_dishes if param_true?(:skip_categories_without_dishes)

      if (ids = params[:id].presence || params[:ids]).present?
        ids = ids.split(",") if ids.is_a?(String)

        categories = categories.where(id: ids.map(&:to_i)).or(
          categories.where(secret: ids)
        )
      end

      # Want to accept:
      # "status"
      # "status1,status2" => will produce status1 OR status2
      # ["status1", "status2"] => will produce status1 OR status2
      # ["status1"] => will produce status1
      if params[:status].present?
        statuses = params[:status].is_a?(String) ? params[:status].split(",") : params[:status]
        categories = categories.where(status: statuses)
      end

      if params[:except].present? && params[:except].is_a?(String)
        categories = categories.where.not(id: params[:except].split(",").map(&:to_i))
      end

      categories = categories.where(parent_id: params[:parent_id].presence) if params.has_key?(:parent_id)

      if params[:query].present? && params[:query].is_a?(String)
        categories = categories.where(id: Category.filter_by_query(params[:query]).select(:id))
      end

      if params[:fixed_price].present?
        value = params[:fixed_price].to_s.downcase == "true"
        categories = value ? categories.with_fixed_price : categories.without_fixed_price
      end

      categories.order(:index)
    end
  end
end
