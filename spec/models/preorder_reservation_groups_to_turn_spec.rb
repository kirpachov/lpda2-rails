# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PreorderReservationGroupsToTurn, type: :model do
  context "a group can have many turns" do
    let(:group) { create(:preorder_reservation_group) }
    let(:turn) { create(:reservation_turn) }

    it { expect(group).to be_valid.and(be_persisted) }
    it { expect(turn).to be_valid.and(be_persisted) }

    it { expect(turn.preorder_reservation_groups).to be_empty }
    it { expect(group.turns).to be_empty }
    it { expect(group.preorder_reservation_groups_to_turn).to be_empty }

    it { expect { group.turns = [turn] }.to change { described_class.count }.by(1) }

    context "when group has turns" do
      before { group.turns = [turn] }

      it { expect { group.destroy! }.not_to(change { ReservationTurn.count }) }
      it { expect { group.destroy! }.to(change { described_class.count }.by(-1)) }

      it { expect { group.turns = [] }.to(change { described_class.count }.by(-1)) }
      it { expect { group.turns = [] }.not_to(change { ReservationTurn.count }) }
    end
  end
end
