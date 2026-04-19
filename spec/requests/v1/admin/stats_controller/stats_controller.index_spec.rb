# frozen_string_literal: true

require "rails_helper"

RSpec.describe "GET /v1/admin/stats" do
  include_context REQUEST_AUTHENTICATION_CONTEXT

  ALL_KEYS = %w[reservations-by-hour reservations-count reservations-creation].freeze

  let(:headers) { auth_headers }
  let(:params) { { keys: } }
  let(:keys) { ALL_KEYS }

  def req(p = params, h = headers)
    get "/v1/admin/stats", headers: h, params: p
  end

  context "when not authenticated" do
    let(:headers) { {} }

    it do
      req
      expect(response).to have_http_status(:unauthorized)
    end

    it do
      req
      expect(json).to include(message: String)
    end
  end

  context "when providing one invalid key" do
    let(:keys) { %w[someinvalidkey] }

    before { req }

    it { expect(response).to have_http_status(:bad_request) }
    it { expect(json).to include(message: String) }
    it { expect(json[:message].to_s.downcase).to include("someinvalidkey") }
  end

  context "when not providing any key will return all." do
    let(:params) { {} }

    before { req }

    it { expect(response).to be_successful }

    it { expect(json).to be_a(Hash) }

    it { expect(json).not_to be_empty }

    it { expect(json.keys.map(&:to_s)).to match_array(ALL_KEYS) }
  end

  context "when providing all keys" do
    let(:keys) { ALL_KEYS }

    before { req }

    it { expect(response).to be_successful }

    it { expect(json).to be_a(Hash) }

    it { expect(json).not_to be_empty }

    it { expect(json.keys.map(&:to_s)).to match_array(ALL_KEYS) }
  end

  context "when checking reservations-creation key" do
    let(:keys) { %w[reservations-creation] }

    before do
      [0, 1, 2, 3, 4, 5, 6].each do |i|
        create(:reservation_turn, starts_at: "1:00", ends_at: "23:00", weekday: i)
      end

      create_list(:reservation, 10)

      req
    end

    it do
      expect(json["reservations-creation"]).to be_a(Hash).and(
        include(
          count_by_month: Hash,
          count_by_year: Hash,
          count_by_day_current_month: Hash,
          count_by_day_current_week: Hash,
          current: {
            day: Integer,
            week: Integer,
            month: Integer,
            year: Integer
          }
        )
      )

      expect(json.dig("reservations-creation", "count_by_month", "#{Date.today.strftime("%Y-%m")}")).to eq(10)
      expect(json.dig("reservations-creation", "count_by_month").keys).to eq(["#{Date.today.strftime("%Y-%m")}"])

      expect(json.dig("reservations-creation", "count_by_year", "#{Date.today.strftime("%Y")}")).to eq(10)
      expect(json.dig("reservations-creation", "count_by_year").keys).to eq(["#{Date.today.strftime("%Y")}"])

      expect(json.dig("reservations-creation", "current", "day")).to eq(10)
      expect(json.dig("reservations-creation", "current", "week")).to eq(10)
      expect(json.dig("reservations-creation", "current", "month")).to eq(10)
      expect(json.dig("reservations-creation", "current", "year")).to eq(10)

      Reservation.order(created_at: :asc).last.update!(created_at: Date.current.beginning_of_month + 1.day)
      Reservation.order(created_at: :asc).last.update!(created_at: Date.current.beginning_of_month - 1.day)
      Reservation.order(created_at: :asc).last.update!(created_at: Date.current.beginning_of_week)
      req

      # What is changed now: today -3, current_week -2, current_month -1, current_year same.
      expect(json.dig("reservations-creation", "count_by_month", "#{Date.today.strftime("%Y-%m")}")).to eq(9)
      expect(json.dig("reservations-creation",
                      "count_by_month").keys).to contain_exactly("#{Date.today.strftime("%Y-%m")}",
                                                                 (Date.current - 1.month).strftime("%Y-%m"))

      expect(json.dig("reservations-creation", "count_by_year", "#{Date.today.strftime("%Y")}")).to eq(10)
      expect(json.dig("reservations-creation", "count_by_year").keys).to eq(["#{Date.today.strftime("%Y")}"])

      expect(json.dig("reservations-creation", "current", "day")).to eq(7)
      expect(json.dig("reservations-creation", "current", "week")).to eq(8)
      expect(json.dig("reservations-creation", "current", "month")).to eq(9)
      expect(json.dig("reservations-creation", "current", "year")).to eq(10)
    end
  end

  context "when requiring reservations-by-hour as key" do
    let(:keys) { %w[reservations-by-hour] }

    before { req }

    it { expect(response).to be_successful }

    it { expect(json).to be_a(Hash) }
    it { expect(json.keys).to match_array(keys) }

    context "when has two reservation at same datetime" do
      let(:datetime) { DateTime.parse("2021-01-01 10:00:00") }
      let(:res1) { create(:reservation, adults: 1, datetime:) }
      let(:res2) { create(:reservation, adults: 1, datetime:) }

      before do
        create(:reservation_turn, starts_at: "9:00", ends_at: "11:00", weekday: datetime.wday)
        res1
        res2
        req
      end

      it { expect(Reservation.count).to eq 2 }

      it { expect(json["reservations-by-hour"]).to be_a(Hash) }
      it { expect(json["reservations-by-hour"].keys).to contain_exactly("2021-01-01 10:00") }
      it { expect(json["reservations-by-hour"]["2021-01-01 10:00"]).to eq(2) }
    end

    context "when has two reservation at different datetime" do
      let(:datetime1) { DateTime.parse("2021-01-01 10:00:00") }
      let(:datetime2) { DateTime.parse("2021-01-01 11:00:00") }
      let(:res1) { create(:reservation, adults: 1, datetime: datetime1) }
      let(:res2) { create(:reservation, adults: 1, datetime: datetime2) }

      before do
        create(:reservation_turn, starts_at: "9:00", ends_at: "12:00", weekday: datetime1.wday)
        res1
        res2
        req
      end

      it { expect(Reservation.count).to eq 2 }

      it { expect(json["reservations-by-hour"]).to be_a(Hash) }
      it { expect(json["reservations-by-hour"].keys).to contain_exactly("2021-01-01 10:00", "2021-01-01 11:00") }
      it { expect(json["reservations-by-hour"]["2021-01-01 10:00"]).to eq(1) }
      it { expect(json["reservations-by-hour"]["2021-01-01 11:00"]).to eq(1) }
    end

    context "when filtering by date" do
      let(:datetime) { DateTime.parse("2021-01-01 10:00:00") }
      let(:reservations) do
        [
          create(:reservation, adults: 1, datetime:),
          create(:reservation, adults: 1, datetime: datetime + 1.hour),
          create(:reservation, adults: 1, datetime: datetime + 1.day)
        ]
      end

      let(:params) do
        {
          keys:,
          # NOTE: both 'reservation' and 'reservationS' are valid
          reservations_date_from: datetime.to_date,
          reservation_date_to: datetime.to_date
        }
      end

      before do
        create(:reservation_turn, starts_at: "9:00", ends_at: "12:00", weekday: datetime.wday)
        create(:reservation_turn, starts_at: "9:00", ends_at: "12:00", weekday: (datetime + 1.day).wday)
        reservations
        req
      end

      it { expect(Reservation.count).to eq 3 }

      it { expect(json["reservations-by-hour"]).to be_a(Hash) }
      it { expect(json["reservations-by-hour"].keys).to contain_exactly("2021-01-01 10:00", "2021-01-01 11:00") }
      it { expect(json["reservations-by-hour"]["2021-01-01 10:00"]).to eq(1) }
      it { expect(json["reservations-by-hour"]["2021-01-01 11:00"]).to eq(1) }
    end
  end

  context "will return sum of people" do
    let(:datetime) { DateTime.parse("2021-01-01 10:00:00") }

    before do
      create(:reservation_turn, starts_at: "9:00", ends_at: "12:00", weekday: datetime.wday)
      create(:reservation, adults: 7, children: 2, datetime:)
      create(:reservation, adults: 2, datetime:)
      req
    end

    it { expect(Reservation.count).to eq 2 }

    it { expect(json["reservations-by-hour"]).to be_a(Hash) }
    it { expect(json["reservations-by-hour"].keys).to contain_exactly("2021-01-01 10:00") }
    it { expect(json["reservations-by-hour"]["2021-01-01 10:00"]).to eq(11) }
  end

  context "when checking reservations-count key" do
    before do
      req
    end

    it "be blank if there are no reservations" do
      expect(json["reservations-count"]).to be_a(Hash).and(
        include(
          count_by_month: {},
          count_by_year: {},
          count_by_day_current_month: {},
          count_by_day_current_week: {},
          current: {
            day: 0,
            month: 0,
            week: 0,
            year: 0
          }
        )
      )
    end
  end

  context "when there are reservations and asking for reservations-count" do
    let(:reservation_turns) do
      [0, 1, 2, 3, 4, 5, 6].each do |i|
        create(:reservation_turn, starts_at: "1:00", ends_at: "23:00", weekday: i)
      end
    end

    before do
      reservation_turns

      # create(:reservation, adults: 1, datetime: DateTime.parse("2021-01-01 10:00:00"))
      create(:reservation, adults: 1, datetime: DateTime.parse("2021-01-01 11:00:00"))
      create(:reservation, adults: 1, datetime: DateTime.parse("2021-01-02 10:00:00"))
      create(:reservation, adults: 1, datetime: DateTime.parse("2021-01-03 10:00:00"))
      create(:reservation, adults: 1, datetime: DateTime.parse("2021-05-03 10:00:00"))
      create(:reservation, adults: 2, datetime: DateTime.parse("2023-01-01 10:00:00"))

      create(:reservation, adults: 2, datetime: DateTime.parse("2025-03-15 10:00:00")) # today
      create(:reservation, adults: 2, datetime: DateTime.parse("2025-03-15 12:00:00")) # today
      create(:reservation, adults: 2, datetime: DateTime.parse("2025-03-14 10:00:00")) # yesterday
      create(:reservation, adults: 3, datetime: DateTime.parse("2025-03-16 10:00:00")) # tomorrow: last day of week
      create(:reservation, adults: 4, datetime: DateTime.parse("2025-03-17 10:00:00")) # next day: won't be counted in week

      create(:reservation, adults: 5, datetime: DateTime.parse("2025-03-09 10:00:00")) # last sunday (won't be counted in week)
      create(:reservation, adults: 3, datetime: DateTime.parse("2025-03-08 10:00:00")) # last saturday (won't be counted in week)

      create(:reservation, adults: 11, datetime: DateTime.parse("2025-05-15 16:00:00"))

      10.times do
        create(:reservation, {
                 datetime: DateTime.parse("2025-01-#{(1..25).to_a.sample} 10:00:00"),
                 status: %i[cancelled deleted].sample
               })
      end

      travel_to(DateTime.parse("2025-3-15 18:34:00")) do
        req
      end
    end

    it do
      expect(json["reservations-count"]).to be_a(Hash).and(
        include(
          {
            count_by_month: {
              "2023-01": 2,
              "2021-01": 3,
              "2021-05": 1,
              "2025-03": 21,
              "2025-05": 11
            },
            count_by_year: {
              "2025": 21 + 11,
              "2023": 2,
              "2021": 4
            },
            count_by_day_current_month: {
              "2025-03-08": 3,
              "2025-03-09": 5,
              "2025-03-14": 2,
              "2025-03-15": 4,
              "2025-03-16": 3,
              "2025-03-17": 4
            },
            count_by_day_current_week: {
              "2025-03-14": 2,
              "2025-03-15": 4
            },
            current: {
              day: 4,
              week: 6,
              month: 21,
              year: 21 + 11
            }
          }
        )
      )
    end
  end
end
