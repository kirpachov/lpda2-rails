# frozen_string_literal: true

require "rails_helper"

RSpec.describe "PATCH /v1/admin/holidays/<id>" do
  include_context REQUEST_AUTHENTICATION_CONTEXT

  let(:default_headers) { auth_headers }
  let(:default_params) do
    {
      from_timestamp:,
      to_timestamp:,
      weekly_from:,
      weekly_to:,
      weekday:,
      message:
    }
  end

  let(:id) { holiday.id }
  let!(:holiday) { create(:holiday, from_timestamp: 1.day.from_now.beginning_of_day, to_timestamp: 1.day.from_now.end_of_day) }

  let(:from_timestamp) { 1.day.from_now.strftime("%Y-%m-%d") }
  let(:to_timestamp) { nil }
  let(:weekly_from) { nil }
  let(:weekly_to) { nil }
  let(:weekday) { nil }
  let(:message) { { it: "Vacanza!", en: "Holiday!" } }

  def req(internal_id = id, params: default_params, headers: default_headers)
    patch "/v1/admin/holidays/#{internal_id}", headers:, params:
  end

  context "when not authenticated" do
    let(:default_headers) { {} }

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

  it "saves translated message in Italian" do
    expect { req(params: { message: }) }.to change { I18n.with_locale(:it) { holiday.reload.message } }.from(nil).to("Vacanza!")
    expect(response).to have_http_status(:ok)
  end

  it "saves translated message in English" do
    expect { req(params: { message: }) }.to change { I18n.with_locale(:en){ holiday.reload.message } }.from(nil).to("Holiday!")
    expect(response).to have_http_status(:ok)
  end

  context "when updating a period holiday by adding weekday, should get 422" do
    let(:default_params) do
      {
        weekday:,
      }
    end

    let(:weekday) { 1 }

    it { expect { req }.not_to(change { Holiday.all.as_json }) }

    it do
      req
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  context "when updating a period holiday by adding weekly_from, should get 422" do
    let(:default_params) do
      {
        weekly_from:
      }
    end

    let(:weekly_from) { "10:00" }

    it { expect { req }.not_to(change { Holiday.all.as_json }) }

    it do
      req
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  context "when updating a period holiday by adding weekly_from, should get 422" do
    let(:default_params) do
      {
        weekly_from:
      }
    end

    let(:weekly_from) { "10:00" }

    it { expect { req }.not_to(change { Holiday.all.as_json }) }

    it do
      req
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  context "when updating a period with all weekly_from, weekly_to and weekday, should get 200" do
    let(:default_params) do
      {
        weekly_from:,
        weekly_to:,
        weekday:
      }
    end

    let(:weekly_from) { "10:00" }
    let(:weekly_to) { "12:00" }
    let(:weekday) { 1 }

    it { expect { req }.to(change { Holiday.all.as_json }) }
    it { expect { req }.not_to change(Holiday, :count) }
    it { expect { req }.to(change { Holiday.where(weekday:).count }.by(1)) }

    it do
      req
      expect(response).to have_http_status(:ok)
      expect(json).to include(item: Hash)
      expect(json[:item].symbolize_keys).to include(id: holiday.id)
    end
  end
end
