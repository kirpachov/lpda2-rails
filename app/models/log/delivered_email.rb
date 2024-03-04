# frozen_string_literal: true

module Log
  class DeliveredEmail < ApplicationRecord
    # ################################
    # Associations
    # ################################
    has_many :image_pixels, class_name: 'Log::ImagePixel', foreign_key: 'delivered_email_id'
    has_many :image_pixel_events, through: :image_pixels, class_name: 'Log::ImagePixelEvent'
    belongs_to :record, polymorphic: true, optional: true
  end
end
