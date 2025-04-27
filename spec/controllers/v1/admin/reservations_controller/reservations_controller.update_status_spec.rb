# frozen_string_literal: true

require "rails_helper"

RSpec.describe V1::Admin::ReservationsController, type: :controller do
  include_context CONTROLLER_UTILS_CONTEXT
  include_context CONTROLLER_AUTHENTICATION_CONTEXT
  # include_context TESTS_OPTIMIZATIONS_CONTEXT
  include_context SIDEKIQ_INLINE_TESTING

  let(:instance) { described_class.new }

  let(:user) { create(:user) }

  describe "PATCH #update_status" do
    let(:status) { "arrived" }
    let(:reservation) { create(:reservation) }

    it { expect(instance).to respond_to(:update) }

    it {
      expect(described_class).to route(:patch, "/v1/admin/reservations/2/status/arrived").to(status: "arrived",
                                                                                             action: :update_status, id: "2", format: :json)
    }

    def req(id = reservation.id, status2set = status)
      patch :update_status, params: { id:, status: status2set }
    end

    context "when user is not authenticated" do
      before { req }

      it_behaves_like UNAUTHORIZED
    end

    context "when user is authenticated" do
      before { authenticate_request }

      context "when trying to update a non-existing reservation" do
        subject { response }

        before { req(999_999) }

        it_behaves_like NOT_FOUND
      end

      context "when updating status to arrived" do
        let(:status) { "arrived" }

        it do
          expect { req }.to change { reservation.reload.status }.from(reservation.status).to(status)
          expect(parsed_response_body).to include(item: Hash)
          expect(parsed_response_body[:item]).to include(id: Integer, status:, created_at: String)
          expect(response).to have_http_status(:ok)
          expect(json[:item]).to have_key("cancelled_at")
          expect(json[:item]).to have_key(:cancelled_at)
          expect(json[:item][:cancelled_at]).to be_nil
        end
      end

      context "when updating status to noshow" do
        let(:status) { "noshow" }

        it do
          expect { req }.to change { reservation.reload.status }.from(reservation.status).to(status)
          expect(parsed_response_body).to include(item: Hash)
          expect(parsed_response_body[:item]).to include(id: Integer, status:, created_at: String)
          expect(response).to have_http_status(:ok)
          expect(json[:item]).to have_key("cancelled_at")
          expect(json[:item]).to have_key(:cancelled_at)
          expect(json[:item][:cancelled_at]).to be_nil
        end
      end

      context "when updating status to cancelled" do
        let(:status) { "cancelled" }

        it do
          expect { req }.to change { reservation.reload.status }.from(reservation.status).to(status)
          expect(parsed_response_body).to include(item: Hash)
          expect(parsed_response_body[:item]).to include(id: Integer, status:, created_at: String)
          expect(response).to have_http_status(:ok)
          expect(json[:item]).to have_key("cancelled_at")
          expect(json[:item]).to have_key(:cancelled_at)
          expect(json[:item][:cancelled_at]).to be_a(String)
          expect(json[:item][:cancelled_at]).to include(Time.now.strftime("%Y-%m-%d"))
        end
      end

      context "when updating status to deleted" do
        let(:status) { "deleted" }

        it do
          expect { req }.not_to(change { reservation.reload.status })
          expect(parsed_response_body).to include(message: String, details: Hash)
          expect(response).to have_http_status(:bad_request)
          expect(parsed_response_body[:message].to_s.downcase).to include("status")
        end
      end
    end
  end
end
