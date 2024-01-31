# frozen_string_literal: true

module HasImagesAttached
  extend ActiveSupport::Concern

  included do
    has_many :image_to_records, class_name: 'ImageToRecord', as: :record, dependent: :destroy
    has_many :images, class_name: 'Image', through: :image_to_records
  end
end