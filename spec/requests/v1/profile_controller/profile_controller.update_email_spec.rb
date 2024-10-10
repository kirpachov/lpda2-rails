# frozen_string_literal: true

require "rails_helper"

RSpec.describe "PATCH /v1/profile/email" do
  include_context REQUEST_AUTHENTICATION_CONTEXT

  let(:default_headers) { auth_headers }
  let(:email) { Faker::Internet.email }
  let(:otp) { Profile::SendEmailVerificationOtp.run(user: current_user, email:).otp }
  let(:default_params) { { email: email, otp: otp } }

  def req(headers: default_headers, params: default_params)
    patch "/v1/profile/email", headers:, params:
  end

  context "when user is not authenticated" do
    let(:default_headers) { {} }

    before { req }

    it { expect(json).to include(message: String) }
    it { expect(response).to have_http_status(:unauthorized) }
  end

  context "when email is not provided" do
    let(:email) { nil }

    before { req }

    it { expect(json).to include(message: String) }

    it { expect(response).to have_http_status(:unprocessable_entity) }
  end

  context "when email is not valid" do
    let(:email) { "not_an_email" }

    before { req }

    it { expect(json).to include(message: String) }
    it { expect(response).to have_http_status(:unprocessable_entity) }
  end

  context "when email is valid. Should update user email and send notification" do
    before do
      otp
    end

    it do
      req
      expect(ActionMailer::MailDeliveryJob).to have_been_enqueued.with("UserMailer", "email_updated",
                                                                       "deliver_now", params: anything, args: anything)
    end

    it do
      Sidekiq::Testing.inline! do
        allow(UserMailer).to receive(:with).and_call_original

        req

        expect(UserMailer).to have_received(:with).once
      end
    end

    it do
      expect { req }.to(change { current_user.reload.email }.to(email))
    end
  end
end
