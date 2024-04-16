# frozen_string_literal: true

require "rails_helper"

RSpec.describe V1::Admin::Menu::DishesController do
  include_context CONTROLLER_UTILS_CONTEXT
  include_context CONTROLLER_AUTHENTICATION_CONTEXT
  include_context TESTS_OPTIMIZATIONS_CONTEXT

  let(:instance) { described_class.new }

  describe "PATCH #update_status" do
    subject { req }

    let!(:dish) { create(:menu_dish) }
    let(:status) { "inactive" }

    it { expect(instance).to respond_to(:update_status) }

    it do
      expect(subject).to route(:patch, "/v1/admin/menu/dishes/22/status/inactive").to(format: :json, action: :update_status,
                                                                                      controller: "v1/admin/menu/dishes", id: 22, status: "inactive")
    end

    def req(dish_id = dish.id, req_status = status, params = {})
      patch :update_status, params: params.merge(id: dish_id, status: req_status)
    end

    context "when user is not authenticated" do
      before { req }

      it_behaves_like UNAUTHORIZED
    end

    context "when user is authenticated" do
      before do
        authenticate_request(user: create(:user))
      end

      context "when providing not-existing id" do
        subject { response }

        before { req(999_999_999) }

        it_behaves_like NOT_FOUND
      end

      it { is_expected.to be_successful }
      it { is_expected.to have_http_status(:ok) }
      it { expect { subject }.to change { dish.reload.status }.from("active").to("inactive") }
      it { expect { subject }.to(change { dish.reload.updated_at }) }

      it "returns item" do
        req
        expect(parsed_response_body).to include(item: Hash)
        expect(parsed_response_body[:item]).to include(id: dish.id, created_at: String, updated_at: String)
      end

      it "when setting to 'inactive' first, then 'active' status" do
        expect { req(dish.id, "inactive") }.to change { dish.reload.status }.from("active").to("inactive")
        expect { req(dish.id, "active") }.to change { dish.reload.status }.from("inactive").to("active")
        expect(parsed_response_body).not_to include(message: String)
        expect(response).to have_http_status(:ok)
      end
    end
  end
end