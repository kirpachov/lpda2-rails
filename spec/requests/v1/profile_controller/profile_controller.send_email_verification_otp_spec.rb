# frozen_string_literal: true

require "rails_helper"

RSpec.describe "POST /v1/profile/send_email_verification_otp" do
  include_context REQUEST_AUTHENTICATION_CONTEXT

  let(:default_headers) { auth_headers }
  let(:email) { Faker::Internet.email }
  let(:default_params) { { email: email } }

  def req(headers: default_headers, params: default_params)
    post "/v1/profile/send_email_verification_otp", headers:, params:
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

  context "when email is valid, should send an email with a otp code" do
    it do
      req
      expect(ActionMailer::MailDeliveryJob).to have_been_enqueued.with("UserMailer", "email_verification_otp",
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
      Sidekiq::Testing.inline! do
        req
        expect(response).to have_http_status(:ok)
      end
    end

    context "when user's enc_otp_key is blank" do
      before { current_user.update!(enc_otp_key: nil) }

      it do
        Sidekiq::Testing.inline! do
          req
          expect(response).to have_http_status(:ok)
        end
      end
    end
  end
end
