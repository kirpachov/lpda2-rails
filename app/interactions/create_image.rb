# frozen_string_literal: true

# Create an Image from controller. Can associate to record by providing record_type and record_id.
class CreateImage < ActiveInteraction::Base
  interface :params, methods: %i[[] merge! fetch each has_key?], default: {}

  validate :record
  validate :image_param

  def execute
    Image.transaction do
      @image = Image.create_from_param!(image_param)
      assign_to_record if record?
    end

    @image
  end

  def assign_to_record
    if record.respond_to?(:image=)
      record.image = @image
      record.save!
      return
    end

    if record.respond_to?(:images) && record.images && record.images.respond_to?(:<<)
      record.images << @image
      record.save!
      return
    end

    errors.add(:base, "record does not have #image= or #images<< method")
  end

  def record?
    record != nil
  end

  def record_type
    params[:record_type].gsub(/\s+/, "").split("::").map(&:capitalize).join("::").constantize
  end

  def record
    return @record if defined?(@record)

    unless params[:record_type].is_a?(String) && params[:record_type].present? && params[:record_id].to_i.positive?
      return
    end

    @record = record_type.find(params[:record_id])
  rescue NameError
    errors.add(:record_type, "invalid")
    nil
  end

  def image_param
    return @image_param if defined?(@image_param)

    %i[image file image_file].each do |key|
      next unless params.has_key?(key)

      return @image_param = params[key] if params[key].is_a?(ActionDispatch::Http::UploadedFile)
    end

    errors.add(:image,
               "Missing valid image param. Looking for :image, :file or :image_file of type ActionDispatch::Http::UploadedFile")
  end
end
