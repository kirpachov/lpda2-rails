# frozen_string_literal: true

module Profile
  # Updates the user's password
  class ChangePassword < ActiveInteraction::Base
    object :user, class: "User"
    string :current_password
    string :new_password

    validates :current_password, :new_password, presence: true
    validates :new_password, length: { minimum: Config.app[:min_password_length].to_i }
    validate :current_password_valid?

    def execute
      return unless update_password!

      UserMailer.with(user_id: user&.id).password_updated.deliver_later

      user
    end

    private

    def current_password_valid?
      errors.add(:current_password, :invalid) unless user.authenticate(current_password)

      errors.empty?
    end

    def update_password!
      user.password = new_password
      errors.add(:user, :invalid, errors: user.errors.full_messages.to_sentence) unless user.save

      errors.empty?
    end
  end
end
