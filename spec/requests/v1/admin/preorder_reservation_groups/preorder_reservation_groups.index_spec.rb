# frozen_string_literal: true

require "rails_helper"

RSpec.describe "GET /v1/admin/preorder_reservation_groups" do
  include_context REQUEST_AUTHENTICATION_CONTEXT

  let(:headers) { auth_headers }
  let(:params) { { } }

  let(:groups) do
    create(:preorder_reservation_group).tap { |g| g.turns = [create(:reservation_turn, weekday: 1)] }
    create(:preorder_reservation_group, status: :inactive).tap { |g| g.turns = [create(:reservation_turn, weekday: 2)] }
    create(:preorder_reservation_group).tap do |g|
      weekday = Random.rand(3..5)
      g.dates.create!(
        date: Date.current.next_occurring(ReservationTurn::WEEKDAYS[weekday].to_sym),
        reservation_turn: create(:reservation_turn, weekday: weekday)
      )
    end

    PreorderReservationGroup.all
  end

  def req(p = params, h = headers)
    get "/v1/admin/preorder_reservation_groups", headers: h, params: p
  end

  context "when not authenticated" do
    let(:headers) {}

    before { req }

    it { expect(response).to have_http_status(:unauthorized) }

    it { expect(json).to include(message: String) }
  end

  context "when making basic request" do
    before do
      groups
      req
    end

    it { expect(response).to have_http_status(:ok) }
    it { expect(json).to include(items: Array) }
    it { expect(json[:items].size).to eq(groups.size) }
    it { expect(json[:items].pluck(:status)).to match_array(%w[active active inactive]) }

    context "checking item structure" do
      subject(:item) { json[:items].sample }

      let(:record) { PreorderReservationGroup.find(item[:id]) }

      before { record }

      it { expect(item).to include(id: record.id, status: record.status, active_from: nil, active_to: nil, payment_value: record.payment_value, created_at: String, updated_at: String) }
      it { expect(item).to include(turns: Array) }
      it { expect(item).to include(dates: Array) }
      it { expect(item[:turns]).to all(include(id: Integer, name: String, starts_at: String, ends_at: String, weekday: Integer, step: Integer, created_at: String, updated_at: String)) }
      it { expect(item[:dates]).to all(include(reservation_turn_id: Integer, reservation_turn: Hash, date: String)) }

      it "should either have dates or turns" do
        expect(item[:turns].length + item[:dates].length).to be_positive
      end
    end
  end

  context "when filtering for { query: <partial-name> }" do
    before do
      create(:preorder_reservation_group, title: "Mario #{SecureRandom.hex}")
      create(:preorder_reservation_group, title: "Mario Gianni #{SecureRandom.hex}")
    end

    it do
      req(params.merge(query: "Mario"))
      expect(json[:items].length).to eq 2
    end

    it do
      req(params.merge(query: "mario"))
      expect(json[:items].length).to eq 2
    end

    it do
      req(params.merge(query: ""))
      expect(json[:items].length).to eq 2
    end

    it do
      req(params.merge(query: "Gianni"))
      expect(json[:items].length).to eq 1
    end

    it do
      req(params.merge(query: "ianni"))
      expect(json[:items].length).to eq 1
    end

    it do
      req(params.merge(query: PreorderReservationGroup.all.sample.title))
      expect(json[:items].length).to eq 1
    end

    it do
      req(params.merge(query: PreorderReservationGroup.all.sample.title.downcase))
      expect(json[:items].length).to eq 1
    end

    it do
      req(params.merge(query: PreorderReservationGroup.all.sample.title.downcase[-5..]))
      expect(json[:items].length).to eq 1
    end
  end

  [true, "true", "1", 1].each do |param_value|
    context "when filtering for {active_now: #{param_value.inspect}}" do
      let(:will_deactivate) { create(:preorder_reservation_group, active_to: 1.year.from_now) }
      let(:active_for_now) { create(:preorder_reservation_group, active_from: 1.year.ago, active_to: 1.year.from_now) }
      let(:active) { create(:preorder_reservation_group) }
      let!(:all_active) {
        [will_deactivate, active_for_now, active]
      }

      let(:will_activate) { create(:preorder_reservation_group, active_from: 1.year.from_now) }
      let(:inactive) { create(:preorder_reservation_group, status: :inactive) }
      let!(:all_inactive) {
        [will_activate, inactive]
      }

      before do
        req(params.merge(active_now: param_value))
      end

      it { expect(json[:items].length).to eq(all_active.count) }
      it { expect(json[:items].pluck(:id)).to match_array(all_active.map(&:id)) }
      it { expect(json).not_to include(:message) }
      it { expect(response).to have_http_status(:ok) }
    end
  end
end
