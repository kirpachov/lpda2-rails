# frozen_string_literal: true

require "rails_helper"

RSpec.describe V1::Admin::ReservationsController, type: :controller do
  include_context CONTROLLER_UTILS_CONTEXT
  include_context CONTROLLER_AUTHENTICATION_CONTEXT
  include_context TESTS_OPTIMIZATIONS_CONTEXT
  # include_context SIDEKIQ_INLINE_TESTING

  let(:instance) { described_class.new }

  let(:user) { create(:user) }

  describe "DELETE #destroy" do
    let(:reservation) { create(:reservation) }

    it { expect(instance).to respond_to(:destroy) }

    it {
      expect(described_class).to route(:delete, "/v1/admin/reservations/2").to(action: :destroy, id: "2", format: :json)
    }

    def req(id = reservation.id)
      delete :destroy, params: { id: }
    end

    context "when user is not authenticated" do
      before { req }

      it_behaves_like UNAUTHORIZED
    end

    context "(authenticated)" do
      before { authenticate_request }

      it do
        reservation
        expect { req(reservation.id) }.not_to change(Reservation, :count)
      end

      it do
        reservation
        expect { req(reservation.id) }.to change { Reservation.visible.count }.by(-1)
      end

      it do
        expect { req(reservation.id) }.to change { reservation.reload.status }.from(reservation.status).to("deleted")
      end

      context "when trying to delete a non-existing reservation" do
        subject { response }

        before { req(999_999) }

        it_behaves_like NOT_FOUND
      end
    end
  end
end
