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

  context "when there are no turns" do
    before do
      ReservationTurn.delete_all
      req
    end

    it { expect(response).to have_http_status(:ok) }
    it { expect(json[:turns]).not_to include(message: String) }
    it { expect(json[:turns]).to eq [] }
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

    context "when got one weekly holiday overlapping with the only turn" do
      before do
        create(:holiday, from_timestamp: 10.days.ago, to_timestamp: 10.days.from_now, weekday: Time.zone.now.wday,
                         weekly_from: "12:30", weekly_to: "15:00").tap do |h|
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
