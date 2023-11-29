# frozen_string_literal: true

class GenerateImageVariants < ActiveInteraction::Base
  object :image, class: Image

  validate :image_has_attached_image
  validate :image_must_be_original
  validate :image_must_be_persisted

  def execute
    # image.attached_image.variant(resize: '100x100').processed

    if image.children.where(tag: 'blur').empty?
      Image.create!(original: image, filename: filename_with(image.filename, 'blur'), tag: "blur").tap do |blur_image|
        blur_image.attached_image.attach(io: blur, filename: filename_with(image.filename, 'blur'))
      end
    end
  end

  def blur
    # .saver(quality: 1)
    ImageProcessing::Vips.source(image.file).resize_to_limit(50, 50).call
  end

  private

  def filename(full)
    full.split('.')[0..-2].join('.')
  end

  def filename_with(full, suffix)
    "#{filename(full)}_#{suffix}.#{extension(full)}"
  end

  def extension(full)
    full.split('.')[-1]
  end

  def image_must_be_persisted
    errors.add(:image, 'must be persisted') unless image.persisted?
  end

  def image_has_attached_image
    return if image.attached_image.attached? && image.attached_image.image?

    errors.add(:image, 'must have an attached image')
  end

  def image_must_be_original
    errors.add(:image, 'must be original') unless image.is_original?
  end
end
