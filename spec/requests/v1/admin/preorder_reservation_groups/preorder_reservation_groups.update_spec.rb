# frozen_string_literal: true

require "rails_helper"

RSpec.describe "PATCH /v1/admin/preorder_reservation_groups/:id" do
  include_context REQUEST_AUTHENTICATION_CONTEXT
  let(:current_user_root_at) { Time.zone.now }

  let(:headers) { auth_headers }
  let(:params) do
    {
      title:,
      preorder_type:,
      payment_value:,
      message:,
      dates:,
      active_from:,
      active_to:,
      table_types:,
    }
  end

  let(:active_from) { nil }
  let(:active_to) { nil }
  let(:title) { "#{Faker::Lorem.sentence} #{SecureRandom.hex}" }
  let(:preorder_type) { "nexi_payment" }
  let(:payment_value) { 30 }
  let(:message) { { it: message_it, en: message_en } }
  let(:message_it) { Faker::Lorem.sentence }
  let(:message_en) { Faker::Lorem.sentence }
  let(:table_types) { [] }
  let(:dates) do
    [{ date: Date.current.next_occurring(:monday).to_s, turn_id: turn.id }]
  end

  let(:turn) { create(:reservation_turn, weekday: 1) }
  let(:group) do
    create(:preorder_reservation_group).tap do |g|
      weekday = Random.rand(3..5)
      g.dates.create!(
        date: Date.current.next_occurring(ReservationTurn::WEEKDAYS[weekday].to_sym),
        reservation_turn: create(:reservation_turn, weekday:)
      )
    end
  end

  def req(id = group.id, p = params, h = headers)
    patch "/v1/admin/preorder_reservation_groups/#{id}", headers: h, params: p
  end

  context "when not authenticated" do
    let(:headers) { {} }

    before { req }

    it { expect(response).to have_http_status(:unauthorized) }

    it { expect(json).to include(message: String) }
  end

  context "when current user is not root" do
    let(:current_user_root_at) { nil }

    before { req }

    it { expect(response).to have_http_status(:forbidden) }

    it { expect(json).to include(message: String) }
  end

  context "when updating title" do
    let(:params) { { title: } }

    it { expect { req }.to(change { group.reload.title }.to(title)) }

    it do
      req
      expect(json).not_to include(:message)
      expect(response).to have_http_status(:ok)
    end
  end

  context "when updating active_from" do
    let(:active_from) { "2024-09-10" }
    let(:params) { { active_from: } }

    it { expect { req }.to(change { group.reload.active_from }.from(nil)) }

    it do
      req
      expect(json.dig(:item)).to include(:active_from)
      expect(json.dig(:item, :active_from)).to include(active_from)
    end

    it do
      req
      expect(json).not_to include(:message)
      expect(response).to have_http_status(:ok)
    end
  end

  context "when updating active_to" do
    let(:active_to) { "2024-09-10" }
    let(:params) { { active_to: } }

    before do
      group.turns = [create(:reservation_turn)]
    end

    it { expect { req }.to(change { group.reload.active_to }.from(nil)) }
    it { expect { req }.not_to(change { group.reload.turns.count }) }
    it { expect { req }.not_to(change { group.reload.dates.count }) }

    it do
      req
      expect(json.dig(:item, :active_to)).to include(active_to)
    end

    it do
      req
      expect(json).not_to include(:message)
      expect(response).to have_http_status(:ok)
    end
  end

  context "when updating dates but providing already associated turns and dates" do
    let(:params) { { dates: } }
    let(:dates) { group.dates.map { |d| { date: d.date.to_s, turn_id: d.reservation_turn_id } } }

    before do
      group
    end

    it { expect { req }.not_to(change { group.reload.dates.count }) }
    # it { expect { req }.not_to(change { group.reload.dates.as_json }) }

    it do
      req
      expect(json).not_to include(:message)
      expect(response).to have_http_status(:ok)
    end
  end

  [
    nil,
    []
  ].each do |blank_val|
    context "when updating dates to #{blank_val.inspect}" do
      let(:params) { { dates: blank_val } }

      before { group }

      it { expect { req }.to(change { group.reload.dates.count }.from(1).to(0)) }

      it do
        req
        expect(json).not_to include(:message)
        expect(response).to have_http_status(:ok)
      end
    end
  end

  context "when updating turns to already associated turns" do
    let(:params) { { turns: group.turns.pluck(:id) } }

    before { group }

    it { expect { req }.not_to(change { group.reload.turns.count }) }

    it do
      req
      expect(json).not_to include(:message)
      expect(response).to have_http_status(:ok)
    end
  end

  [
    nil,
    []
  ].each do |blank_val|
    context "when updating turns to #{blank_val.inspect}" do
      let(:params) { { turns: blank_val } }

      before do
        group.turns = [create(:reservation_turn)]
      end

      it { expect { req }.to(change { group.reload.turns.count }.from(1).to(0)) }

      it do
        req
        expect(json).not_to include(:message)
        expect(response).to have_http_status(:ok)
      end
    end
  end

  %w[active inactive].each do |starting_status|
    %w[active inactive].each do |ending_status|
      next unless starting_status != ending_status

      context "when updating status from #{starting_status.inspect} to #{ending_status.inspect}" do
        before { group.update!(status: starting_status) }

        let(:params) { { status: ending_status } }

        it { expect { req }.to(change { group.reload.status }.from(starting_status).to(ending_status)) }

        it do
          req
          expect(json.dig(:item, :status)).to eq(ending_status)
        end

        it do
          req
          expect(json).not_to include(:message)
          expect(response).to have_http_status(:ok)
        end
      end
    end
  end

  context "when providing table types" do
    let!(:table_type) { create(:table_type) }

    let(:price) { Random.rand(0..5) }
    let(:people_per_turn) { Random.rand(1..30) }
    let(:table_type_id) { table_type.id }

    let(:table_types) do
      [
        {
          table_type_id: table_type_id,
          people_per_turn:,
          price:
        }
      ]
    end

    before { group }

    context "when table_type with that id does not exist" do
      let(:table_type_id) { 999_999_999 }

      context "when checking response" do
        before { req }

        it { expect(response).not_to have_http_status(:ok) }
        it { expect(json).to include(message: String) }
      end

      it { expect { req }.not_to(change(PreorderReservationGroup, :count)) }
      it { expect { req }.not_to(change { TableTypeToPreorderReservationGroup.count }) }
    end

    context "when table_type with that id is not active" do
      before { table_type.inactive! }

      context "when checking response" do
        before { req }

        it { expect(response).not_to have_http_status(:ok) }
        it { expect(json).to include(message: String) }
      end

      it { expect { req }.not_to(change(PreorderReservationGroup, :count)) }
      it { expect { req }.not_to(change { TableTypeToPreorderReservationGroup.count }) }
    end

    context "should associate table types to preorder group" do
      context "when checking response" do
        before { req }

        it { expect(response).to have_http_status(:ok) }
        it { expect(json).not_to include(:message) }
      end

      it { expect { req }.to(change { TableTypeToPreorderReservationGroup.count }.by(1)) }
      it { expect { req }.to(change { TableTypeToPreorderReservationGroup.where(people_per_turn: people_per_turn).count }.by(1)) }
      it { expect { req }.to(change { TableTypeToPreorderReservationGroup.where(price: price).count }.by(1)) }
    end
  end
end
