# frozen_string_literal: true

require "rails_helper"

RSpec.describe "DELETE /v1/profile" do
  include_context REQUEST_AUTHENTICATION_CONTEXT

  let(:default_headers) { auth_headers }
  let(:default_params) { { } }

  def req(headers: default_headers, params: default_params)
    delete "/v1/profile", headers:, params:
  end

  context "when user is not authenticated" do
    let(:default_headers) { {} }

    before { req }

    it { expect(json).to include(message: String) }
    it { expect(response).to have_http_status(:unauthorized) }
  end

  context "will update users status" do
    it do
      expect { req }.to(change { current_user.reload.status }.to("deleted"))
    end

    it do
      req
      expect(json).not_to include(:message)
      expect(response).to have_http_status(:no_content)
    end
  end
end
