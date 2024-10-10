# frozen_string_literal: true

module Profile
  # Send an OTP code to the user's email address, so we can verify if this email
  class SendEmailVerificationOtp < ActiveInteraction::Base
    object :user
    string :email

    validates :user, presence: true
    validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
    validate :same_email?
    validate :email_unique?

    set_callback :validate, :before do
      self.email = email&.downcase&.strip
    end

    attr_accessor :otp, :mail

    def execute
      generate_otp!

      @mail = UserMailer.with(user_id: user.id, email:, otp:).email_verification_otp
      @mail.deliver_later

      @mail
    end

    private

    def same_email?
      errors.add(:email, :not_changed) if user.email == email

      errors.empty?
    end

    def email_unique?
      taken = User.not_deleted.where.not(id: user.id).exists?(email:)

      errors.add(:email, :taken) if taken

      errors.empty?
    end

    def generate_otp!
      @otp = user.otp_generator(context: email).now
    end
  end
end
