# frozen_string_literal: true

require "rails_helper"

RSpec.describe "GET /v1/admin/holidays" do
  include_context REQUEST_AUTHENTICATION_CONTEXT

  let(:holidays) { create_list(:holiday, 3) }

  let(:default_headers) { auth_headers }
  let(:default_params) { {} }

  def req(params: default_params, headers: default_headers)
    get "/v1/admin/holidays", headers:, params:
  end

  context "when not authenticated" do
    let(:default_headers) { {} }

    before { req }

    it { expect(response).to have_http_status(:unauthorized) }

    it { expect(json).to include(message: String) }
  end

  context "when making basic request" do
    before do
      holidays
      req
    end

    it { expect(response).to have_http_status(:ok) }
    it { expect(json).to include(items: Array) }
    it { expect(json[:items].size).to eq(holidays.size) }
    it { expect(json[:items]).to all(include(id: Integer, from_timestamp: String, to_timestamp: String, weekly_from: nil, weekly_to: nil, weekday: nil)) }
  end

  context "when got past holidays (to_timestamp is in the past)" do
    before do
      holidays.each { |h| h.update!(to_timestamp: 1.day.ago) }
      req
    end

    it { expect(response).to have_http_status(:ok) }
    it { expect(json).to include(items: Array) }
    it { expect(json[:items]).to be_empty }
  end

  context "when filtering by active_at timestamp" do
    let(:holidays) do
      [
        create(:holiday, from_timestamp: 1.day.ago.beginning_of_day, to_timestamp: 1.day.from_now.end_of_day),
        create(:holiday, from_timestamp: 2.day.from_now.beginning_of_day, to_timestamp: 3.days.from_now.end_of_day, weekly_from: "11:00", weekly_to: "15:00"),
      ]
    end

    before do
      holidays
    end

    context "when filtering for today: should return only the first holiday" do
      before do
        req(params: { active_at: Time.zone.now.strftime("%Y-%m-%d %H:%M") })
      end

      it { expect(response).to have_http_status(:ok) }
      it { expect(json).to include(items: Array) }
      it { expect(json[:items].pluck(:id)).to match_array([holidays.first.id]) }
    end

    [
      "11:00",
      "12:30",
      "15:00"
    ].each do |time|
      context "when filtering for tomorrow with time #{time.inspect}: should return only the second holiday" do
        before do
          req(params: { active_at: "#{2.day.from_now.strftime("%Y-%m-%d")} #{time}" })
        end

        it { expect(response).to have_http_status(:ok) }
        it { expect(json).to include(items: Array) }
        it { expect(json[:items].pluck(:id)).to match_array([holidays.second.id]) }
      end
    end

    [
      "10.59",
      "00:00",
      "15:01",
      "23:59",
    ].each do |time|
      context "when filtering for tomorrow with time #{time.inspect}: should not found any" do
        before do
          req(params: { active_at: "#{2.day.from_now.strftime("%Y-%m-%d")} #{time}" })
        end

        it { expect(response).to have_http_status(:ok) }
        it { expect(json).to include(items: Array) }
        it { expect(json[:items]).to be_empty }
      end
    end

    [
      "11:00",
      "12:30",
      "15:00"
    ].each do |time|
      context "when filtering for 5 days from now with time #{time.inspect}: should not find anything. This because weekly holidays are for specific weekays." do
        before do
          req(params: { active_at: "#{5.day.from_now.strftime("%Y-%m-%d")} #{time}" })
        end

        it { expect(response).to have_http_status(:ok) }
        it { expect(json).to include(items: Array) }
        it { expect(json[:items]).to be_empty }
      end
    end
  end
end
