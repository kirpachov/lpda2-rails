# frozen_string_literal: true

module Menu
  class SearchCategories < SearchRecords
    interface :all, methods: %i[visible without_parent], default: -> { Category.all }

    # when true, only public categories will be returned
    boolean :public, default: false

    def execute
      categories = all.visible

      if public
        categories = categories.active

        categories = categories.public_visible.or(
          categories.private_visible.where(secret: ids)
        ).or(
          categories.where(
            root_id: Category.visible.root.public_or_private_visible.select(:id)
          )
        )
      end

      return categories if categories.empty?

      categories = categories.without_parent.public_visible if param_true?(:root, :without_parent, :root_only)

      if param_true?(:skip_empty_categories)
        categories = categories.having_public_dishes.or(categories.having_non_empty_children)
      end

      categories = categories.having_public_dishes if param_true?(:skip_categories_without_dishes)

      if ids.present?
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

    private

    def ids
      return @ids if defined?(@ids)

      @ids = params[:id].presence || params[:ids].presence || params[:secret] || params[:secrets]
      @ids = @ids.split(",") if @ids.is_a?(String)

      @ids
    end
  end
end
