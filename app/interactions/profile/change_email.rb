# frozen_string_literal: true

module Profile
  # Change the user's email address and send a notification to the old email address
  class ChangeEmail < ActiveInteraction::Base
    object :user
    string :email
    string :otp

    validates :user, presence: true
    validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :otp, presence: true, format: { with: /\A\d{6}\z/ }
    validate :email_unique?
    validate :same_email?

    set_callback :validate, :before do
      self.email = email&.downcase&.strip
    end

    def execute
      return unless otp_valid?

      update_email!
      send_email_updated!
      # user.events << User::Event.new(event_type: :email_changed, data: { old_email: @old_email, new_email: user.email })
    end

    def otp_valid?
      generator = user.otp_generator(context: email)
      errors.add(:otp, :invalid) unless generator.verify(otp, drift_behind: 900)
      errors.empty?
    end

    def same_email?
      errors.add(:email, :not_changed) if user.email == email

      errors.empty?
    end

    def email_unique?
      taken = User.not_deleted.where.not(id: user.id).exists?(email:)

      errors.add(:email, :taken) if taken

      errors.empty?
    end

    def update_email!
      @old_email = user.email
      user.update!(email:)
    end

    def send_email_updated!
      @mail = UserMailer.with(user_id: user&.id, old_email: @old_email).email_updated
      @mail.deliver_later
    end
  end
end
