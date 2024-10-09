# frozen_string_literal: true

class Reservation < ApplicationRecord
  # When some user creates a reservation in the public site, we attach to it a cookie.
  PUBLIC_CREATE_COOKIE = "reservation_created"

  # ################################
  # Constants, settings, modules, et...
  # ################################
  include HasOtherJson
  include TrackModelChanges

  enum status: {
    # Default status
    active: "active",

    # People arrived at the restaurant
    arrived: "arrived",

    # Reservations deleted admin-side
    deleted: "deleted",

    # People that didn't show up
    noshow: "noshow",

    # People that cancelled (deleted by user-side)
    cancelled: "cancelled"
  }

  # ################################
  # Associations
  # ################################
  has_many :tags_in_reservations, class_name: "TagInReservation", inverse_of: :reservation, dependent: :destroy
  has_many :reservation_tags, through: :tags_in_reservations, class_name: "ReservationTag"
  has_many :delivered_emails, class_name: "Log::DeliveredEmail", as: :record
  has_many :image_pixels, class_name: "Log::ImagePixel", as: :record, dependent: :destroy
  has_many :pixel_events, class_name: "Log::ImagePixelEvent", through: :image_pixels, source: :events
  # , dependent: :nullify
  # has_many :nexi_http_requests
  has_one :payment, class_name: "ReservationPayment"

  alias_attribute :tags, :reservation_tags

  # ################################
  # Validations
  # ################################
  validates :fullname, presence: true
  validates :datetime, presence: true
  validates :status, presence: true, inclusion: { in: statuses.keys.map(&:to_s) + statuses.keys.map(&:to_sym) }
  validates :secret, presence: true
  validates :children, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :adults, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, allow_blank: true
  validates :lang, inclusion: (I18n.available_locales.map(&:to_s) + I18n.available_locales.map(&:to_sym))
  validate :validate_people_count_is_valid

  validates :secret, uniqueness: { case_sensitive: false }

  # ################################
  # Hooks / Callbacks
  # ################################
  after_initialize do
    self.secret = GenToken.for!(Reservation, :secret) if secret.blank?
    self.status = "active" if status.blank?
    self.other = {} if other.nil?
  end

  # ################################
  # Scopes
  # ################################
  scope :public_visible, -> { visible.where.not(status: %w[cancelled]) }
  scope :visible, -> { where.not(status: :deleted) }
  scope :next, -> { where("datetime >= ?", Time.zone.now) }

  # ################################
  # Instance methods
  # ################################
  def requires_payment?(options = {})
    @requires_payment ||= required_payment_group(options).present?
  end
  alias_method :payment_required?, :requires_payment?

  def required_payment_value(options = {})
    @required_payment_value ||= required_payment_group(options)&.payment_value
  end

  def required_payment_group(options = {})
    @required_payment_group ||= ReservationRequiresPayment.run!(
      options.merge(reservation: self)
    )
  end

  # Will generate and attach a URL user can open to pay the reservation.
  def create_payment!(options = {})
    Nexi::CreateReservationPayment.run!(
      options.merge(
        reservation: self,
        amount: required_payment_value
      )
    )
  end

  def reservation_turn
    ReservationTurn.for(datetime)
  end
  alias_method :turn, :reservation_turn

  def status=(value)
    super
  rescue ArgumentError
    @attributes.write_cast_value("status", value)
  end

  def people
    children.to_i + adults.to_i
  end

  def create_email_pixel(image:, delivered_email:)
    Log::ImagePixel.create!(
      record: self,
      image:,
      delivered_email:,
      event_type: "email_open"
    )
  end

  def confirmation_email_params
    raise "Must be persisted" unless persisted?

    image = Image.visible.where("key LIKE 'email_images_%'").first

    delivered_email = Log::DeliveredEmail.create!(record: self)

    {
      reservation_id: id,
      pixels: image ? { image.key.gsub("email_images_", "") => create_email_pixel(image:, delivered_email:).id } : nil,
      delivered_email_id: delivered_email.id,
      locale: lang
    }
  end

  def deliver_confirmation_email
    ReservationMailer.with(confirmation_email_params).confirmation.deliver_now
  end

  def deliver_confirmation_email_later
    ReservationMailer.with(confirmation_email_params).confirmation.deliver_later
  end

  def validate_people_count_is_valid
    return if people.positive?

    errors.add(:people, "should be a positive integer")
    errors.add(:adults, "got 0 adults and 0 children")
    errors.add(:children, "got 0 adults and 0 children")
  end
end
