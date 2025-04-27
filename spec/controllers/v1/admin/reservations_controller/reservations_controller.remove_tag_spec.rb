# frozen_string_literal: true

require "rails_helper"

RSpec.describe V1::Admin::ReservationsController, type: :controller do
  include_context CONTROLLER_UTILS_CONTEXT
  include_context CONTROLLER_AUTHENTICATION_CONTEXT
  include_context TESTS_OPTIMIZATIONS_CONTEXT
  # include_context SIDEKIQ_INLINE_TESTING

  let(:instance) { described_class.new }

  let(:user) { create(:user) }

  context "DELETE #remove_tag" do
    let(:tag) { create(:reservation_tag) }
    let(:reservation) { create(:reservation) }

    it {
      expect(described_class).to route(:delete, "/v1/admin/reservations/2/remove_tag/3").to(tag_id: "3",
                                                                                            action: :remove_tag, id: "2", format: :json)
    }

    it { expect(instance).to respond_to(:remove_tag) }

    def req(reservation_id = reservation.id, tag_id = tag.id)
      delete :remove_tag, params: { id: reservation_id, tag_id: }
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
          reservation.tags = [tag]
        end

        it { expect { req }.to change { TagInReservation.count }.by(-1) }
        it { expect { req }.not_to(change { Reservation.count }) }
        it { expect { req }.not_to(change { ReservationTag.count }) }
        it { expect { req }.to change { reservation.reload.tags.count }.from(1).to(0) }
        it { expect { req }.not_to(change { tag.reload.as_json }) }
        it { expect { req }.not_to(change { reservation.reload.as_json }) }

        it "is successful" do
          req
          expect(parsed_response_body).to include(item: Hash)
          expect(response).to have_http_status(:ok)
          expect(parsed_response_body[:item]).to include(id: Integer, created_at: String)
          expect(parsed_response_body[:item]).to include(tags: Array)
          expect(parsed_response_body.dig(:item, :tags).count).to eq 0
        end

        it "when removing same tag twice, should be fine." do
          expect { req }.to change { reservation.reload.tags.count }.from(1).to(0)
          expect(response).to have_http_status(:ok)
          expect { req }.not_to(change { reservation.reload.tags.count })
          expect(response).to have_http_status(:ok)
        end
      end

      context "when reservation has 3 tags" do
        let(:tags) { create_list(:reservation_tag, 3) }
        let(:tag) { tags.sample }

        before do
          reservation.tags = tags
        end

        it { expect { req }.to change { TagInReservation.count }.by(-1) }
        it { expect { req }.not_to(change { Reservation.count }) }
        it { expect { req }.not_to(change { ReservationTag.count }) }
        it { expect { req }.to change { reservation.reload.tags.count }.from(3).to(2) }
        it { expect { req }.not_to(change { tag.reload.as_json }) }
        it { expect { req }.not_to(change { reservation.reload.as_json }) }

        it "is successful" do
          req
          expect(parsed_response_body).to include(item: Hash)
          expect(response).to have_http_status(:ok)
          expect(parsed_response_body[:item]).to include(id: Integer, created_at: String)
          expect(parsed_response_body[:item]).to include(tags: Array)
          expect(parsed_response_body.dig(:item, :tags).count).to eq 2
        end

        it "when removing same tag twice, should be fine." do
          expect { req }.to change { reservation.reload.tags.count }.from(3).to(2)
          expect(response).to have_http_status(:ok)
          expect { req }.not_to(change { reservation.reload.tags.count })
          expect(response).to have_http_status(:ok)
        end
      end
    end
  end
end
