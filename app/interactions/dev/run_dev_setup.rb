# frozen_string_literal: true

module Dev
  # Run this after importing locally production database, to avoid sending emails to real users
  # but still be able to test with real data.
  # Run in console with:
  # Dev::RunDevSetup.run!
  class RunDevSetup < ActiveInteraction::Base
    def execute
      return if Rails.env.production?

      Rails.logger.silence do
        puts "Running dev setup"
        puts "-----------------"
        users_passwords

        puts "Deleting all blobs"
        DeleteAllBlobs.run!

        puts "Upating all emails to some safe email (see config/app.yml or config/app.example.yml, 'developers_emails')"
        UpdateAllEmailsToSafeEmail.run!
      end
    end

    private

    def users_passwords
      puts "Updating all user's passwords to 'admin'"
      User.all.map { |user| user.update(password: "admin") }
    end
  end
end
