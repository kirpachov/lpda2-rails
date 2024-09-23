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
      active_to: active_to
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

      it do
        expect(json.dig(:item, :dates).length).to eq 1
      end
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
