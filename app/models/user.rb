# frozen_string_literal: true

# Users of the application.
class User < ApplicationRecord
  has_secure_password

  # ################################
  # Validations
  # ################################
  validates :email, presence: true, format: { with: /\A[^@\s]+@[^@\s]+\z/, message: 'is not a valid email' }, uniqueness: { case_sensitive: false }
  validates :username, presence: false, uniqueness: { case_sensitive: false, allow_blank: true }

  # ################################
  # Callbacks
  # ################################
  before_validation :assign_password_if_missing
  after_create :create_missing_preferences

  # ################################
  # Associations
  # ################################
  has_many :preferences, dependent: :destroy

  # ################################
  # Instance methods
  # ################################
  def create_missing_preferences
    Preference.create_missing_for(self)
  end

  def preference(key)
    preferences.where(key: key).first
  end

  def preference_value(key)
    preference(key)&.value || Preference.default(key)
  end

  def preferences_hash
    preferences.map { |p| [p.key, (p.value || Preference.default(k.key))] }.to_h
  end

  private

  def assign_password_if_missing
    self.password = SecureRandom.hex(16) if password.blank?
  end
end
