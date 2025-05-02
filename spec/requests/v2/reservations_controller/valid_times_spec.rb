# frozen_string_literal: true

require "rails_helper"

RSpec.context "GET /v2/reservations/valid_times", type: :request do
  let(:date) { Time.zone.now.to_date.to_s }
  let(:params) { { date: } }

  let(:default_headers) { {} }
  let(:headers) { default_headers }

  def req(provided_params = params)
    get "/v2/reservations/valid_times", params: provided_params, headers:
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
        item = json[:turns].find { |j| j["starts_at"].include?("12:00") }
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
        item = json[:turns].find { |j| j["starts_at"].include?("12:00") }
        expect(item["preorder_reservation_group"]).to be_nil
      end
    end

    context "when not providing more people, will match" do
      let(:people) { [5, 6, 10].sample }

      it { expect(response).to have_http_status(:ok) }
      it { expect(json).not_to include(message: String) }

      it do
        item = json[:turns].find { |j| j["starts_at"].include?("12:00") }
        expect(item).to include("preorder_reservation_group" => Hash)
        expect(item["preorder_reservation_group"]).to include("id" => group.id, "payment_value" => group.payment_value,
                                                              "preorder_type" => group.preorder_type, "message" => String)
        expect(item["preorder_reservation_group"]["message"]).to include("Please, pay in advance")
      end
    end
  end

  context "when there are no turns" do
    before do
      ReservationTurn.delete_all
      req
    end

    it { expect(response).to have_http_status(:ok) }
    it { expect(json[:turns]).not_to include(message: String) }
    it { expect(json[:turns]).to eq [] }
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
      json["turns"].find { |j| j["starts_at"] == "2000-01-01T17:00:00.000Z" }
    end

    let(:json_cena2) do
      json["turns"].find { |j| j["starts_at"] == "2000-01-01T19:01:00.000Z" }
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

    it { expect(json["turns"].length).to eq(2) }
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
      it { expect(json[:turns]).not_to include(message: String) }
      it { expect(json[:turns].dig(0, "valid_times")).to match_array(%w[12:00 12:10 12:20 12:30 12:40 12:50 13:00]) }
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
      it { expect(json[:turns]).not_to include(message: String) }
      it { expect(json[:turns].dig(0, "valid_times")).to match_array(%w[12:00 12:10 12:20 12:30 12:40 12:50 13:00]) }
    end

    context "when got one weekly holiday for the whole day" do
      before do
        create(:holiday, from_timestamp: 10.days.ago, to_timestamp: [10.days.from_now, nil].sample, weekday: Time.zone.now.wday,
                         weekly_from: ["00:00", "01:00"].sample, weekly_to: ["15:00", "19:00", "23:59"].sample).tap do |h|
          h.assign_translation("message", en: "overlapping with only the turn", it: "qualche stringa a caso....")
          h.save!
        end

        travel_to Time.zone.now.beginning_of_day do
          req(date: Time.zone.now.to_date.to_s)
        end
      end

      it { expect(response).to have_http_status(:ok) }
      it { expect(json[:turns]).not_to include(message: String) }
      it { expect(json[:turns].dig(0, "valid_times")).to be_empty }
      it { expect(json[:holidays].count).to eq(1) }
      it { expect(json.dig(:holidays, 0, :message)).to eq("overlapping with only the turn") }

      [
        "it"
      ].each do |v|
        context "if making request with header accept-language: #{v.inspect}" do
          let(:headers) { default_headers.merge("Accept-Language" => v) }

          before do
            travel_to Time.zone.now.beginning_of_day do
              req(date: Time.zone.now.to_date.to_s)
            end
          end

          it { expect(json[:holidays].count).to eq(1) }
          it { expect(json.dig(:holidays, 0, :message)).to eq("qualche stringa a caso....") }
        end
      end
    end

    context "when got one weekly holiday overlapping with the only turn" do
      before do
        # Ignored because to_timestamp < now
        create(:holiday, from_timestamp: 10.days.ago, to_timestamp: 10.days.ago, weekday: Time.zone.now.wday,
                         weekly_from: "12:30", weekly_to: ["15:00", "16:00", "23:59"].sample)

        # Ignored because other wday
        create(:holiday, from_timestamp: 10.days.ago, to_timestamp: [1.day.from_now, 10.days.from_now, nil].sample,
                         weekday: (Time.zone.now.wday + 1) % 6, weekly_from: "12:30", weekly_to: ["15:00", "16:00", "23:59"].sample)
        create(:holiday, from_timestamp: 10.days.ago, to_timestamp: [1.day.from_now, 10.days.from_now, nil].sample,
                         weekday: (Time.zone.now.wday - 1) % 6, weekly_from: "12:30", weekly_to: ["15:00", "16:00", "23:59"].sample)

        create(:holiday, from_timestamp: 10.days.ago, to_timestamp: [10.days.from_now, nil].sample, weekday: Time.zone.now.wday,
                         weekly_from: "12:30", weekly_to: ["15:00", "16:00", "23:59"].sample).tap do |h|
          h.assign_translation("message", en: "overlapping with only the turn", it: "qualche stringa a caso....")
          h.save!
        end

        travel_to Time.zone.now.beginning_of_day do
          req(date: Time.zone.now.to_date.to_s)
        end
      end

      it { expect(response).to have_http_status(:ok) }
      it { expect(json[:turns]).not_to include(message: String) }
      it { expect(json[:turns].dig(0, "valid_times")).to match_array(%w[12:00 12:10 12:20]) }
      it { expect(json[:holidays].count).to eq(1) }
      it { expect(json.dig(:holidays, 0, :message)).to eq("overlapping with only the turn") }

      [
        "it"
      ].each do |v|
        context "if making request with header accept-language: #{v.inspect}" do
          let(:headers) { default_headers.merge("Accept-Language" => v) }

          before do
            travel_to Time.zone.now.beginning_of_day do
              req(date: Time.zone.now.to_date.to_s)
            end
          end

          it { expect(json[:holidays].count).to eq(1) }
          it { expect(json.dig(:holidays, 0, :message)).to eq("qualche stringa a caso....") }
        end
      end
    end

    context "when got a weekly holiday covering entirely the turn" do
      before do
        create(:holiday, from_timestamp: 10.days.ago, to_timestamp: 10.days.from_now, weekday: Time.zone.now.wday,
                         weekly_from: "11:00", weekly_to: "15:00").tap do |h|
          h.assign_translation("message", it: "settimanale", en: "weekly holiday, mario")
          h.save!
        end

        travel_to Time.zone.now.beginning_of_day do
          req(date: Time.zone.now.to_date.to_s)
        end
      end

      it { expect(response).to have_http_status(:ok) }
      it { expect(json[:turns]).not_to include(message: String) }
      it { expect(json[:turns].length).to eq(1) }
      it { expect(json[:turns].dig(0, "valid_times")).to eq([]) }
      it { expect(json[:holidays].count).to eq 1 }
      it { expect(json.dig(:holidays, 0, :message)).to eq("weekly holiday, mario") }
    end

    context "when got a holiday during many days" do
      before do
        create(:holiday, from_timestamp: 1.day.ago, to_timestamp: 1.day.from_now).tap do |h|
          h.assign_translation("message", it: "ciao mario", en: "hello mario")
          h.save!
        end

        travel_to Time.zone.now.beginning_of_day do
          req(date: Time.zone.now.to_date.to_s)
        end
      end

      it { expect(response).to have_http_status(:ok) }
      it { expect(json[:turns]).not_to include(message: String) }
      it { expect(json[:turns].length).to eq(1) }
      it { expect(json[:turns].dig(0, "valid_times")).to eq([]) }
      it { expect(json[:holidays].count).to eq 1 }
      it { expect(json.dig(:holidays, 0, :message)).to eq("hello mario") }
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
    it { expect(json[:turns]).not_to include(message: String) }

    it {
      expect(json[:turns]).to all(include("id" => Integer, "starts_at" => String, "ends_at" => String, "weekday" => Integer,
                                          "step" => Integer))
    }

    it { expect(json[:turns]).to all(include("valid_times" => %w[12:00 12:30 13:00 13:30 14:00])) }
    it { expect(json[:turns].count).to eq 1 }
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
    it { expect(json[:turns]).not_to include(message: String) }

    it {
      expect(json[:turns]).to all(include("id" => Integer, "starts_at" => String, "ends_at" => String, "weekday" => Integer,
                                          "step" => Integer))
    }

    it { expect(json[:turns].count).to eq 2 }

    it {
      expect(json[:turns].map do |j|
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
      it { expect(json[:turns]).not_to include(message: String) }

      it {
        expect(json[:turns].map do |j|
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
      it { expect(json[:turns]).not_to include(message: String) }

      it {
        expect(json[:turns].map do |j|
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
      it { expect(json[:turns]).not_to include(message: String) }

      it {
        expect(json[:turns].map do |j|
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
    it { expect(json[:turns]).not_to include(message: String) }

    it do
      item = json[:turns].find { |j| j["starts_at"].include?("12:00") }
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
    it { expect(json[:turns]).not_to include(message: String) }

    it do
      item = json[:turns].find { |j| j["starts_at"].include?("12:00") }
      expect(item).to include("preorder_reservation_group" => Hash)
      expect(item["preorder_reservation_group"]).to include("id" => group.id, "payment_value" => group.payment_value,
                                                            "preorder_type" => group.preorder_type, "message" => String)
      expect(item["preorder_reservation_group"]["message"]).to include("Please, pay in advance")
    end
  end

  # Many scenarios:
  # We'll have only one TableType and only one ReservationTurn.
  # people_per_turn is the number of people can reserve a specific TableType
  # new_reservation_size is the number of people that are trying to reserve a TableType right now
  # existing_reservations is the number of people that already reserved a TableType
  [
    {
      people_per_turn: 10,
      new_reservation_size: nil,
      existing_reservations: [{ time: "19:00", adults: 10 }]
    },

    {
      people_per_turn: Random.rand(10..11),
      new_reservation_size: Random.rand(2..10),
      existing_reservations: [{ time: "19:00", adults: 10 }]
    },

    {
      people_per_turn: 11,
      new_reservation_size: 2,
      small_enough: 1,
      existing_reservations: [{ time: "19:00", adults: 10 }]
    },

    {
      people_per_turn: 10,
      new_reservation_size: 6,
      small_enough: 5,
      existing_reservations: [{ time: "19:00", adults: 5 }]
    },

    {
      people_per_turn: 10,
      new_reservation_size: 3,
      small_enough: 2,
      existing_reservations: [{
        time: "19:00", adults: 2
      },
                              { time: "19:30", adults: 2 },
                              { time: "20:00", adults: 2 },
                              { time: "20:30", adults: 1 },
                              { time: "21:00", adults: 1 },

                              # Won't be counted as outside of the dinner turn
                              { time: "21:10", adults: 10 },
                              { time: "10:10", adults: 10 }]
    }
  ].each do |scenario|
    context "when turn has table_types but they are already full (all seats are taken) (scenario=#{scenario.inspect})" do
      subject(:turn) { json[:turns].find { |j| j["starts_at"].include?("19:00") } }

      let(:date) { Time.zone.now.to_date.to_s }

      let(:table_type) { create(:table_type, :with_image) }
      let(:dinner) do
        ReservationTurn.create!(name: "Night", weekday: Time.zone.now.wday, starts_at: "19:00", ends_at: "21:00",
                                step: 30)
      end

      let(:lunch) do
        ReservationTurn.create!(name: "lunch", weekday: Time.zone.now.wday, starts_at: "10:00", ends_at: "14:00",
                                step: 30)
      end

      let!(:group) do
        create(:preorder_reservation_group).tap do |grp|
          grp.add_table_type(table_type:, people_per_turn: scenario[:people_per_turn], price: 4)
          grp.turns = [[dinner, lunch], [dinner]].sample
        end
      end

      let(:people) do
        scenario[:new_reservation_size]
      end

      before do
        scenario[:existing_reservations].each do |res|
          create(:reservation, table_type:, adults: res[:adults], children: 0,
                               datetime: DateTime.parse("#{date} #{res[:time]}"))

          # expect(reservation.table_type).to eq(table_type)
          # expect(reservation.reservation_turn).to eq(dinner)
        end

        # Creating some "noise" reservations. Theese should not be considered.
        Random.rand(0..3).times do
          create(:reservation, status: %w[active arrived deleted noshow cancelled].sample, table_type:, adults: Random.rand(1..10), children: 0, datetime: DateTime.parse("#{date} #{
            Random.rand(10..14)
          }:00"))
        end

        travel_to Time.zone.now.beginning_of_day do
          req(date: Time.zone.now.to_date.to_s, people:)
        end
      end

      it { expect(response).to have_http_status(:ok) }
      it { expect(json).not_to include(message: String) }

      it { expect(json).to include(turns: Array) }
      it { expect(json[:turns]).not_to be_empty }
      it { expect(json[:turns][0]).to include(preorder_reservation_group: Hash) }

      it do
        expect(turn.dig("preorder_reservation_group", "table_type_to_preorder_reservation_groups")).to be_empty
      end

      if scenario[:small_enough]
        context "when requested number of people is small enough" do
          let(:people) { scenario[:small_enough] }

          it { expect(response).to have_http_status(:ok) }
          it { expect(json).not_to include(message: String) }

          it { expect(json).to include(turns: Array) }
          it { expect(json[:turns]).not_to be_empty }
          it { expect(json[:turns][0]).to include(preorder_reservation_group: Hash) }

          it do
            expect(turn.dig("preorder_reservation_group", "table_type_to_preorder_reservation_groups")).not_to be_empty
          end
        end
      end
    end
  end

  context "when turn has table_types associated, the active ones should be returned" do
    subject(:turn) { json[:turns].find { |j| j["starts_at"].include?("12:00") } }

    let(:inactive_table_type) { create(:table_type, :with_image, status: :inactive) }
    let(:not_associated_table_type) { create(:table_type, :with_image) }
    let(:table_type) { create(:table_type, :with_image) }
    let(:turns) do
      [
        ReservationTurn.create!(name: "Day", weekday: Time.now.wday, starts_at: "12:00", ends_at: "14:00", step: 30),
        ReservationTurn.create!(name: "Night", weekday: Time.now.wday, starts_at: "19:00", ends_at: "21:00", step: 30)
      ]
    end

    let!(:group) do
      create(:preorder_reservation_group).tap do |grp|
        grp.add_table_type(table_type: inactive_table_type, people_per_turn: 12, price: 3)
        grp.add_table_type(table_type:, people_per_turn: 10, price: 4)
        grp.turns = [turns[0]]
      end
    end

    before do
      travel_to Time.zone.now.beginning_of_day do
        req(date: Time.zone.now.to_date.to_s)
      end
    end

    it { expect(response).to have_http_status(:ok) }
    it { expect(json).not_to include(message: String) }

    it { expect(turn).to include("preorder_reservation_group" => Hash) }

    it do
      expect(turn["preorder_reservation_group"]).to include(
        "id" => group.id,
        "payment_value" => group.payment_value,
        "preorder_type" => group.preorder_type,
        "table_type_to_preorder_reservation_groups" => Array
      )
    end

    it do
      expect(turn.dig("preorder_reservation_group",
                      "table_type_to_preorder_reservation_groups")).to be_a(Array).and(all(include(
                                                                                             "table_type" => Hash,
                                                                                             "table_type_id" => Integer,
                                                                                             "price" => Float,
                                                                                             "people_per_turn" => Integer
                                                                                           )))
    end

    it do
      expect(turn.dig("preorder_reservation_group", "table_type_to_preorder_reservation_groups").length).to eq(2)
    end

    it do
      expect(turn.dig("preorder_reservation_group",
                      "table_type_to_preorder_reservation_groups").pluck(:price)).to contain_exactly(3, 4)
    end

    it do
      expect(turn.dig("preorder_reservation_group",
                      "table_type_to_preorder_reservation_groups").pluck(:people_per_turn)).to contain_exactly(10, 12)
    end

    it do
      expect(turn.dig("preorder_reservation_group",
                      "table_type_to_preorder_reservation_groups").pluck(:table_type)).to all(include(
                                                                                                name: String,
                                                                                                description: String,
                                                                                                images: Array
                                                                                              ))
    end

    it do
      expect(turn.dig("preorder_reservation_group",
                      "table_type_to_preorder_reservation_groups").pluck(:table_type).sample.keys.map(&:to_s) & ["notes"]).to be_empty
    end

    it do
      expect(turn.dig("preorder_reservation_group",
                      "table_type_to_preorder_reservation_groups").pluck(:table_type).flatten.pluck(:images).flatten).to all(include(
                                                                                                                               "url" => String
                                                                                                                             ))
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
    it { expect(json[:turns]).not_to include(message: String) }

    it do
      item = json[:turns].find { |j| j["starts_at"].include?("12:00") }
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
    it { expect(json[:turns]).not_to include(message: String) }

    it do
      expect(json[:turns].length).to eq(1)
    end

    it do
      expect(json[:turns].map do |j|
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
    it { expect(json[:turns]).not_to include(message: String) }

    it do
      expect(json[:turns].map do |j|
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
      expect(json[:turns].map do |j|
               j["valid_times"]
             end.flatten).to match_array(%w[13:30 14:00])
    end
  end

  context "when requested date is too far from max date" do
    before do
      Setting[:reservation_max_days_in_advance] = 9
    end

    [
      0, 1, 5, 7, 8, 9
    ].each do |days|
      context "when requested date is #{days} days from now, should return valid times." do
        before do
          create(:reservation_turn, starts_at: "12:00", ends_at: "14:00", step: 30,
                                    weekday: (Time.zone.now + days.days).wday)

          travel_to(Time.zone.now.beginning_of_day) do
            req(date: (Time.zone.now + days.days).to_date.to_s)
          end
        end

        it { expect(ReservationTurn.all.count).to eq(1) }

        it { expect(response).to have_http_status(:ok) }

        it { expect(json).not_to include(message: String) }

        it do
          expect(json[:turns].map do |j|
                   j["valid_times"]
                 end.flatten).not_to be_empty
        end
      end
    end

    [
      10, 11, 100, 1000
    ].each do |days|
      context "when requested date is #{days} days from now, should not return any time." do
        before do
          create(:reservation_turn, starts_at: "12:00", ends_at: "14:00", step: 30,
                                    weekday: (Time.zone.now + days.days).wday)

          travel_to(Time.zone.now.beginning_of_day) do
            req(date: (Time.zone.now + days.days).to_date.to_s)
          end
        end

        it { expect(ReservationTurn.all.count).to eq(1) }

        it { expect(response).to have_http_status(:ok) }

        it { expect(json).not_to include(message: String) }

        it do
          expect(json[:turns].map do |j|
                   j["valid_times"]
                 end.flatten).to eq([])
        end
      end
    end
  end

  context "when there are some ReservationTurnMessage for the requested date" do
    before do
      t = create(:reservation_turn, starts_at: "12:00", ends_at: "14:00", step: 30, weekday: Time.zone.now.wday)

      t.reservation_turn_messages << create(:reservation_turn_message, from_date: Time.zone.now.to_date,
                                                                       to_date: Time.zone.now.to_date).tap do |m|
        m.assign_translation("message", it: "primo messaggio", en: "first message")
        m.save!
      end

      t.reservation_turn_messages << create(:reservation_turn_message, from_date: 2.days.from_now,
                                                                       to_date: nil).tap do |m|
        m.assign_translation("message", it: "messaggio futuro", en: "future message")
        m.save!
      end

      t.reservation_turn_messages << create(:reservation_turn_message, from_date: nil, to_date: 2.days.ago).tap do |m|
        m.assign_translation("message", it: "messaggio passato", en: "past message")
        m.save!
      end

      t.reservation_turn_messages << create(:reservation_turn_message, from_date: nil, to_date: nil).tap do |m|
        m.assign_translation("message", it: "messaggio ognipresente", en: "always present message")
        m.save!
      end

      travel_to(Time.zone.now.beginning_of_day) do
        req(date: Time.zone.now.to_date.to_s)
      end
    end

    it { expect(response).to have_http_status(:ok) }

    it { expect(json[:turns].count).to eq 1 }
    it { expect(json.dig(:turns, 0, :messages)).to be_a(Array) }
    it { expect(json.dig(:turns, 0, :messages)).to all(be_a(Hash)) }
    it { expect(json.dig(:turns, 0, :messages)).to all(include(message: String)) }
    it { expect(json.dig(:turns, 0, :messages)).to all(include(message: String)) }

    it {
      expect(json.dig(:turns, 0,
                      :messages).pluck(:message)).to contain_exactly("first message", "always present message")
    }
  end
end
