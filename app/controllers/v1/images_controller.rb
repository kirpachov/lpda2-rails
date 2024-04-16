# frozen_string_literal: true

module V1
  class ImagesController < ApplicationController
    before_action :find_item, only: %i[download download_variant show remove_from_record]
    before_action :find_item_by_key, only: %i[download_by_key]
    before_action :find_pixel_by_secret, only: %i[download_by_pixel_secret]
    before_action :find_variant, only: %i[download_variant]
    before_action :record, only: %i[update_record remove_from_record]
    skip_before_action :authenticate_user

    def index
      call = ::SearchImages.run(params:)
      unless call.valid?
        return render_error(status: 400, details: call.errors.as_json,
                            message: call.errors.full_messages.join(", "))
      end

      items = call.result.paginate(pagination_params)

      render json: {
        items: full_json(items),
        metadata: json_metadata(items)
      }
    end

    def show
      render json: {
        item: full_json(@image)
      }
    end

    def remove_from_record
      if record.respond_to?(:images)
        record.images.delete(@image)
        return render json: { image_ids: record.reload.images.pluck(:id) }
      end

      # TODO: manage case of single image.
      raise "unimplemented."
    end

    # Update images associated to some record.
    def update_record
      if record.respond_to?(:images)
        Image.transaction do
          record.images = []

          if params[:image_ids].is_a?(Array)
            params[:image_ids].each do |img_id|
              record.images << Image.visible.find(img_id)
            end
          end
        end
      elsif record.respond_to?(:image)
        # TODO: manage case of single image.
        raise "unimplemented."
        # record.image = params[:image_id].present? ? Image.where(id: params[:image_id].to_i) : nil
      else
        return render_error(status: 400, message: "record does not support #images or #image.")
      end

      render json: { record_type: record.class.name, record_id: params[:record_id].to_i,
                     image_ids: record.reload.images.pluck(:id) }
    end

    def create
      @call = ::CreateImage.run(params:)
      @image = @call.result

      return show if @call.valid? && @call.result.valid? && @call.result.persisted?

      render_unprocessable_entity(@call)
    end

    def download
      serve_image @image
    end

    def download_variant
      serve_image @variant
    end

    def download_by_key
      serve_image @image
    end

    def download_by_pixel_secret
      serve_image @image
    end

    private

    def record
      @record ||= record_type.constantize.find(params[:record_id])
    rescue ActiveRecord::RecordNotFound, NameError
      render_error(status: 404,
                   message: I18n.t("record_not_found", model: params[:record_type].to_s,
                                                       id: params[:record_id].inspect))
    end

    def record_type
      params[:record_type].to_s.gsub(/\s+/, "").split("::").map(&:capitalize).join("::")
    end

    def serve_image(image)
      return render_error(status: 500, message: "attached_image is missing") unless image.attached_image.present?

      send_data image.download, type: image.content_type, disposition: "inline"
    rescue ActiveStorage::FileNotFoundError, ActiveStorage::IntegrityError
      render_error(status: 500, message: "Error on download")
    end

    def find_item
      @image = Image.visible.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render_error(status: 404, message: "#{I18n.t("record_not_found", model: Image, id: params[:id].inspect)}")
    end

    def find_item_by_key
      @image = Image.visible.find_by!(key: params[:key])
    rescue ActiveRecord::RecordNotFound
      render_error(status: 404,
                   message: "#{I18n.t("record_not_found_by", model: Image, attribute: :key,
                                                             value: params[:key].inspect)}")
    end

    def find_pixel_by_secret
      @pixel = Log::ImagePixel.find_by!(secret: params[:secret])
      @pixel.events.create!(event_data: { ip: request.remote_ip }, event_time: Time.now)
      @image = Image.find(@pixel.image_id)
    rescue ActiveRecord::RecordNotFound
      render_error(status: 404,
                   message: "#{I18n.t("record_not_found", model: Log::ImagePixel,
                                                          id: params[:key].inspect)}")
    end

    def find_variant
      @variant = @image.find_variant!(params[:variant].to_s)
    rescue ActiveRecord::RecordNotFound
      render_error(status: 404,
                   message: "#{I18n.t("record_not_found", model: Image,
                                                          id: params[:id].inspect)}#{params[:variant].present? ? " with variant #{params[:variant].inspect}" : ""}")
    end

    def full_json(item_or_items)
      return item_or_items.map { |item| full_json(item) } if item_or_items.is_a?(ActiveRecord::Relation)

      return single_item_full_json(item_or_items) if item_or_items.is_a?(::Image)

      raise ArgumentError, "Invalid params. Image or ActiveRecord::Relation expected, but #{item_or_items.class} given"
    end

    def single_item_full_json(item)
      item.as_json(methods: %i[url])
    end
  end
end
