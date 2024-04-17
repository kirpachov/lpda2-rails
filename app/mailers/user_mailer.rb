# frozen_string_literal: true

# Mailer for all notifications related to Users table.
class UserMailer < ApplicationMailer
  def welcome_staffer
    raise ArgumentError, "User is required" unless params[:user].is_a?(User)

    @user = params[:user]

    @set_password_url = "https://some-link-to-reset-password/token=some-token"

    @subject = I18n.t("mail.welcome_staffer_subject", app_name: Config.hash[:app_name])
    mail(to: @user.email, subject: @subject)
  end
end
