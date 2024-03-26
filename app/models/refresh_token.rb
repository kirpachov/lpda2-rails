# frozen_string_literal: true

class RefreshToken < ApplicationRecord
  # ################################
  # Constants, settings, modules, et...
  # ################################
  DEFAULT_EXPIRATION_TIME = 1.week.freeze

  # ################################
  # Associations
  # ################################
  belongs_to :user, optional: false

  # ################################
  # Validations
  # ################################
  validates :secret, presence: true, uniqueness: true
  validates :expires_at, presence: true

  # ################################
  # Callbacks
  # ################################
  before_validation :assign_defaults, on: :create

  # ################################
  # Scopes
  # ################################
  scope :expired, -> { where('expires_at < ?', Time.now) }
  scope :not_expired, -> { where('expires_at >= ?', Time.now) }

  # ################################
  # Class methods
  # ################################
  class << self
    def generate_for(user_or_its_id)
      unless user_or_its_id.is_a?(User) || user_or_its_id.is_a?(Integer)
        raise ArgumentError,
              'user_or_its_id must be a User or an Integer'
      end

      user_id = user_or_its_id.is_a?(User) ? user_or_its_id.id : user_or_its_id
      refresh_token = RefreshToken.new(user_id:, expires_at: DEFAULT_EXPIRATION_TIME.from_now)
      refresh_token.save

      refresh_token
    end
  end

  # ################################
  # Instance methods
  # ################################
  def assign_defaults
    generate_secret! if secret.blank?
  end

  def refresh_secret_and_expiration!
    generate_secret!

    self.expires_at = DEFAULT_EXPIRATION_TIME.from_now

    self
  end

  def generate_jwt
    Auth::JsonWebToken.encode_refresh_token_data(self)
  end

  def generate_secret!
    self.secret = GenToken.for!(self.class, :secret)
  end

  def expired?
    expires_at < Time.now
  end

  def not_expired?
    !expired?
  end

  def expire!
    update(expires_at: Time.now)
  end

  alias expired! expire!
end
