# frozen_string_literal: true

class ApplicationController < ActionController::API
  include ActionController::Cookies

  before_action :authenticate_user, except: %i[welcome render_endpoint_not_found]
  before_action :set_locale

  attr_reader :current_user

  def authenticate_user
    try_authenticate_user
    render_unauthorized unless @current_user
  end

  def clear_cache
    Rails.cache.clear
  end

  def cache_action_response(&block)
    # Something like: "GET:v1/reservations#valid_dates"
    key = "#{request.method}:#{request.params["controller"]}##{request.params["action"]}"
    cache_params = params.permit!.to_h.merge(
      locale: detect_current_locale
    )

    cache_params_key = Digest::SHA1.hexdigest("#{cache_params.merge(
      invalidate: Time.zone.now.strftime("%Y-%m-%d %k:%M")
    ).to_hash}")

    Rails.cache.fetch("#{cache_params_key}#{key}") do
      Rails.logger.info("Calculating cache for #{key}: #{cache_params_key}, #{cache_params.inspect}")
      Rails.cache.delete_matched(key)
      yield
      # block.call
    end
  rescue Errno::ENOENT => e
    Rails.cache.clear
    Rails.logger.error("Error on cache_action_response: #{e.message}")
    yield
  end

  def require_root
    return if current_user.blank? || current_user.root?

    render_error(
      status: :forbidden,
      message: I18n.t("errors.messages.root_required"),
      details: {
        root_required: true,
        can_root: current_user.can_root?,
        root_at: current_user.root_at
      }
    )
  end

  def render_endpoint_not_found
    render json: {
      message: "Endpoint not found"
    }, status: :not_found
  end

  def welcome
    render json: { message: "Welcome to #{Config.app[:app_name]} API!" }
  end

  def try_authenticate_user
    @current_user = Auth::AuthorizeApiRequest.run(headers: request.headers).result
  end

  def render_unauthorized
    render_error status: 401, message: "Unauthorized" # TODO: TRANSLATE THIS
  end

  def render_unprocessable_entity(record)
    render_error status: 422, message: record.errors.full_messages.join(", "), details: record.errors.full_json
  end

  def render_error(status: nil, message: nil, details: {})
    render json: { message:, details: }, status:
  end

  # Will try to assign the provided image to the record. Returns true if success.
  def assign_image_from_param(record, param)
    if param.blank? || param == "null"
      record.image_to_record.destroy! if record.image_to_record
      return true
    end

    if param.is_a?(ActionDispatch::Http::UploadedFile)
      record.image = Image.create_from_param!(param)
      return true
    end

    render_error(status: 400, message: "Invalid image param")
    false
  end

  def pagination_params
    page = params[:offset] ? params[:offset].to_i + 1 : params[:page]

    {
      page: page || 1,
      per_page: params[:per_page] || 10
    }
  end

  def set_locale
    # TODO: read current user preferences. (if current user is present)
    I18n.locale = detect_current_locale || I18n.default_locale
  end

  def detect_current_locale
    locale = params[:locale] || params[:lang] || request.headers["Accept-Language"]
    return unless I18n.available_locales.include?(locale&.to_sym)

    locale
  end

  def json_metadata(resources)
    {
      offset: resources.current_page - 1,
      current_page: resources.current_page,
      per_page: resources.per_page,
      prev_page: resources.previous_page,
      next_page: resources.next_page,
      total_pages: resources.total_pages,
      total_count: resources.total_entries
    }.merge(
      params: params.except(:controller, :action, :format, :page, :per_page,
                            :offset).permit!.to_h.transform_values do |value|
                next value.to_i if value.is_a?(String) && value.match?(/^\d+$/) && value.to_i.to_s == value
                next true if value.is_a?(String) && value == "true"
                next false if value.is_a?(String) && value == "false"

                value
              end
    )
  end
end
