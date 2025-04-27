# frozen_string_literal: true

require "rails_helper"

RSpec.describe V1::Admin::ReservationsController, type: :controller do
  include_context CONTROLLER_UTILS_CONTEXT
  include_context CONTROLLER_AUTHENTICATION_CONTEXT
  include_context TESTS_OPTIMIZATIONS_CONTEXT
  # include_context SIDEKIQ_INLINE_TESTING

  let(:instance) { described_class.new }

  let(:user) { create(:user) }

  context "POST #add_tag" do
    let(:tag) { create(:reservation_tag) }
    let(:reservation) { create(:reservation) }

    it {
      expect(described_class).to route(:post, "/v1/admin/reservations/2/add_tag/3").to(tag_id: "3", action: :add_tag,
                                                                                       id: "2", format: :json)
    }

    it { expect(instance).to respond_to(:add_tag) }

    def req(reservation_id = reservation.id, tag_id = tag.id)
      post :add_tag, params: { id: reservation_id, tag_id: }
    end

    context "when user is not authenticated" do
      before { req }

      it_behaves_like UNAUTHORIZED
    end

    context "when user is authenticated" do
      before { authenticate_request }

      context "when trying to update a non-existing reservation" do
        subject { response }

        before { req(999_999, tag.id) }

        it_behaves_like NOT_FOUND
      end

      context "when trying to add a non-existing tag" do
        subject { response }

        before { req(reservation.id, 999_999_99) }

        it_behaves_like NOT_FOUND
      end

      context "when reservation and tag are valid" do
        before do
          reservation
          tag
        end

        it { expect { req }.to change { TagInReservation.count }.by(1) }
        it { expect { req }.not_to(change { Reservation.count }) }
        it { expect { req }.not_to(change { ReservationTag.count }) }
        it { expect { req }.to change { reservation.reload.tags.count }.from(0).to(1) }
        it { expect { req }.not_to(change { tag.reload.as_json }) }

        it "is successful" do
          req
          expect(parsed_response_body).to include(item: Hash)
          expect(response).to have_http_status(:ok)
          expect(parsed_response_body[:item]).to include(id: Integer, created_at: String)
          expect(parsed_response_body[:item]).to include(tags: Array)
          expect(parsed_response_body.dig(:item, :tags).count).to eq 1
        end

        it "can try to add twice the tag, will be added just once." do
          expect { req }.to change { TagInReservation.count }.by(1)
          expect(response).to have_http_status(:ok)
          expect { req }.not_to(change { TagInReservation.count })
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end

      context "when cannot add tag for some reason" do
        let(:error_msg) { "OOps some invalid value here" }

        before do
          reservation
          tag
          allow_any_instance_of(TagInReservation).to receive(:valid?).and_return(false)
          errors = ActiveModel::Errors.new(TagInReservation.new)
          errors.add(:base, error_msg)
          allow_any_instance_of(TagInReservation).to receive(:errors).and_return(errors)
        end

        it { expect { req }.not_to(change { TagInReservation.count }) }

        it "returns 422 with message" do
          req
          expect(parsed_response_body).to include(message: String)
          expect(response).to have_http_status(:unprocessable_entity)
          expect(parsed_response_body[:message]).to include(error_msg)
        end
      end
    end
  end
end
