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
      min_people: nil
    }
  end

  let(:min_people) { nil }
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

  context "when updating min_people" do
    let(:min_people) { Random.rand(1..10) }
    let(:params) { { min_people: } }

    before do
      group
    end

    it { expect { req }.to(change { group.reload.min_people }.from(nil).to(min_people)) }

    it do
      req
      expect(json.dig(:item)).to include(:min_people)
      expect(json.dig(:item, :min_people)).to eq(min_people)
    end

    it do
      req
      expect(json).not_to include(:message)
      expect(response).to have_http_status(:ok)
    end
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
          table_type_id:,
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

      it {
        expect { req }.to(change do
                            TableTypeToPreorderReservationGroup.where(people_per_turn:).count
                          end.by(1))
      }

      it { expect { req }.to(change { TableTypeToPreorderReservationGroup.where(price:).count }.by(1)) }
    end

    context "when reservation group has table types" do
      before do
        group.add_table_type(table_type:, price: 5, people_per_turn: 15)
      end

      context "when trying to remove table type" do
        let(:table_types) { [] }

        # CHECKING MOCK DATA
        it { expect(group.table_type_to_preorder_reservation_groups.count).to eq(1) }
        it { expect(group.table_types.count).to eq(1) }

        it { expect { req }.to(change { TableTypeToPreorderReservationGroup.count }.by(-1)) }
        it { expect { req }.not_to(change(TableType, :count)) }
        it { expect { req }.not_to(change(PreorderReservationGroup, :count)) }
      end

      context "when adding another table type and removing the previous one" do
        let(:table_types) do
          [
            {
              table_type_id: new_table_type.id,
              people_per_turn: 10,
              price: 87
            }
          ]
        end

        let(:new_table_type) { create(:table_type) }

        # CHECKING MOCK DATA
        it { expect(group.table_type_to_preorder_reservation_groups.count).to eq(1) }
        it { expect(group.table_types.count).to eq(1) }
        it { expect(new_table_type.preorder_reservation_groups).to be_empty }

        it { expect { req }.not_to(change { TableTypeToPreorderReservationGroup.count }) }
        it { expect { req }.to(change { TableTypeToPreorderReservationGroup.where(price: 87).count }.by(1)) }
        it { expect { req }.to(change { new_table_type.reload.preorder_reservation_groups }.from([]).to([group])) }
        it { expect { req }.to(change { table_type.reload.preorder_reservation_groups }.from([group]).to([])) }
      end

      context "when trying to update table type price" do
        let(:price) { 999 }

        # CHECKING MOCK DATA
        it { expect(group.table_type_to_preorder_reservation_groups.count).to eq(1) }
        it { expect(group.table_types.count).to eq(1) }

        it do
          req
          expect(response).to have_http_status(:ok)
        end

        it do
          req
          expect(json).not_to include(:message)
        end

        it { expect { req }.to(change { TableTypeToPreorderReservationGroup.where(price:).count }.by(1)) }
        it { expect { req }.not_to(change { TableTypeToPreorderReservationGroup.count }) }
      end

      context "when updating people_per_turn" do
        let(:people_per_turn) { 8 }

        # CHECKING MOCK DATA
        it { expect(group.table_type_to_preorder_reservation_groups.count).to eq(1) }
        it { expect(group.table_types.count).to eq(1) }

        it do
          req
          expect(response).to have_http_status(:ok)
        end

        it do
          req
          expect(json).not_to include(:message)
        end

        it { expect { req }.to(change { TableTypeToPreorderReservationGroup.where(price:).count }.by(1)) }
        it { expect { req }.not_to(change { TableTypeToPreorderReservationGroup.count }) }
      end
    end
  end

  context "when group existed with 'always' turns and trying to set dates for the same turns (taken from prod. bug)" do
    let(:group) do
      create(:preorder_reservation_group).tap do |g|
        g.turns = [turn]
      end
    end

    it do
      req
      expect(response).to have_http_status(:ok)
    end

    it do
      req
      expect(json).not_to include(:message)
    end

    it { expect { req }.to(change { group.reload.turns.count }.from(1).to(0)) }
    it { expect { req }.to(change { group.reload.dates.count }.from(0).to(1)) }
  end

  context "when a two groups overlapping exist, should not be able to activate one of them" do
    let!(:turn1) { create(:reservation_turn, weekday: 1) }
    let!(:turn2) { create(:reservation_turn, weekday: 2) }
    let!(:turn3) { create(:reservation_turn, weekday: 3) }

    let!(:group1) do
      create(:preorder_reservation_group, status: :inactive).tap do |g|
        g.preorder_reservation_groups_to_turn.create(reservation_turn: turn1)
        g.dates.create(date: Date.current.next_occurring(turn2.weekday_name.to_sym), reservation_turn: turn2)
      end
    end

    let!(:group2) do
      create(:preorder_reservation_group, status: :active).tap do |g|
        g.preorder_reservation_groups_to_turn.create(reservation_turn: turn1)
        g.dates.create(date: Date.current.next_occurring(turn2.weekday_name.to_sym), reservation_turn: turn2)
      end
    end

    context "when trying to activate group1, should FAIL" do
      let(:group) { group1 }

      let(:params) { { status: :active } }

      it do
        expect { req }.not_to(change { [group1.reload.as_json, group2.reload.as_json, PreorderReservationDate.all.as_json, PreorderReservationGroupsToTurn.all.as_json] })
        expect(json).to include(message: /failed/)
        expect(response).not_to be_successful
      end
    end

    context "when trying to deactivate group1, should be successful" do
      let(:group) { group1 }

      let(:params) { { status: :inactive } }

      it do
        expect { req }.not_to(change { [group1.reload.status] })
        expect(json).not_to include(message: String)
        expect(response).to be_successful
      end
    end

    context "when trying to activate group1 after deactivating group2, should be successful" do
      let(:group) { group1 }

      let(:params) { { status: :active } }

      before do
        group2.update!(status: :inactive)
        group1.update!(status: :inactive)
      end

      it do
        expect { req }.to(change { group1.reload.status }.to("active"))
        expect(json).not_to include(message: String)
        expect(response).to be_successful
      end
    end
  end
end
