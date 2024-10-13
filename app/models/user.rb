# frozen_string_literal: true

# Users of the application.
class User < ApplicationRecord
  # ################################
  # Modules
  # ################################
  include TrackModelChanges

  # ################################
  # Constants, settings, modules, etc...
  # ################################
  DEFAULT_CAN_ROOT = false
  has_secure_password
  VALID_STATUSES = %w[active inactive deleted].freeze

  enum status: VALID_STATUSES.to_h { |s| [s, s] }

  # ################################
  # Validations
  # ################################
  validates :email, presence: true, format: { with: /\A[^@\s]+@[^@\s]+\z/, message: I18n.t("activerecord.errors.messages.not_a_valid_email") },
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
  has_many :reset_password_secrets, -> { not_expired }, dependent: :destroy, inverse_of: :user

  # ################################
  # Scopes
  # ################################
  scope :visible, -> { where.not(status: "deleted") }
  scope :root, lambda {
                 where(can_root: true).where.not(root_at: nil).where("root_at > ?", Time.current - Config.app[:root_duration])
               }

  # ################################
  # Instance methods
  # ################################
  def assign_defaults
    self.status = "active" if status.blank?
    assign_default_can_root if can_root.nil?
    generate_otp_key if otp_key.blank?
  end

  def otp_generator(context: nil, issuer: nil)
    key = ROTP::Base32.encode("#{otp_key}#{context ? ":#{context}" : ""}")
    ROTP::TOTP.new(key, issuer: issuer || Config.app[:app_name])
  end

  def otp_key=(value)
    self.enc_otp_key = crypt.encrypt_and_sign(value)
  end

  def otp_key
    return nil if enc_otp_key.blank?

    crypt.decrypt_and_verify(enc_otp_key)
  end

  def send_reset_password_email
    UserMailer.with(user_id: id, token: create_reset_password.secret).reset_password.deliver_later
  end

  def create_reset_password
    ResetPasswordSecret.create!(user: self)
  end

  def root?
    return false unless can_root?
    return false if root_at.blank?

    root_at + Config.app[:root_duration] > Time.current
  end

  def root!
    can_root? && update!(root_at: Time.current)
  end

  def status=(value)
    super
  rescue ArgumentError
    @attributes.write_cast_value("status", value)
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
    return errors.add(:base, "must be persisted") unless persisted?

    RefreshToken.generate_for(id)
  end

  def preference(key)
    preferences.where(key:).first
  end

  def preference_value(key)
    preference(key)&.value || Preference.default(key)
  end

  def preferences_hash
    preferences.to_h { |p| [p.key, p.value || Preference.default(p.key)] }
  end

  def as_json(options = {})
    super(options.merge(except: %i[password_digest enc_otp_key]))
  end

  private

  # TODO this should not be here.
  def crypt
    @crypt ||= ActiveSupport::MessageEncryptor.new(Config.hash[:secret_key_base].to_s[0..31])
  end

  def assign_password_if_missing
    self.password = SecureRandom.hex(16) if password.blank?
  end

  def assign_default_can_root
    self.can_root = DEFAULT_CAN_ROOT
  end

  def generate_otp_key
    self.otp_key = SecureRandom.hex(16)
  end
end
