# frozen_string_literal: true

module HasImageAttached
  extend ActiveSupport::Concern

  included do
    has_one :image_to_record, class_name: 'ImageToRecord', as: :record, dependent: :destroy
    has_one :image, class_name: 'Image', through: :image_to_record
  end
end