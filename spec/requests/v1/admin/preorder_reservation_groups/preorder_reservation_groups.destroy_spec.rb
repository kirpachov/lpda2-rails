# frozen_string_literal: true

require "rails_helper"

RSpec.describe "DELETE /v1/admin/preorder_reservation_groups/:id" do
  include_context REQUEST_AUTHENTICATION_CONTEXT

  let(:headers) { auth_headers }
  let(:params) { {} }
  let(:group) do
    create(:preorder_reservation_group).tap do |g|
      weekday = Random.rand(1..5)
      g.dates.create!(
        date: Date.current.next_occurring(ReservationTurn::WEEKDAYS[weekday].to_sym),
        reservation_turn: create(:reservation_turn, weekday:)
      )

      g.turns = [create(:reservation_turn, weekday: Random.rand(1..5))]
    end
  end

  def req(id = group.id, p = params, h = headers)
    delete "/v1/admin/preorder_reservation_groups/#{id}", headers: h, params: p
  end

  context "when not authenticated" do
    let(:headers) {}

    before { req }

    it { expect(response).to have_http_status(:unauthorized) }

    it { expect(json).to include(message: String) }
  end

  context "when deleting, will delete associated dates but won't touch turns" do
    before do
      group

      create(:reservation_payment, reservation: create(:reservation))
    end

    it { expect { req }.to(change(PreorderReservationGroup, :count).by(-1)) }
    it { expect { req }.to(change(PreorderReservationDate, :count).by(-1)) }
    it { expect { req }.to(change(PreorderReservationGroupsToTurn, :count).by(-1)) }

    it { expect { req }.not_to(change(ReservationPayment, :count)) }
    it { expect { req }.not_to(change(ReservationTurn, :count)) }
    it { expect { req }.not_to(change(Reservation, :count)) }
  end
end
