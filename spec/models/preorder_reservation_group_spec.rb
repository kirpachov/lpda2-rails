# frozen_string_literal: true

require 'rails_helper'

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
end
