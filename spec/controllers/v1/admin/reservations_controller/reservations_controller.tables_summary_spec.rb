# frozen_string_literal: true

require "rails_helper"

RSpec.describe V1::Admin::ReservationsController, type: :controller do
  include_context CONTROLLER_UTILS_CONTEXT
  include_context CONTROLLER_AUTHENTICATION_CONTEXT
  include_context TESTS_OPTIMIZATIONS_CONTEXT
  # include_context SIDEKIQ_INLINE_TESTING

  let(:instance) { described_class.new }

  let(:user) { create(:user) }

  describe "GET #tables_summary" do
    it { expect(instance).to respond_to(:tables_summary) }

    it {
      expect(described_class).to route(:get, "/v1/admin/reservations/tables_summary").to(action: :tables_summary,
                                                                                         format: :json)
    }

    def req(params = { date: Time.zone.yesterday.to_date.to_s })
      get :tables_summary, params:
    end

    context "when user is not authenticated" do
      before { req }

      it_behaves_like UNAUTHORIZED
    end

    context "when user is authenticated" do
      before { authenticate_request(user:) }

      context "when param :date is missing" do
        subject { response }

        before do
          create(:reservation)
          req({ date: nil })
        end

        it { is_expected.to have_http_status(:bad_request) }
        it { expect(parsed_response_body).to include(message: /date/) }
      end

      context "when param :date is invalid" do
        subject { response }

        before do
          create(:reservation)
          req(date: "today")
        end

        it { is_expected.to have_http_status(:bad_request) }
        it { expect(parsed_response_body).to include(message: /date/) }
      end

      context "when searching by date" do
        let!(:reservations) do
          [
            create(:reservation, status: :active, datetime: 1.day.from_now, adults: 1),
            create(:reservation, status: :active, datetime: Time.now, adults: 2),
            create(:reservation, status: :active, datetime: 1.day.ago, adults: 3),
            create(:reservation, status: :active, datetime: 2.days.ago, adults: 4),
            create(:reservation, status: :active, datetime: 3.days.ago, adults: 5)
          ]
        end

        let!(:reservation_turns) do
          (0..6).each do |weekday|
            ReservationTurn.create!(name: "Day", weekday:, starts_at: "00:01", ends_at: "23:59")
          end
        end

        context "when filtering both time and date, should return only the only necessary turn" do
          let!(:reservation_turns) do
            (0..6).each do |weekday|
              ReservationTurn.create!(name: "Pranzo", weekday:, starts_at: "08:00", ends_at: "14:00")
              ReservationTurn.create!(name: "Cena", weekday:, starts_at: "19:00", ends_at: "21:00")
            end
          end

          let!(:reservations) do
            [
              # LUNCH
              create(:reservation, status: :active, datetime: Time.zone.yesterday.beginning_of_day + 9.hours,
                                   adults: 1),
              create(:reservation, status: :cancelled, datetime: Time.zone.yesterday.beginning_of_day + 9.hours,
                                   adults: 1),
              create(:reservation, status: :deleted, datetime: Time.zone.yesterday.beginning_of_day + 9.hours,
                                   adults: 1),
              create(:reservation, status: :active, datetime: Time.zone.yesterday.beginning_of_day + 13.hours,
                                   adults: 2),
              create(:reservation, status: :cancelled, datetime: Time.zone.yesterday.beginning_of_day + 13.hours,
                                   adults: 2),
              create(:reservation, status: :deleted, datetime: Time.zone.yesterday.beginning_of_day + 13.hours,
                                   adults: 2),
              create(:reservation, status: :arrived, datetime: Time.zone.yesterday.beginning_of_day + 13.hours,
                                   adults: 2),

              # DINNER
              create(:reservation, status: :active, datetime: Time.zone.yesterday.beginning_of_day + 20.hours,
                                   adults: 3),
              create(:reservation, status: :cancelled, datetime: Time.zone.yesterday.beginning_of_day + 20.hours,
                                   adults: 3),
              create(:reservation, status: :active, datetime: Time.zone.yesterday.beginning_of_day + 20.hours,
                                   adults: 4),
              create(:reservation, status: :deleted, datetime: Time.zone.yesterday.beginning_of_day + 20.hours,
                                   adults: 4),
              create(:reservation, status: :arrived, datetime: Time.zone.yesterday.beginning_of_day + 20.hours,
                                   adults: 15),
              create(:reservation, status: :active, datetime: Time.zone.yesterday.beginning_of_day + 20.hours,
                                   adults: 4)
            ]
          end

          context "when filtering by today for lunch time" do
            subject { response }

            before { req(date: Time.zone.yesterday.to_date.to_s, time: "10:00") }

            it { is_expected.to have_http_status(:ok) }
            it { expect(parsed_response_body).not_to include(message: String) }
            it { expect(parsed_response_body).to all(include("summary" => Hash, "turn" => Hash)) }
            it { expect(parsed_response_body.count).to eq 1 }
            it { expect(parsed_response_body[0]["summary"]).to eq("1" => 1, "2" => 1) }
          end

          context "when filtering by today for dinner time" do
            subject { response }

            before { req(date: Time.zone.yesterday.to_date.to_s, time: "21:00") }

            it { is_expected.to have_http_status(:ok) }
            it { expect(parsed_response_body).not_to include(message: String) }
            it { expect(parsed_response_body).to all(include("summary" => Hash, "turn" => Hash)) }
            it { expect(parsed_response_body.count).to eq 1 }
            it { expect(parsed_response_body[0]["summary"]).to eq("3" => 1, "4" => 2) }
          end

          context "when filtering for today but when there are no turns" do
            subject { response }

            before { req(date: Time.zone.yesterday.to_date.to_s, time: "1:00") }

            it { is_expected.to have_http_status(:ok) }
            it { expect(parsed_response_body).not_to include(message: String) }
            it { expect(parsed_response_body.count).to eq 0 }
          end
        end

        context "when filtering by today with {date: Date.today.to_date}" do
          subject { response }

          before { req(date: Date.today.to_date) }

          it { is_expected.to have_http_status(:ok) }
          it { expect(parsed_response_body).not_to include(message: String) }
          it { expect(parsed_response_body).to all(include("summary" => Hash, "turn" => Hash)) }
          it { expect(parsed_response_body[0]["summary"]).to eq("2" => 1) }
        end

        context "when filtering by today with {date: Date.yesterday.to_date}" do
          subject { response }

          before { req(date: Date.yesterday.to_date) }

          it { is_expected.to have_http_status(:ok) }
          it { expect(parsed_response_body).not_to include(message: String) }
          it { expect(parsed_response_body[0]["summary"]).to eq("3" => 1) }
        end
      end
    end
  end
end
