# frozen_string_literal: true

require "rails_helper"

RSpec.describe "DELETE /v1/admin/users/2" do
  include_context REQUEST_AUTHENTICATION_CONTEXT

  let(:headers) { auth_headers }
  let(:params) { {} }

  let(:user) { create(:user) }

  def req
    delete user_path(user), headers: headers, params: params
  end

  describe "when making a basic request" do
    it do
      req
      expect(response).to have_http_status(:no_content)
    end

    it { expect { req }.to(change { user.reload.status }.to("deleted")) }
  end

  context "when user is already deleted" do
    subject { response }

    before do
      user.update(status: "deleted")
      req
    end

    it { is_expected.to have_http_status(:not_found) }
    it { expect { req }.not_to(change { user.reload.status }) }
  end

  context "when user is not found" do
    subject { response }

    let(:user) { build(:user, id: 999_999_999) }

    before { req }

    it { is_expected.to have_http_status(:not_found) }
  end

  context "when not authenticated" do
    let(:headers) { {} }
    before do
      user
    end

    it do
      req
      expect(response).to have_http_status(:unauthorized)
    end

    it { expect { req }.not_to change(User, :count) }
    it { expect { req }.not_to(change { User.order(:id).pluck(:status) }) }
    it { expect { req }.not_to(change { User.order(:id).pluck(:updated_at) }) }
  end
end
