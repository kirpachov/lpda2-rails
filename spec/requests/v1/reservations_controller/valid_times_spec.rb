# frozen_string_literal: true

require "rails_helper"

RSpec.context "GET /v1/reservations/valid_times", type: :request do
  let(:date) { Time.zone.now.to_date.to_s }
  let(:params) { { date: } }

  def req(provided_params = params)
    get "/v1/reservations/valid_times", params: provided_params
  end

  context "when a preorder reservation group has min_people" do
    let(:group) do
      create(:preorder_reservation_group, min_people: 5).tap do |g|
        I18n.available_locales.each do |loc|
          Mobility.with_locale(loc) do
            g.update!(message: "[#{loc}] Please, pay in advance")
          end
        end
      end
    end

    let(:turn) do
      create(:reservation_turn, starts_at: "12:00", ends_at: "15:00", weekday: Time.now.wday)
    end

    before do
      PreorderReservationDate.create!(
        reservation_turn: turn,
        group:,
        date: Time.zone.now
      )

      travel_to Time.zone.now.beginning_of_day do
        req(date: Time.zone.now.to_date.to_s, people:)
      end
    end

    context "when not providing people, will match" do
      let(:people) { nil }

      it { expect(response).to have_http_status(:ok) }
      it { expect(json).not_to include(message: String) }

      it do
        item = json.find { |j| j["starts_at"].include?("12:00") }
        expect(item).to include("preorder_reservation_group" => Hash)
        expect(item["preorder_reservation_group"]).to include("id" => group.id, "payment_value" => group.payment_value,
                                                              "preorder_type" => group.preorder_type, "message" => String)
        expect(item["preorder_reservation_group"]["message"]).to include("Please, pay in advance")
      end
    end

    context "when not providing less people, won't match" do
      let(:people) { [1, 2, 3, 4].sample }

      it { expect(response).to have_http_status(:ok) }
      it { expect(json).not_to include(message: String) }

      it do
        item = json.find { |j| j["starts_at"].include?("12:00") }
        expect(item["preorder_reservation_group"]).to be_nil
      end
    end

    context "when not providing more people, will match" do
      let(:people) { [5, 6, 10].sample }

      it { expect(response).to have_http_status(:ok) }
      it { expect(json).not_to include(message: String) }

      it do
        item = json.find { |j| j["starts_at"].include?("12:00") }
        expect(item).to include("preorder_reservation_group" => Hash)
        expect(item["preorder_reservation_group"]).to include("id" => group.id, "payment_value" => group.payment_value,
                                                              "preorder_type" => group.preorder_type, "message" => String)
        expect(item["preorder_reservation_group"]["message"]).to include("Please, pay in advance")
      end
    end
  end

  context "when two groups have same turn different dates, will check the provided date (issue noticed in production)" do
    let(:turns) do
      [
        create(:reservation_turn, name: "Cena 1", starts_at: "17:00", ends_at: "19:00", weekday: 6),
        create(:reservation_turn, name: "Cena 2", starts_at: "19:01", ends_at: "21:00", weekday: 6)
      ]
    end

    let(:deluxe) do
      create(:preorder_reservation_group, payment_value: 100, title: "Deluxe").tap do |g|
        create(:preorder_reservation_date, reservation_turn: turns[0], group: g, date: Date.parse("2025-05-10"))
      end
    end

    let(:pasqua) do
      create(:preorder_reservation_group, payment_value: 5, title: "Pasqua").tap do |g|
        create(:preorder_reservation_date, reservation_turn: turns[0], group: g, date: Date.parse("2025-05-3"))
      end
    end

    let(:json_cena1) do
      json.find { |j| j["starts_at"] == "2000-01-01T17:00:00.000Z" }
    end

    let(:json_cena2) do
      json.find { |j| j["starts_at"] == "2000-01-01T19:01:00.000Z" }
    end

    before do
      turns

      # NOTE: if we invert the order of creation, we will have a different result
      pasqua
      deluxe

      travel_to Time.zone.parse("2025-04-28 16:00") do
        req(date: "2025-5-10")
      end
    end

    it "result should not depend on order" do
      expect(json_cena1["preorder_reservation_group"]).to be_a(Hash).and(include("id" => deluxe.id,
                                                                                 "payment_value" => 100))
    end

    it { expect(response).to have_http_status(:ok) }
    it { expect(json_cena1).to be_a(Hash) }

    it { expect(json_cena2).to be_a(Hash) }
    it { expect(json_cena2["preorder_reservation_group"]).to be_nil }

    it { expect(json.length).to eq(2) }
  end

  context "when there are no turns" do
    before do
      ReservationTurn.delete_all
      req
    end

    it { expect(response).to have_http_status(:ok) }
    it { expect(json).not_to include(message: String) }
    it { expect(json).to eq [] }
  end

  context "when there are turns but there are also holidays" do
    before do
      ReservationTurn.create!(
        name: "Day",
        weekday: Time.zone.now.wday,
        starts_at: "12:00",
        ends_at: "13:00",
        step: 10
      )
    end

    context "when got holidays on all weekdays but they are expired (to_timestamp is in the past): should see all times available" do
      before do
        (0..6).to_a.each do |weekday|
          create(:holiday,
                 from_timestamp: 4.days.ago,
                 to_timestamp: 2.days.ago,
                 weekday:,
                 weekly_from: "00:00",
                 weekly_to: "23:59")
        end

        travel_to Time.zone.now.beginning_of_day do
          req(date: Time.zone.now.to_date.to_s)
        end
      end

      it { expect(Holiday.all.count).to eq(7) }
      it { expect(response).to have_http_status(:ok) }
      it { expect(json).not_to include(message: String) }
      it { expect(json.dig(0, "valid_times")).to match_array(%w[12:00 12:10 12:20 12:30 12:40 12:50 13:00]) }
    end

    context "when got holidays on all weekdays but they are not active yet (from_timestamp is in the future)" do
      before do
        (0..6).to_a.each do |weekday|
          create(:holiday,
                 from_timestamp: 20.days.from_now,
                 to_timestamp: nil,
                 weekday:,
                 weekly_from: "00:00",
                 weekly_to: "23:59")
        end

        travel_to Time.zone.now.beginning_of_day do
          req(date: Time.zone.now.to_date.to_s)
        end
      end

      it { expect(Holiday.all.count).to eq(7) }
      it { expect(response).to have_http_status(:ok) }
      it { expect(json).not_to include(message: String) }
      it { expect(json.dig(0, "valid_times")).to match_array(%w[12:00 12:10 12:20 12:30 12:40 12:50 13:00]) }
    end

    context "when got one weekly holiday overlapping with the only turn" do
      before do
        create(:holiday, from_timestamp: 10.days.ago, to_timestamp: 10.days.from_now, weekday: Time.zone.now.wday,
                         weekly_from: "12:30", weekly_to: "15:00")

        travel_to Time.zone.now.beginning_of_day do
          req(date: Time.zone.now.to_date.to_s)
        end
      end

      it { expect(response).to have_http_status(:ok) }
      it { expect(json).not_to include(message: String) }
      it { expect(json.dig(0, "valid_times")).to match_array(%w[12:00 12:10 12:20]) }
    end

    context "when got a weekly holiday covering entirely the turn" do
      before do
        create(:holiday, from_timestamp: 10.days.ago, to_timestamp: 10.days.from_now, weekday: Time.zone.now.wday,
                         weekly_from: "11:00", weekly_to: "15:00")

        travel_to Time.zone.now.beginning_of_day do
          req(date: Time.zone.now.to_date.to_s)
        end
      end

      it { expect(response).to have_http_status(:ok) }
      it { expect(json).not_to include(message: String) }
      it { expect(json.length).to eq(1) }
      it { expect(json.dig(0, "valid_times")).to eq([]) }
    end

    context "when got a holiday during many days" do
      before do
        create(:holiday, from_timestamp: 1.day.ago, to_timestamp: 1.day.from_now)

        travel_to Time.zone.now.beginning_of_day do
          req(date: Time.zone.now.to_date.to_s)
        end
      end

      it { expect(response).to have_http_status(:ok) }
      it { expect(json).not_to include(message: String) }
      it { expect(json.length).to eq(1) }
      it { expect(json.dig(0, "valid_times")).to eq([]) }
    end
  end

  context "when there are turns: one turn for each day" do
    subject { response }

    before do
      (0..6).each do |weekday|
        ReservationTurn.create!(name: "Day", weekday:, starts_at: "12:00", ends_at: "14:00", step: 30)
      end

      travel_to Time.zone.now.beginning_of_day do
        req(date: Time.zone.now.to_date.to_s)
      end
    end

    it { is_expected.to have_http_status(:ok) }
    it { expect(json).not_to include(message: String) }

    it {
      expect(json).to all(include("id" => Integer, "starts_at" => String, "ends_at" => String, "weekday" => Integer,
                                  "step" => Integer))
    }

    it { expect(json).to all(include("valid_times" => %w[12:00 12:30 13:00 13:30 14:00])) }
    it { expect(json.count).to eq 1 }
  end

  context "when there are turns: two turns for each day" do
    subject { response }

    before do
      (0..6).each do |weekday|
        ReservationTurn.create!(name: "Lunch", weekday:, starts_at: "12:00", ends_at: "14:00", step: 30)
        ReservationTurn.create!(name: "Dinner1", weekday:, starts_at: "16:00", ends_at: "18:00", step: 30)
      end

      travel_to Time.zone.now.beginning_of_day do
        req(date: Time.zone.now.to_date.to_s)
      end
    end

    it { is_expected.to have_http_status(:ok) }
    it { expect(json).not_to include(message: String) }

    it {
      expect(json).to all(include("id" => Integer, "starts_at" => String, "ends_at" => String, "weekday" => Integer,
                                  "step" => Integer))
    }

    it { expect(json.count).to eq 2 }

    it {
      expect(json.map do |j|
               j["valid_times"]
             end.flatten).to match_array(%w[12:00 12:30 13:00 13:30 14:00 16:00 16:30 17:00 17:30 18:00])
    }
  end

  context "when date is today should return only turns from now on" do
    before do
      ReservationTurn.create!(name: "Lunch", weekday: 5, starts_at: "12:00", ends_at: "14:00", step: 30)
      ReservationTurn.create!(name: "Dinner1", weekday: 5, starts_at: "16:00", ends_at: "18:00", step: 30)
    end

    context "when it's 11:00" do
      before do
        travel_to Time.zone.parse("2021-01-01 11:00") do
          req(date: "2021-01-01")
        end
      end

      it { expect(response).to have_http_status(:ok) }
      it { expect(json).not_to include(message: String) }

      it {
        expect(json.map do |j|
                 j["valid_times"]
               end.flatten).to match_array(%w[12:00 12:30 13:00 13:30 14:00 16:00 16:30 17:00 17:30 18:00])
      }
    end

    context "when it's 12:00" do
      before do
        travel_to Time.zone.parse("2021-01-01 12:00") do
          req(date: "2021-01-01")
        end
      end

      it { expect(response).to have_http_status(:ok) }
      it { expect(json).not_to include(message: String) }

      it {
        expect(json.map do |j|
                 j["valid_times"]
               end.flatten).to match_array(%w[12:30 13:00 13:30 14:00 16:00 16:30 17:00 17:30 18:00])
      }
    end

    context "when it's 15:00" do
      before do
        travel_to Time.zone.parse("2021-01-01 15:00") do
          req(date: "2021-01-01")
        end
      end

      it { expect(response).to have_http_status(:ok) }
      it { expect(json).not_to include(message: String) }

      it {
        expect(json.map do |j|
                 j["valid_times"]
               end.flatten).to match_array(%w[16:00 16:30 17:00 17:30 18:00])
      }
    end
  end

  context "when turn requires payment on specific date" do
    let(:group) do
      create(:preorder_reservation_group).tap do |g|
        I18n.available_locales.each do |loc|
          Mobility.with_locale(loc) do
            g.update!(message: "[#{loc}] Please, pay in advance")
          end
        end
      end
    end

    let(:turn) do
      create(:reservation_turn, starts_at: "12:00", ends_at: "15:00", weekday: Time.now.wday)
    end

    before do
      PreorderReservationDate.create!(
        reservation_turn: turn,
        group:,
        date: Time.zone.now
      )

      travel_to Time.zone.now.beginning_of_day do
        req(date: Time.zone.now.to_date.to_s)
      end
    end

    it { expect(response).to have_http_status(:ok) }
    it { expect(json).not_to include(message: String) }

    it do
      item = json.find { |j| j["starts_at"].include?("12:00") }
      expect(item).to include("preorder_reservation_group" => Hash)
      expect(item["preorder_reservation_group"]).to include("id" => group.id, "payment_value" => group.payment_value,
                                                            "preorder_type" => group.preorder_type, "message" => String)
      expect(item["preorder_reservation_group"]["message"]).to include("Please, pay in advance")
    end
  end

  context "when turn always requires payment" do
    let(:group) { create(:preorder_reservation_group) }

    before do
      I18n.available_locales.each do |loc|
        Mobility.with_locale(loc) do
          group.update!(message: "[#{loc}] Please, pay in advance")
        end
      end

      group.turns = [
        ReservationTurn.create!(name: "Day", weekday: Time.now.wday, starts_at: "12:00", ends_at: "14:00", step: 30)
      ]

      ReservationTurn.create!(name: "Night", weekday: Time.now.wday, starts_at: "19:00", ends_at: "21:00", step: 30)

      travel_to Time.zone.now.beginning_of_day do
        req(date: Time.zone.now.to_date.to_s)
      end
    end

    it { expect(response).to have_http_status(:ok) }
    it { expect(json).not_to include(message: String) }

    it do
      item = json.find { |j| j["starts_at"].include?("12:00") }
      expect(item).to include("preorder_reservation_group" => Hash)
      expect(item["preorder_reservation_group"]).to include("id" => group.id, "payment_value" => group.payment_value,
                                                            "preorder_type" => group.preorder_type, "message" => String)
      expect(item["preorder_reservation_group"]["message"]).to include("Please, pay in advance")
    end
  end

  context "when turn has an associated PreorderReservationGroup but it has status 'inactive'" do
    let(:group) { create(:preorder_reservation_group, status: :inactive) }

    before do
      I18n.available_locales.each do |loc|
        Mobility.with_locale(loc) do
          group.update!(message: "[#{loc}] Please, pay in advance")
        end
      end

      group.turns = [
        ReservationTurn.create!(name: "Day", weekday: Time.now.wday, starts_at: "12:00", ends_at: "14:00", step: 30)
      ]

      ReservationTurn.create!(name: "Night", weekday: Time.now.wday, starts_at: "19:00", ends_at: "21:00", step: 30)

      travel_to Time.zone.now.beginning_of_day do
        req(date: Time.zone.now.to_date.to_s)
      end
    end

    it { expect(response).to have_http_status(:ok) }
    it { expect(json).not_to include(message: String) }

    it do
      item = json.find { |j| j["starts_at"].include?("12:00") }
      expect(item["preorder_reservation_group"]).to be_nil
    end
  end

  context "when setting reservation_min_hours_in_advance is set, should reflect that." do
    before do
      Setting[:reservation_min_hours_in_advance] = 2
      ReservationTurn.create!(name: "Day", weekday: Time.zone.now.wday, starts_at: "12:00", ends_at: "16:00", step: 30)
      travel_to(Time.zone.now.beginning_of_day + 12.hours) do
        req(date: Time.zone.now.to_date.to_s)
      end
    end

    it { expect(response).to have_http_status(:ok) }
    it { expect(json).not_to include(message: String) }

    it do
      expect(json.length).to eq(1)
    end

    it do
      expect(json.map do |j|
               j["valid_times"]
             end.flatten).to match_array(%w[14:30 15:00 15:30 16:00])
    end
  end

  context "when setting reservation_min_hours_in_advance is more that 24, should have impact on other days." do
    before do
      Setting[:reservation_min_hours_in_advance] = 100
      ReservationTurn.create!(name: "Day", weekday: Time.zone.now.wday, starts_at: "12:00", ends_at: "16:00", step: 30)
      ReservationTurn.create!(name: "Day2", weekday: 1.day.from_now.wday, starts_at: "12:00", ends_at: "16:00",
                              step: 30)
      travel_to(Time.zone.now.beginning_of_day + 12.hours) do
        req(date: 1.day.from_now.to_date.to_s)
      end
    end

    it { expect(response).to have_http_status(:ok) }
    it { expect(json).not_to include(message: String) }

    it do
      expect(json.map do |j|
        j["valid_times"]
      end.flatten).to be_empty
    end
  end

  context "when a holiday covers partially a turn" do
    before do
      create(:reservation_turn, starts_at: "12:00", ends_at: "14:00", step: 30, weekday: Time.zone.now.wday)
      create(:holiday,
             from_timestamp: 2.days.ago,
             to_timestamp: 2.days.from_now,
             weekday: Time.zone.now.wday,
             weekly_from: "10:00",
             weekly_to: "13:00")

      travel_to(Time.zone.now.beginning_of_day) do
        req(date: Time.zone.now.to_date.to_s)
      end
    end

    it { expect(Holiday.all.count).to eq(1) }
    it { expect(ReservationTurn.all.count).to eq(1) }

    it do
      expect(json.map do |j|
               j["valid_times"]
             end.flatten).to match_array(%w[13:30 14:00])
    end
  end
end
