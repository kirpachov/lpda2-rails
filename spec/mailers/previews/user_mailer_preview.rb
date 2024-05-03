# frozen_string_literal: true

class UserMailerPreview < ActionMailer::Preview
  # http://localhost:3050/rails/mailers/user_mailer/welcome_staffer.html?locale=en
  def welcome_staffer
    parse_params

    UserMailer.with(user: @user, token: @token).welcome_staffer
  end

  # http://localhost:3050/rails/mailers/user_mailer/password_updated.html?locale=en
  def password_updated
    parse_params

    UserMailer.with(user: @user, token: @token).password_updated
  end

  # http://localhost:3050/rails/mailers/user_mailer/reset_password.html?locale=en
  def reset_password
    parse_params

    UserMailer.with(user: @user, token: @token).reset_password
  end

  private

  def parse_params
    @user = User.find(params[:id]) if params[:id].present?
    @user = User.find(params[:user_id]) if params[:user_id].present?
    @user = User.visible.last if @user.nil?

    @token = params[:token].presence || "SuperS3cr3tT0k3n"
  end
end
