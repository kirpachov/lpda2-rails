# frozen_string_literal: true

# Users of the application.
class User < ApplicationRecord
  # ################################
  # Constants, settings, modules, et...
  # ################################
  has_secure_password
  VALID_STATUSES = %w[active deleted].freeze

  enum status: VALID_STATUSES.map { |s| [s, s] }.to_h

  # ################################
  # Validations
  # ################################
  validates :email, presence: true, format: { with: /\A[^@\s]+@[^@\s]+\z/, message: 'is not a valid email' },
                    uniqueness: { case_sensitive: false }
  validates :username, presence: false, uniqueness: { case_sensitive: false, allow_blank: true }
  validates :status, presence: true, inclusion: { in: VALID_STATUSES }

  # ################################
  # Callbacks
  # ################################
  before_validation :assign_password_if_missing, on: :create
  before_validation :assign_defaults, on: :create
  after_create :create_missing_preferences

  # ################################
  # Associations
  # ################################
  has_many :preferences, dependent: :destroy
  has_many :refresh_tokens, dependent: :destroy

  # ################################
  # Instance methods
  # ################################
  def assign_defaults
    self.status = 'active' if status.blank?
  end

  def status=(value)
    super
  rescue ArgumentError
    @attributes.write_cast_value('status', value)
  end

  def create_missing_preferences
    Preference.create_missing_for(self)
  end

  def temporarily_block!
    update!(locked_at: Time.now)
  end

  def blocked?
    temporarily_blocked? || deleted?
  end

  # Check if user is temporarily blocked
  def temporarily_blocked?
    locked_at.present? and (locked_at.to_i + Rails.configuration.app[:temporary_block_duration] > Time.now.to_i)
  end

  def generate_refresh_token
    return errors.add(:base, 'must be persisted') unless persisted?

    RefreshToken.generate_for(id)
  end

  def preference(key)
    preferences.where(key:).first
  end

  def preference_value(key)
    preference(key)&.value || Preference.default(key)
  end

  def preferences_hash
    preferences.map { |p| [p.key, p.value || Preference.default(p.key)] }.to_h
  end

  private

  def assign_password_if_missing
    self.password = SecureRandom.hex(16) if password.blank?
  end
end
