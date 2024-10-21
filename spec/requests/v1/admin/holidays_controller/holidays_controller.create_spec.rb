# frozen_string_literal: true

require "rails_helper"

RSpec.describe "POST /v1/admin/holidays" do
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

  let(:from_timestamp) { 1.day.from_now.strftime("%Y-%m-%d") }
  let(:to_timestamp) { nil }
  let(:weekly_from) { "11:00" }
  let(:weekly_to) { "13:00" }
  let(:weekday) { nil }
  let(:message) { { it: "Vacanza!", en: "Holiday!" }}

  def req(params: default_params, headers: default_headers)
    post "/v1/admin/holidays", headers:, params:
  end

  context "when not authenticated" do
    let(:default_headers) { {} }

    it { expect { req }.not_to change(Holiday, :count) }

    it do
      req
      expect(response).to have_http_status(:unauthorized)
    end

    it do
      req
      expect(json).to include(message: String)
    end
  end

  it "saves translated message" do
    req
    holiday = Holiday.last
    I18n.with_locale(:it) { expect(holiday.message).to eq("Vacanza!") }
    I18n.with_locale(:en) { expect(holiday.message).to eq("Holiday!") }
  end

  context "when creating a period holiday" do
    let(:default_params) do
      {
        from_timestamp:,
        to_timestamp:,
      }
    end

    let(:from_timestamp) { 1.day.from_now.strftime("%Y-%m-%d") }
    let(:to_timestamp) { 10.days.from_now.strftime("%Y-%m-%d") }

    it { expect { req }.to change(Holiday, :count).by(1) }
    it { expect { req }.not_to(change { Holiday.active_at(Time.zone.now).count }.from(0)) }

    it { expect { req }.to(change { Holiday.active_at(1.day.from_now).count }.from(0).to(1)) }
    it { expect { req }.to(change { Holiday.active_at(2.days.from_now).count }.from(0).to(1)) }
    it { expect { req }.to(change { Holiday.active_at(9.days.from_now).count }.from(0).to(1)) }

    context "response" do
      before { req }

      it { expect(response).to have_http_status(:ok) }
      it { expect(json).to include(item: Hash) }
      it do
        expect(json[:item].symbolize_keys).to include(
          id: Integer,
          from_timestamp: "#{from_timestamp} 00:00",
          to_timestamp: "#{to_timestamp} 00:00",
          weekly_from: nil,
          weekly_to: nil,
          weekday: nil
        )
      end
    end
  end

  context "when creating a weekly holiday" do
    let(:weekly_from) { "10:00" }
    let(:weekly_to) { "15:00" }
    let(:weekday) { 1.day.from_now.wday }
    let(:default_params) do
      {
        weekly_from:,
        weekly_to:,
        weekday:
      }
    end

    it { expect { req }.to change(Holiday, :count).by(1) }

    it { expect { req }.not_to(change { Holiday.active_at(Time.zone.now).count }.from(0)) }
    it { expect { req }.to(change { Holiday.active_at("#{1.day.from_now.strftime("%Y-%m-%d")} 11:00").count }.by(1)) }

    context "response" do
      before { req }

      it { expect(response).to have_http_status(:ok) }
      it { expect(json).to include(item: Hash) }
      it do
        expect(json[:item].symbolize_keys).to include(
                                    id: Integer,
                                    from_timestamp: String,
                                    to_timestamp: nil,
                                    weekly_from: weekly_from,
                                    weekly_to: weekly_to,
                                    weekday: weekday
        )
      end
    end
  end

  context "when creating a weekly holiday" do
    let(:default_params) do
      {
        weekly_from:,
        weekly_to:,
        weekday:
      }
    end

    let(:weekly_from) { "12:00" }
    let(:weekly_to) { "15:00" }
    let(:weekday) { 1.day.from_now.wday }

    context "when 'weekly_from' is missing" do
      let(:weekly_from) { nil }

      it { expect { req }.not_to change(Holiday, :count) }

      it do
        req
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it do
        req
        expect(json).to include(:message)
        expect(json[:message].downcase).to include("weekly")
      end
    end

    context "when 'weekly_to' is missing" do
      let(:weekly_to) { nil }

      it { expect { req }.not_to change(Holiday, :count) }

      it do
        req
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it do
        req
        expect(json).to include(:message)
        expect(json[:message].downcase).to include("weekly")
      end
    end
  end

  context "when to_timestamp, weekly_from and weekly_to are blank should return 422: it would be a 'forever holiday' situation" do
    let(:to_timestamp) { nil }
    let(:weekly_from) { nil }
    let(:weekly_to) { nil }

    it { expect { req }.not_to change(Holiday, :count) }

    it do
      req
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it do
      req
      expect(json).to include(:message)
      expect(json[:message].downcase).to include("timestamp")
    end
  end
end
