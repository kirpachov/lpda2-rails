# frozen_string_literal: true

module Log
  class ImagePixelEvent < ApplicationRecord
    # ################################
    # Associations
    # ################################
    # belongs_to :pixel, class_name: 'Log::ImagePixel', optional: false, inverse_of: :events, foreign_key: 'pixel_id'
    belongs_to :image_pixel, class_name: 'Log::ImagePixel', optional: false
  end
end
