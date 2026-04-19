# frozen_string_literal: true

require "rails_helper"

RSpec.describe V1::Admin::ReservationsController, type: :controller do
  include_context CONTROLLER_UTILS_CONTEXT
  include_context CONTROLLER_AUTHENTICATION_CONTEXT
  include_context TESTS_OPTIMIZATIONS_CONTEXT
  # include_context SIDEKIQ_INLINE_TESTING

  let(:instance) { described_class.new }

  let(:user) { create(:user) }

  context "GET #export" do
    let(:params) do
      {
        created_at_from:,
        created_at_to:,
        status:,
        date_from:,
        date_to:,
        query:
      }
    end
    let(:created_at_from) { nil }
    let(:created_at_to) { nil }
    let(:date_from) { nil }
    let(:date_to) { nil }
    let(:status) { nil }
    let(:query) { nil }

    let(:file) do
      fname = "/tmp/FOR_TEST_PURPOSES#{SecureRandom.hex}Reservations.xlsx"
      File.write(fname, response.body, mode: "wb")
      Roo::Excelx.new(fname)
    end

    def col_index(col_name)
      file.sheet("Prenotazioni").row(1).index(col_name) + 1
    end

    def col_values(col_name)
      file.sheet("Prenotazioni").column(col_index(col_name))[1..]
    end

    it { expect(instance).to respond_to(:export) }

    it do
      expect(described_class).to route(:get, "/v1/admin/reservations/export").to(action: :export,
                                                                                 format: :json)
    end

    def req(pars = params)
      get :export, params: pars
    end

    context "when user is not authenticated" do
      before { req }

      it_behaves_like UNAUTHORIZED
    end

    context "basic" do
      before { authenticate_request(user:) }

      let!(:reservations) do
        create_list(:reservation, 3).tap do |rs|
          create(:reservation_payment, reservation: rs[0], status: :paid)
          create(:reservation_payment, reservation: rs[1], status: :todo)
        end
      end

      it do
        req
        expect(response).to have_http_status(:ok)
      end

      context "checking file" do
        subject { file }

        before { req }

        it { expect(file.sheets).to contain_exactly("Prenotazioni") }
        it { expect(file.sheet("Prenotazioni").row(1)).to include("datetime") }
        it { expect(file.sheet("Prenotazioni").row(1)).to include("id") }
        it { expect(file.sheet("Prenotazioni").row(1)).to include("secret") }
        it { expect(file.sheet("Prenotazioni").row(1)).to include("payment_value") }
        it { expect(file.sheet("Prenotazioni").row(1)).to include("payment_status") }
        it { expect(file.sheet("Prenotazioni").row(1)).to include("payment_hpp_url") }

        it {
          expect(file.sheet("Prenotazioni").column(col_index("id"))).to contain_exactly("id", *reservations.map(&:id))
        }

        it {
          expect(file.sheet("Prenotazioni").column(col_index("payment_hpp_url"))).to include(*ReservationPayment.all.pluck(:hpp_url))
        }

        it { expect(file.sheet("Prenotazioni").column(col_index("payment_status"))).to include("todo", "paid") }

        it {
          expect(col_values("datetime")).to match_array(Reservation.all.map do |r|
                                                          r.datetime.in_time_zone("Rome").strftime("%e/%m/%Y %k:%M").strip
                                                        end)
        }

        it {
          expect(col_values("created_at")).to match_array(Reservation.all.map do |r|
                                                            r.created_at.in_time_zone("Rome").strftime("%e/%m/%Y %k:%M").strip
                                                          end)
        }

        it {
          expect(col_values("updated_at")).to match_array(Reservation.all.map do |r|
                                                            r.updated_at.in_time_zone("Rome").strftime("%e/%m/%Y %k:%M").strip
                                                          end)
        }
      end
    end

    context "when filtering by query" do
      let(:secret) { SecureRandom.hex(30) }
      let(:query) { "#{secret[1..15]}" }

      before do
        authenticate_request(user:)
        create(:reservation, status: :active, notes: secret)
        create(:reservation, status: :active, notes: "mario")
      end

      context "when filtering by query" do
        before { req(query:) }

        it { expect(col_values("notes")).to all(eq(secret)) }
      end

      context "when filtering by query: 'mario'" do
        before { req(query: "mario") }

        it { expect(col_values("notes")).to all(eq("mario")) }
      end
    end

    context "when filtering by status" do
      before do
        authenticate_request(user:)
        create(:reservation, status: :active)
        create(:reservation, status: :cancelled)
      end

      context "when filtering by status: active" do
        before { req(status: "active") }

        it { expect(col_values("status")).to all(eq("active")) }
      end

      context "when filtering by status: cancelled" do
        before { req(status: "cancelled") }

        it { expect(col_values("status")).to all(eq("cancelled")) }
      end
    end

    context "when filtering by datetime" do
      before do
        authenticate_request(user:)
        reservations
      end

      let(:reservations) do
        [
          create(:reservation, datetime: 2.months.ago),
          create(:reservation, datetime: 1.day.ago),
          create(:reservation, datetime: 1.day.from_now)
        ]
      end

      context "when date_from and date_to are blank" do
        before { req }

        let(:date_from) { nil }
        let(:date_to) { nil }

        it { expect(col_values("datetime").count).to eq 3 }
      end

      context do
        before { req }

        let(:date_from) { 1.day.ago.strftime("%Y-%m-%d") }
        let(:date_to) { 2.days.from_now.strftime("%Y-%m-%d") }

        it { expect(col_values("datetime").count).to eq 2 }
        it { expect(col_values("id")).to match_array(reservations[1..].map(&:id)) }
      end

      context do
        before { req }

        let(:date_from) { 1.year.ago.strftime("%Y-%m-%d") }
        let(:date_to) { 2.days.from_now.strftime("%Y-%m-%d") }

        it { expect(col_values("datetime").count).to eq 3 }
        it { expect(col_values("id")).to match_array(reservations.map(&:id)) }
      end

      context do
        before { req }

        let(:date_from) { 1.year.ago.strftime("%Y-%m-%d") }
        let(:date_to) { 1.week.ago.strftime("%Y-%m-%d") }

        it { expect(col_values("datetime").count).to eq 1 }
        it { expect(col_values("id")).to match_array(reservations[0].id) }
      end
    end

    context "when filtering by created_at_from and created_at_to" do
      before do
        authenticate_request(user:)
        travel_to 2.weeks.ago do
          @old = create(:reservation)
        end

        travel_to 5.days.ago do
          @middle = create(:reservation)
        end

        @new = create(:reservation)
      end

      context "when filtering by created_at_from: 1.week.ago and created_at_to: 1.day.ago" do
        let(:created_at_from) { 1.week.ago.strftime("%Y-%m-%d") }
        let(:created_at_to) { 1.day.ago.strftime("%Y-%m-%d") }

        before { req }

        it { expect(col_values("id")).to contain_exactly(@middle.id) }
      end

      context "when filtering by created_at_from: 1.week.ago and created_at_to: Time.zone.now" do
        let(:created_at_from) { 1.week.ago.strftime("%Y-%m-%d") }
        let(:created_at_to) { Time.zone.now.strftime("%Y-%m-%d") }

        before { req }

        it { expect(col_values("id")).to contain_exactly(@middle.id, @new.id) }
      end

      context "when both are blank" do
        let(:created_at_from) { nil }
        let(:created_at_to) { nil }

        before { req }

        it { expect(col_values("id")).to contain_exactly(@old.id, @middle.id, @new.id) }
      end
    end
  end
end
