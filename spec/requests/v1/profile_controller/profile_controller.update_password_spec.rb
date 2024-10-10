# frozen_string_literal: true

require "rails_helper"

RSpec.describe "PATCH /v1/profile/password" do
  include_context REQUEST_AUTHENTICATION_CONTEXT

  let(:default_headers) { auth_headers }
  let(:current_password) { current_user_password }
  let(:new_password) { SecureRandom.hex(15) }
  let(:default_params) { { current_password:, new_password:, } }

  def req(headers: default_headers, params: default_params)
    patch "/v1/profile/password", headers:, params:
  end

  context "when user is not authenticated" do
    let(:default_headers) { {} }

    before { req }

    it { expect(json).to include(message: String) }
    it { expect(response).to have_http_status(:unauthorized) }
  end

  context "when current password is not correct" do
    let(:current_password) { "mario" }

    before { req }

    it { expect(json).to include(message: String) }

    it { expect(response).to have_http_status(:unprocessable_entity) }
  end

  context "when new password is too short" do
    let(:new_password) { "123" }

    before { req }

    it { expect(json).to include(message: String) }

    it { expect(response).to have_http_status(:unprocessable_entity) }
  end

  context "when params are valid. Should update user email and send notification" do
    it do
      req
      expect(ActionMailer::MailDeliveryJob).to have_been_enqueued.with("UserMailer", "password_updated",
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
      req
      expect(json).not_to include(:message)
      expect(response).to have_http_status(:ok)
    end

    it do
      expect { req }.to(change { current_user.reload.password_digest })
    end

    it do
      expect(current_user.reload.authenticate(current_password)).to be_a(User)
      req
      expect(current_user.reload.authenticate(new_password)).to be_a(User)
      expect(current_user.reload.authenticate(current_password)).to eq(false)
    end
  end
end
