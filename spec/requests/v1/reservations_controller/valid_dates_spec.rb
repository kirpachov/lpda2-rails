# frozen_string_literal: true

require "rails_helper"

RSpec.context "GET /v1/reservations/valid_dates", type: :request do
  let(:from_date) { (Time.zone.now.to_date - 2.days).to_s }
  let(:to_date) { (Time.zone.now.to_date + 2.days).to_s }
  let(:params) { { from_date:, to_date: } }

  def req(_params = params)
    get "/v1/reservations/valid_dates", params: _params
  end

  context "when there are no turns" do
    before do
      ReservationTurn.delete_all
      req
    end

    it { expect(response).to have_http_status(:ok) }
    it { expect(json).to eq [] }
  end

  context "when there are turns: one turn for each day" do
    subject { response }

    before do
      (0..6).each do |weekday|
        ReservationTurn.create!(name: "Day", weekday:, starts_at: "12:00", ends_at: "14:00", step: 30)
      end

      travel_to Time.zone.now.beginning_of_day do
        req
      end
    end

    it { is_expected.to have_http_status(:ok) }
    it { expect(json).not_to include(message: String) }
    it do
      expect(json).to eq([
        (Time.zone.now.to_date).to_s,
        (Time.zone.now.to_date + 1.days).to_s,
        (Time.zone.now.to_date + 2.days).to_s,
      ])
    end

    context "when querying after all turns ended" do
      before do
        travel_to Time.zone.now.end_of_day do
          req
        end
      end

      it { is_expected.to have_http_status(:ok) }
      it "dates list should not include today" do
        expect(json).to eq([
          (Time.zone.now.to_date + 1.days).to_s,
          (Time.zone.now.to_date + 2.days).to_s,
        ])
      end
    end

    context "when setting :reservation_max_days_in_advance to 5, will return from today to 5 days forward" do
      before do
        Setting.find_or_initialize_by(key: :reservation_max_days_in_advance).update!(value: 5)

        travel_to Time.zone.now.beginning_of_day do
          req({})
        end
      end

      it { is_expected.to have_http_status(:ok) }
      it { expect(json).to eq((Time.zone.now.to_date..(Time.zone.now.to_date + 5.days)).map(&:to_s)) }
    end
  end
end
