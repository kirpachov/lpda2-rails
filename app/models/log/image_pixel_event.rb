# frozen_string_literal: true

module Log
  class ImagePixelEvent < ApplicationRecord
    # ################################
    # Associations
    # ################################
    belongs_to :image_pixel, class_name: 'Log::ImagePixel', optional: false
  end
end
