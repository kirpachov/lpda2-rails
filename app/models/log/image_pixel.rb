# frozen_string_literal: true

module Log
  class ImagePixel < ApplicationRecord
    enum event_type: {
      email_open: "email_open"
    }

    # ################################
    # Associations
    # ################################
    belongs_to :image, class_name: "Image", optional: false
    belongs_to :record, polymorphic: true, optional: false
    has_many :events, class_name: "Log::ImagePixelEvent", dependent: :destroy, inverse_of: :image_pixel
    belongs_to :delivered_email, class_name: "Log::DeliveredEmail", optional: false

    # ################################
    # Validations
    # ################################
    validates :event_type, presence: true, inclusion: { in: event_types.keys }
    validates :secret, presence: true, uniqueness: true

    # ################################
    # Hooks
    # ################################
    after_initialize do
      self.secret ||= GenToken.for!(self.class, :secret)
    end

    # ################################
    # Instance methods
    # ################################
    def event_type=(value)
      super
    rescue ArgumentError
      @attributes.write_cast_value("event_type", value)
    end

    def url
      return nil if secret.blank?

      Rails.application.routes.url_helpers.download_by_pixel_secret_images_url(secret:)
    end
  end
end
