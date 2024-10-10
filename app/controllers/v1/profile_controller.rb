# frozen_string_literal: true

module V1
  class ProfileController < ApplicationController
    # GET /v1/profile
    def index
      render json: {
        user: current_user.as_json
      }
    end

    # PATCH /v1/profile
    def update
      return index if current_user.update(user_params)

      render_unprocessable_entity(current_user)
    end

    # POST /v1/profile/send_email_verification_otp
    # Send a verification code to the provided email address,
    def send_email_verification_otp
      call = Profile::SendEmailVerificationOtp.run(user: current_user, email: params[:email])
      return render_unprocessable_entity(call) unless call.valid?

      render json: { email: call.email }
    end

    # PATCH /v1/profile/email
    def update_email
      call = Profile::ChangeEmail.run(user: current_user, email: params[:email], otp: params[:otp])
      return render_unprocessable_entity(call) unless call.valid?

      index
    end

    # PATCH /v1/profile/password
    def update_password
      call = Profile::ChangePassword.run(user: current_user, **params.permit(:current_password, :new_password))
      return render_unprocessable_entity(call) unless call.valid?

      index
    end

    # DELETE /v1/profile
    # Mark current user as deleted and anonymize the user's data.
    def destroy
      call = Profile::Delete.run(user: current_user)
      return render_unprocessable_entity(call) unless call.valid?

      head :no_content
    end

    private

    def user_params
      params.permit(:fullname, :username)
    end
  end
end
