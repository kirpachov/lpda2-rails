# frozen_string_literal: true

class ImageToRecord < ApplicationRecord
  # ##############################
  # Associations
  # ##############################
  belongs_to :image, class_name: 'Image', optional: false
  belongs_to :record, polymorphic: true, optional: false

  validate :image_must_have_attached_image

  validates :image, uniqueness: { scope: :record }

  private

  def image_must_have_attached_image
    return if image.nil? || image.attached_image.attached?

    errors.add(:image, 'must have attached image')
  end
end
