# frozen_string_literal: true

class ApplicationController < ActionController::API
  before_action :authenticate_user

  attr_reader :current_user

  def authenticate_user
    @current_user = Auth::AuthorizeApiRequest.run(headers: request.headers).result
    render_unauthorized unless @current_user
  end

  def render_unauthorized
    render_error status: 401, message: 'Unauthorized'
  end

  def render_error(status: nil, message: nil, details: {})
    render json: { message:, details: }, status:
  end

  def pagination_params
    page = params[:offset] ? params[:offset].to_i + 1 : params[:page]

    {
      page: page || 1,
      per_page: params[:per_page] || 10
    }
  end

  def json_metadata(resources)
    {
      current_page: resources.current_page,
      per_page: resources.per_page,
      prev_page: resources.previous_page,
      next_page: resources.next_page,
      total_pages: resources.total_pages,
      total_count: resources.total_entries
    }.merge(
      params: params.except(:controller, :action, :format, :page, :per_page, :offset).permit!.to_h.transform_values do |value|
        next value.to_i if value.is_a?(String) && value.match?(/^\d+$/) && value.to_i.to_s == value

        value
      end
    )
  end
end
