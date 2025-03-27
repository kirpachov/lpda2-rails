# frozen_string_literal: true

require "rails_helper"

RSpec.describe PreorderReservationGroup, type: :model do
  context "when deleted, if has turns and groups associated, turns should not be deleted." do
    subject!(:group) do
      create(:preorder_reservation_group).tap do |grp|
        grp.turns = turns
        grp.dates = dates
      end
    end

    let(:turns) { create_list(:reservation_turn, 3) }
    let(:dates) { create_list(:preorder_reservation_date, 3) }

    it { expect(group).to be_valid.and(be_persisted) }
    it { expect(turns).to all(be_valid.and(be_persisted)) }

    it { expect { group.destroy! }.not_to(change { ReservationTurn.count }) }
    it { expect { group.destroy! }.to(change { PreorderReservationDate.count }.by(-3)) }
    it { expect { group.destroy! }.to(change { PreorderReservationGroupsToTurn.count }.by(-3)) }
  end

  context "when deleted, if any table types associated, will delete associations but not the table types" do
    let!(:table_types) { create_list(:table_type, 3) }
    let!(:group) do
      create(:preorder_reservation_group).tap do |grp|
        table_types.each do |tt|
          grp.add_table_type!(table_type: tt, people_per_turn: 11, price: 12)
        end
      end
    end

    it { expect(group).to be_valid.and(be_persisted) }
    it { expect(table_types).to all(be_valid.and(be_persisted)) }
    it { expect(group.table_types.count).to eq(3) }
    it { expect(table_types.sample.preorder_reservation_groups.count).to eq(1) }
    it { expect(table_types.sample.preorder_reservation_groups.first).to eq(group) }

    it { expect { group.destroy! }.to(change { TableTypeToPreorderReservationGroup.count }.to(0)) }
    it { expect { group.destroy! }.to(change { PreorderReservationGroup.count }.to(0)) }
    it { expect { group.destroy! }.not_to(change { TableType.count }) }
  end
end
