# frozen_string_literal: true

require "rails_helper"

RSpec.describe "GET /v1/admin/users/2" do
  before do
    # TODO remove this and authenticate user
    create(:user)
  end

  let(:headers) { {} }
  let(:params) { {} }

  let(:user) { create(:user) }

  def req
    get user_path(user), headers: headers, params: params
  end

  describe "when making a basic request" do
    subject { json }
    before { req }

    it do
      expect(response).to have_http_status(:ok)
    end

    it do
      is_expected.to include(item: Hash)
    end

    it do
      expect(subject[:item]).to include(id: Integer, email: String)
      expect(subject[:item]).not_to include(:password)
      expect(subject[:item]).not_to include(:password_digest)
      expect(subject[:item]).not_to include(:enc_otp_key)
    end
  end

  context "when user is deleted" do
    subject { response }

    before do
      user.update(status: "deleted")
      req
    end

    it { is_expected.to have_http_status(:not_found) }
  end

  context "when user is not found" do
    subject { response }

    let(:user) { build(:user, id: 9) }

    before { req }

    it { is_expected.to have_http_status(:not_found) }
  end
end
