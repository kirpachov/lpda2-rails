# frozen_string_literal: true

class ImageToRecord < ApplicationRecord
  # ##############################
  # Associations
  # ##############################
  belongs_to :image, class_name: 'Image', optional: false
  belongs_to :record, polymorphic: true, optional: false
end
