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

    # Reservations deleted admin-side
    deleted: 'deleted',

    # People that didn't show up
    noshow: 'noshow',

    # People that cancelled (deleted by user-side)
    cancelled: 'cancelled',
  }

  # ################################
  # Validations
  # ################################
  validates :fullname, presence: true
  validates :datetime, presence: true
  validates :status, presence: true, inclusion: { in: statuses.keys.map(&:to_s) + statuses.keys.map(&:to_sym) }
  validates :secret, presence: true
  validates :people, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, allow_blank: true

  validates_uniqueness_of :secret, case_sensitive: false

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
    @attributes.write_cast_value("status", value)
  end
end
