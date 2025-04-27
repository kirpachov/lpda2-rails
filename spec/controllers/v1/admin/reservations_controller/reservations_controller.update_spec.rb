# frozen_string_literal: true

require "rails_helper"

RSpec.describe V1::Admin::ReservationsController, type: :controller do
  include_context CONTROLLER_UTILS_CONTEXT
  include_context CONTROLLER_AUTHENTICATION_CONTEXT
  include_context TESTS_OPTIMIZATIONS_CONTEXT
  # include_context SIDEKIQ_INLINE_TESTING

  let(:instance) { described_class.new }

  let(:user) { create(:user) }

  describe "PATCH #update" do
    let(:params) { {} }
    let(:reservation) { create(:reservation) }

    it { expect(instance).to respond_to(:update) }

    it {
      expect(described_class).to route(:patch, "/v1/admin/reservations/2").to(action: :update, id: "2", format: :json)
    }

    def req(id = reservation.id, data = params)
      patch :update, params: data.merge(id:)
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

      context "when trying to update a non-existing reservation" do
        subject { response }

        before { req(999_999) }

        it_behaves_like NOT_FOUND
      end

      context "when updating adults" do
        let(:params) { { adults: 10 } }

        it do
          expect { req }.to change { reservation.reload.adults }.from(reservation.adults).to(10)
        end
      end

      context "when updating fullname" do
        let(:fullname) { "Anne Marie" + SecureRandom.hex }
        let(:params) { { fullname: } }

        it do
          expect { req }.to change { reservation.reload.fullname }.from(reservation.fullname).to(fullname)
        end
      end

      context "when updating datetime" do
        let(:datetime) { reservation.datetime + 1.day }
        let(:params) { { datetime: } }

        it do
          expect { req }.to change { reservation.reload.datetime }.from(reservation.datetime).to(datetime)
        end
      end

      context "when updating table" do
        let(:table) { "204" }
        let(:params) { { table: } }

        it do
          expect { req }.to change { reservation.reload.table }.from(reservation.table).to(table)
        end
      end

      context "when updating notes" do
        let(:notes) { "Please be kind" + SecureRandom.hex }
        let(:params) { { notes: } }

        it do
          expect { req }.to change { reservation.reload.notes }.from(reservation.notes).to(notes)
        end
      end

      context "when updating email" do
        let(:email) { "giuly@presley" + SecureRandom.hex }
        let(:params) { { email: } }

        it do
          expect { req }.to change { reservation.reload.email }.from(reservation.email).to(email)
        end
      end

      context "when updating phone" do
        let(:phone) { "123 333 333" }
        let(:params) { { phone: } }

        it do
          expect { req }.to change { reservation.reload.phone }.from(reservation.phone).to(phone)
        end
      end

      context "when updating status: does nothing" do
        let(:params) { { status: :cancelled } }

        it do
          reservation.active!

          expect { req }.not_to change { reservation.reload.status }.from(reservation.status)
        end
      end
    end
  end
end
