# frozen_string_literal: true

# Mailer for all notifications related to Users table.
class UserMailer < ApplicationMailer
  before_action :set_user
  before_action :set_subject
  before_action :set_password_url, only: %i[welcome_staffer reset_password]

  def welcome_staffer
    mail(to: @user.email)
  end

  def email_verification_otp
    @otp = params[:otp]
    @email = params[:email]

    mail(to: @email)
  end

  def email_updated
    @old_email = params[:old_email]

    mail(to: @old_email)
  end

  def password_updated
    mail(to: @user.email)
  end

  def reset_password
    mail(to: @user.email)
  end

  private

  def set_subject
    @subject = I18n.t("user_mailer.#{action_name}.subject")

    raise "#{@subject.inspect} is not a valid subject" unless @subject.is_a?(String) && @subject.present?
  end

  def set_password_url
    @token = params[:token]
    raise ArgumentError, "token (string) is required" unless @token.is_a?(String) && @token.present?

    @set_password_url = URI(reset_password_url(@token)).to_s
    raise "Invalid password reset URL" unless @set_password_url.is_a?(String) && @set_password_url.present?
  end

  def set_user
    @user = params[:user]
    @user = User.visible.where(id: params[:user_id]).first if @user.nil? && params[:user_id].present?

    raise ArgumentError, "User is required" unless @user.is_a?(User)
    raise ArgumentError, "User is not persisted" unless @user.persisted?
    raise ArgumentError, "User is deleted" if @user.deleted?
  end

  def reset_password_url(token)
    Mustache.render(
      Config.hash[:reset_password_url], Config.hash.merge(token:)
    )
  end
end
