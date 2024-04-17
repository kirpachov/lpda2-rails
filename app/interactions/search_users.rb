# frozen_string_literal: true

# Filter User records.
class SearchUsers < ActiveInteraction::Base
  record :current_user, class: User
  interface :params, methods: %i[[] merge! fetch each has_key?], default: {}

  def execute
    items = User.visible

    if params[:query].present?
      items = items.where("email ILIKE :query OR fullname ILIKE :query OR username ILIKE :query", query: "%#{params[:query]}%")
    end

    # Filter by any of the following keys:
    %w[id email status username].each do |key|
      if params[key].present? && (params[key].is_a?(String) || params[key].is_a?(Numeric))
        items = items.where(key => params[key])
      end
    end

    order_by = %w[id email status username updated_at created_at] & params[:order_by].to_s.split(",")
    items = items.order(order_by.join(",")) unless order_by.empty?

    items
  end
end
