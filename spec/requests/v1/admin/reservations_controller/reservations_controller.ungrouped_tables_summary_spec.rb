# frozen_string_literal: true

require "rails_helper"

RSpec.shared_examples "successul request" do |additions|
  it { expect { req }.not_to raise_error }

  it do
    req
    expect(response).to have_http_status(:ok)
  end

  it do
    req
    expect(json).not_to include(message: String)
  end

  if (additions || {}).key?(:expected_response)
    it do
      req
      expect(json).to eq(additions[:expected_response])
    end
  end
end

RSpec.describe "GET /v1/admin/reservations/ungrouped_tables_summary" do
  include_context REQUEST_AUTHENTICATION_CONTEXT

  let(:default_headers) { auth_headers }
  let(:default_params) do
    {}
  end

  def req(params: default_params, headers: default_headers)
    get "/v1/admin/reservations/ungrouped_tables_summary", headers:, params:
  end

  context "when not authenticated" do
    let(:default_headers) { {} }

    it do
      req
      expect(response).to have_http_status(:unauthorized)
    end

    it do
      req
      expect(json).to include(message: String)
    end
  end

  context "when there are no reservations" do
    it { expect(Reservation.count).to eq(0) }

    it_behaves_like "successul request"
  end

  context "basic request" do
    before do
      create_list(:reservation, 2, adults: 2)
      create_list(:reservation, 1, adults: 3)
      create_list(:reservation, 3, adults: 4, children: 1)
      create_list(:reservation, 3, adults: 4, children: 1, status: :cancelled)
      create_list(:reservation, 3, adults: 4, children: 1, status: :deleted)
      create_list(:reservation, 3, adults: 4, status: :noshow)
    end

    # it { expect(Reservation.count).to eq(2 + 1 + 3) }

    it_behaves_like "successul request", expected_response: {
      "2" => 2,
      "3" => 1,
      "5" => 3
    }
  end

  context "when filtering reservations by adults number" do
    before do
      create(:reservation, adults: 2)
      create(:reservation, adults: 2, children: 1)
      create(:reservation, adults: 1, children: 2)
    end

    let(:default_params) { { adults: 2 } }

    it { expect(Reservation.count).to eq(1 + 1 + 1) }

    it_behaves_like "successul request", expected_response: {
      "2" => 1,
      "3" => 1
    }
  end

  context "when filtering reservations by children number" do
    before do
      create(:reservation, adults: 2, children: 2)
      create(:reservation, adults: 2, children: 1)
      create(:reservation, adults: 1, children: 2)
    end

    let(:default_params) { { children: 2 } }

    it { expect(Reservation.count).to eq(1 + 1 + 1) }

    it_behaves_like "successul request", expected_response: {
      "4" => 1,
      "3" => 1
    }
  end

  context "when filtering reservations by people" do
    before do
      create(:reservation, adults: 1)
      create(:reservation, adults: 2)
      create(:reservation, adults: 3)
    end

    let(:default_params) { { people: 2 } }

    it { expect(Reservation.count).to eq(1 + 1 + 1) }

    it_behaves_like "successul request", expected_response: {
      "2" => 1
    }
  end

  context "when filtering reservations by time" do
    before do
      create(:reservation_turn, starts_at: "00:01", ends_at: "23:59", weekday: Time.zone.now.wday)
      create(:reservation, adults: 4, datetime: Time.zone.now.change(hour: 10, min: 0))
      create(:reservation, adults: 10, datetime: Time.zone.now.change(hour: 20, min: 0))
    end

    context "getting only morning reservations with both time_from and time_to" do
      let(:default_params) { { time_from: "9:00", time_to: "14:00" } }

      it { expect(Reservation.count).to eq(2) }

      it_behaves_like "successul request", expected_response: {
        "4" => 1
      }
    end

    context "getting only morning reservations with only time_to" do
      let(:default_params) { { time_to: "14:00" } }

      it { expect(Reservation.count).to eq(2) }

      it_behaves_like "successul request", expected_response: {
        "4" => 1
      }
    end

    context "getting only evening reservations with both time_from and time_to" do
      let(:default_params) { { time_from: "15:00", time_to: "23:00" } }

      it { expect(Reservation.count).to eq(2) }

      it_behaves_like "successul request", expected_response: {
        "10" => 1
      }
    end

    context "getting only evening reservations with only time_from" do
      let(:default_params) { { time_from: "15:00" } }

      it { expect(Reservation.count).to eq(2) }

      it_behaves_like "successul request", expected_response: {
        "10" => 1
      }
    end
  end
end
