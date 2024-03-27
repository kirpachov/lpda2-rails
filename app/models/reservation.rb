# frozen_string_literal: true

class Reservation < ApplicationRecord
  # ################################
  # Constants, settings, modules, et...
  # ################################
  include HasOtherJson
  include TrackModelChanges

  enum status: {
    # Default status
    active: 'active',

    # People arrived at the restaurant
    arrived: 'arrived',

    # Reservations deleted admin-side
    deleted: 'deleted',

    # People that didn't show up
    noshow: 'noshow',

    # People that cancelled (deleted by user-side)
    cancelled: 'cancelled'
  }

  # ################################
  # Associations
  # ################################
  has_many :tags_in_reservations, class_name: 'TagInReservation', inverse_of: :reservation, dependent: :destroy
  has_many :reservation_tags, through: :tags_in_reservations, class_name: 'ReservationTag'
  has_many :delivered_emails, class_name: 'Log::DeliveredEmail', as: :record
  has_many :image_pixels, class_name: 'Log::ImagePixel', as: :record, dependent: :destroy
  has_many :pixel_events, class_name: 'Log::ImagePixelEvent', through: :image_pixels, source: :events
  # , dependent: :nullify

  alias_attribute :tags, :reservation_tags

  # ################################
  # Validations
  # ################################
  validates :fullname, presence: true
  validates :datetime, presence: true
  validates :status, presence: true, inclusion: { in: statuses.keys.map(&:to_s) + statuses.keys.map(&:to_sym) }
  validates :secret, presence: true
  validates :people, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, allow_blank: true

  validates :secret, uniqueness: { case_sensitive: false }

  # ################################
  # Hooks / Callbacks
  # ################################
  after_initialize do
    self.secret = GenToken.for!(Reservation, :secret) if secret.blank?
    self.status = 'active' if status.blank?
    self.other = {} if other.nil?
  end

  # ################################
  # Scopes
  # ################################
  scope :visible, -> { where.not(status: :deleted) }

  # ################################
  # Instance methods
  # ################################
  def status=(value)
    super
  rescue ArgumentError
    @attributes.write_cast_value('status', value)
  end

  def create_email_pixel(image:, delivered_email:)
    Log::ImagePixel.create!(
      record: self,
      image:,
      delivered_email:,
      event_type: 'email_open'
    )
  end

  def confirmation_email
    image = Image.where("key LIKE 'email_images_%'").first

    delivered_email = Log::DeliveredEmail.create!(record: self)

    ReservationMailer.with(
      reservation: self,
      pixel: image ? { image.key.gsub('email_images_', '') => create_email_pixel(image:, delivered_email:).url } : nil,
      delivered_email:
    ).confirmation
  end

  def deliver_confirmation_email
    confirmation_email.deliver_now
  end

  def deliver_confirmation_email_later
    confirmation_email.deliver_later
  end
end
