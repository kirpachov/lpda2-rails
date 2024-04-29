# frozen_string_literal: true

# Mailer for all notifications related to Users table.
class UserMailer < ApplicationMailer
  before_action :set_user
  before_action :set_password_url, only: %i[welcome_staffer reset_password]

  def welcome_staffer
    mail(to: @user.email)
  end

  def password_updated
    mail(to: @user.email)
  end

  def reset_password
    mail(to: @user.email)
  end

  private

  def set_password_url
    @token = params[:token]
    raise ArgumentError, "token (string) is required" unless @token.is_a?(String) || @token.blank?

    @set_password_url = URI(reset_password_url(@token)).to_s
    raise "Invalid password reset URL" unless @set_password_url.is_a?(String) && @set_password_url.present?
  end

  def set_user
    @user = params[:user]

    raise ArgumentError, "User is required" unless @user.is_a?(User)
    raise ArgumentError, "User is not persisted" unless @user.persisted?
    raise ArgumentError, "User is deleted" if @user.deleted?
  end

  def reset_password_url(token)
    Mustache.render(
      Config.app[:reset_password_url], Config.app.as_json.merge(token:)
    )
  end
end
