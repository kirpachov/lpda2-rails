# frozen_string_literal: true

module Dev
  # Will update all emails to some "safe" email, to avoid sending emails to real users in development.
  class RunDevSetup::UpdateAllEmailsToSafeEmail < ActiveInteraction::Base
    SAFE_EMAIL = Config.app[:developers_emails].first

    def execute
      raise "You are not in development" unless Rails.env.development?

      if SAFE_EMAIL.blank?
        raise "You need to set the developers emails in the config. First email will be the safe email."
      end

      fix_records(User)
      fix_records(Reservation)
    end

    private

    def fix_records(klass, email_column = :email)
      klass.all.find_each do |record|
        next if record.send(email_column).blank?
        next if record.send(email_column).include?(SAFE_EMAIL.split("@").first) && record.send(email_column).include?(SAFE_EMAIL.split("@").last)

        email_was = "#{record.send(email_column).gsub(/[^A-Za-z0-9]+/, "")}#{record.id}"
        record.update(
          email_column => SAFE_EMAIL.split("@").join("+#{email_was}@")
        )
      end
    end
  end
end
