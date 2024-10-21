# frozen_string_literal: true

require "rails_helper"

RSpec.describe "DELETE /v1/admin/holidays/<id>" do
  include_context REQUEST_AUTHENTICATION_CONTEXT

  let(:default_headers) { auth_headers }
  let(:default_params) do
    {}
  end

  let(:id) { holiday.id }
  let!(:holiday) { create(:holiday, from_timestamp: 1.day.from_now.beginning_of_day, to_timestamp: 1.day.from_now.end_of_day) }

  def req(internal_id = id, params: default_params, headers: default_headers)
    delete "/v1/admin/holidays/#{internal_id}", headers:, params:
  end

  context "when not authenticated" do
    let(:default_headers) { {} }

    it { expect { req }.not_to(change { Holiday.count }) }
    it { expect { req }.not_to(change { Holiday.all.as_json }) }

    it do
      req
      expect(response).to have_http_status(:unauthorized)
    end

    it do
      req
      expect(json).to include(message: String)
    end
  end

  it { expect { req }.to change { Holiday.count }.by(-1) }
end
