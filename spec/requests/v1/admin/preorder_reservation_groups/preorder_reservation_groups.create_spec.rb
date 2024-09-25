# frozen_string_literal: true

require "rails_helper"

RSpec.describe "POST /v1/admin/preorder_reservation_groups" do
  include_context REQUEST_AUTHENTICATION_CONTEXT

  let(:headers) { auth_headers }
  let(:params) do
    {
      title: title,
      preorder_type: preorder_type,
      payment_value: payment_value,
      message: message,
      dates: dates,
      active_from: active_from,
      active_to: active_to,
    }
  end
  let(:active_from) { nil }
  let(:active_to) { nil }
  let(:title) { Faker::Lorem.sentence }
  let(:preorder_type) { "nexi_payment" }
  let(:payment_value) { 30 }
  let(:message) { { it: message_it, en: message_en } }
  let(:message_it) { Faker::Lorem.sentence }
  let(:message_en) { Faker::Lorem.sentence }
  let(:dates) do
    [ { date: Date.current.next_occurring(:monday).to_s, turn_id: turn.id } ]
  end

  let(:turn) { create(:reservation_turn, weekday: 1) }

  def req(p = params, h = headers)
    post "/v1/admin/preorder_reservation_groups", headers: h, params: p
  end

  context "when not authenticated" do
    let(:headers) {}

    before { req }

    it { expect(response).to have_http_status(:unauthorized) }

    it { expect(json).to include(message: String) }
  end

  context "when making basic request" do
    it { expect { req }.to(change(PreorderReservationGroup, :count).by(1)) }

    it { expect { req }.to(change(PreorderReservationDate, :count).by(1)) }
    it { expect { req }.to(change { PreorderReservationDate.where(date: dates.dig(0, :date)).count }.by(1)) }

    context "when checking response" do
      before { req }

      it { expect(response).to be_successful }
      it { expect(json).not_to include(message: String) }
      it { expect(json).to be_a(Hash) }
      it do
        item = PreorderReservationGroup.last
        expect(json[:item].symbolize_keys).to include(
          id: item.id,
          title: item.title,
          payment_value: item.payment_value,
          status: "active",
          preorder_type: "nexi_payment",
          active_from: nil,
          active_to: nil
        )
      end

      it { expect(json.dig(:item, :dates).length).to eq 1 }
    end
  end

  context "when providing turns" do
    before { req(params.merge(turns:)) }
    let(:turns) { [create(:reservation_turn).id] }

    it { expect(json.dig(:item, :turns).length).to eq 1 }
    it { expect(json.dig(:item, :turns)).to all(include(id: turns.first, name: String, starts_at: String, ends_at: String, weekday: Integer)) }
    it do
      expect(PreorderReservationGroup.last.turns).to eq(ReservationTurn.where(id: turns))
    end
  end

  context "when another group exists with a turn" do
    let(:turns) { [turn.id] }

    before do
      create(:preorder_reservation_group).tap do |group|
        group.turns = [turn]
      end
    end

    context "when trying to add same turn to a new group" do
      let(:params) { super().merge(turns: turns, dates: nil) }

      it do
        req
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it do
        req
        expect(json).to include(message: /turn has already been taken/)
      end

      it { expect { req }.not_to(change { PreorderReservationGroup.count }) }
      it { expect { req }.not_to(change { PreorderReservationGroupsToTurn.count }) }
    end

    context "when trying to add same turn to a new group" do
      let(:params) { super().merge(turns: nil, dates: dates) }

      it do
        req
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it do
        req
        expect(json).to include(message: String)
      end

      it { expect { req }.not_to(change { PreorderReservationGroup.count }) }
      it { expect { req }.not_to(change { PreorderReservationGroupsToTurn.count }) }
    end
  end

  context "when another group exists with a DATE" do
    let(:turns) { [turn.id] }

    before do
      # create(:preorder_reservation_group).tap do |group|
      #   group.dates = [turn]
      # end
      req
    end

    it { expect(PreorderReservationGroup.count).to eq 1 }
    it { expect(PreorderReservationDate.count).to eq 1 }
    it { expect(PreorderReservationGroupsToTurn.count).to eq 0 }
    it { expect(PreorderReservationGroup.all.last.dates.count).to eq 1 }
    it { expect(PreorderReservationGroup.all.last.dates.first.reservation_turn).to eq(turn) }

    context "when trying to add same turn to a new group" do
      let(:params) { super().merge(turns: turns, dates: nil) }

      it do
        req
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it do
        req
        expect(json).to include(message: /turn has already been taken/)
      end

      it { expect { req }.not_to(change { PreorderReservationGroup.count }) }
      it { expect { req }.not_to(change { PreorderReservationGroupsToTurn.count }) }
    end

    context "when trying to add same turn to a new group" do
      let(:params) { super().merge(turns: nil, dates: dates) }

      it do
        req
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it do
        req
        expect(json).to include(message: String)
      end

      it { expect { req }.not_to(change { PreorderReservationGroup.count }) }
      it { expect { req }.not_to(change { PreorderReservationGroupsToTurn.count }) }
    end
  end

  context "when providing many dates for same turn - real-life scenario where on certain dates the reservations can be created only paying" do
    let(:dates) do
      [
        { date: Date.current.next_occurring(:monday).to_s, turn_id: turn.id },
        { date: (Date.current.next_occurring(:monday) + 7.days).to_s, turn_id: turn.id },
        { date: (Date.current.next_occurring(:monday) + 14.days).to_s, turn_id: turn.id },
        { date: (Date.current.next_occurring(:monday) + 28.days).to_s, turn_id: turn.id },
      ]
    end

    it { expect { req }.to(change { PreorderReservationGroup.count }.by(1)) }
    it { expect { req }.to(change { PreorderReservationDate.count }.by(4)) }
    it { expect { req }.not_to(change { PreorderReservationGroupsToTurn.count }) }

    it do
      req
      expect(json).not_to include(message: String)
    end

    it do
      req
      expect(response).to have_http_status(:ok)
    end

    it do
      req
      expect(json.dig(:item, :dates).length).to eq 4
      expect(json.dig(:item, :dates).pluck(:reservation_turn_id)).to all(eq(turn.id))
    end
  end

  context "when providing many dates for different turns" do
    let(:turn2) { create(:reservation_turn, weekday: 1) }
    let(:turn3) { create(:reservation_turn, weekday: 2) }
    let(:turn4) { create(:reservation_turn, weekday: 2) }

    let(:dates) do
      [
        { date: Date.current.next_occurring(:monday).to_s, turn_id: turn.id },
        { date: (Date.current.next_occurring(:monday) + 7.days).to_s, turn_id: turn.id },
        { date: (Date.current.next_occurring(:monday) + 77.days).to_s, turn_id: turn.id },

        { date: Date.current.next_occurring(:monday).to_s, turn_id: turn2.id },
        { date: (Date.current.next_occurring(:tuesday) + 28.days).to_s, turn_id: turn3.id },
      ]
    end

    let(:params) { super().merge(dates: dates, turns: [turn4.id]) }

    it { expect { req }.to(change { PreorderReservationGroup.count }.by(1)) }
    it { expect { req }.to(change { PreorderReservationDate.count }.by(5)) }
    it { expect { req }.to(change { PreorderReservationGroupsToTurn.count }.by(1)) }

    it do
      req
      expect(json).not_to include(message: String)
    end

    it do
      req
      expect(response).to have_http_status(:ok)
    end

    it do
      req
      expect(json.dig(:item, :dates).length).to eq 5
      expect(json.dig(:item, :dates).pluck(:reservation_turn_id).uniq).to match_array([turn.id, turn2.id, turn3.id])
      expect(json.dig(:item, :turns).pluck(:id)).to eq([turn4.id])
    end
  end

  context "when some group has all turns" do
    let(:turns) do
      turn

      (0..6).each do |n|
        create_list(:reservation_turn, 3, weekday: n)
      end

      ReservationTurn.all
    end

    before do
      # Anytime you want to create a reservation you'll have to pay in this case.
      create(:preorder_reservation_group).tap do |group|
        group.turns = turns
      end
    end

    context "when adding some turn to the new group, should receive 422" do
      let(:some_turn) { turns.sample }
      let(:params) { super().merge(turns: [some_turn.id], dates: []) }

      it do
        req
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it do
        req
        expect(json).to include(message: String)
      end

      it { expect { req }.not_to(change { PreorderReservationGroup.count }) }
      it { expect { req }.not_to(change { PreorderReservationDate.count }) }
      it { expect { req }.not_to(change { PreorderReservationGroupsToTurn.count }) }
    end

    context "when adding some turn to the new group, should receive 422" do
      let(:some_turn) { turn }
      let(:params) { super().merge(turns: [], dates: [{ date: Date.current.next_occurring(:monday).to_s, turn_id: some_turn.id }]) }

      it do
        req
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it do
        req
        expect(json).to include(message: String)
      end

      it { expect { req }.not_to(change { PreorderReservationGroup.count }) }
      it { expect { req }.not_to(change { PreorderReservationDate.count }) }
      it { expect { req }.not_to(change { PreorderReservationGroupsToTurn.count }) }
    end
  end

  context "when adding active_from and active_to" do
    let(:active_from) { "2024-09-23 12:00" }
    let(:active_to) { "2025-09-23 12:00" }

    it { expect { req }.to change { PreorderReservationGroup.where.not(active_from: nil).count }.by(1) }
    it { expect { req }.to change { PreorderReservationGroup.where.not(active_to: nil).count }.by(1) }

    context "when checking response" do
      before { req }

      it { expect(response).to have_http_status(:ok) }
      it { expect(json.dig("item", "active_from")).to be_present }
      it { expect(json.dig("item", "active_to")).to be_present }
    end
  end
end
