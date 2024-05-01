# frozen_string_literal: true

# Model that will hold tokens for reset password. Only one token per user is allowed.
class ResetPasswordSecret < ApplicationRecord

  # ################################
  # Associations
  # ################################
  belongs_to :user

  # ################################
  # Validations
  # ################################
  validates :secret, presence: true, uniqueness: true

  # ################################
  # Hooks / Callbacks
  # ################################
  before_validation :generate_secret, on: :create

  after_create :delete_other_secrets_for_user

  # ################################
  # Scopes
  # ################################
  scope :not_expired, -> { where('expires_at > ?', Time.zone.now) }
  scope :expired, -> { where('expires_at < ?', Time.zone.now) }

  # ################################
  # Class methods
  # ################################
  class << self
    def delete_expired_secrets
      ResetPasswordSecret.expired.delete_all
    end
  end

  # ################################
  # Instance methods
  # ################################
  def generate_secret
    self.secret ||= GenToken.for!(
      ResetPasswordSecret,
      'secret',
      token_generator: -> { SecureRandom.urlsafe_base64(32) }
    )
  end

  def expire!
    update!(expires_at: 1.minute.ago)
  end
  alias_method :expired!, :expire!

  def expired?
    expires_at < Time.zone.now
  end

  def delete_other_secrets_for_user
    ResetPasswordSecret.where(user_id:).where.not(id:).delete_all
  end
end
