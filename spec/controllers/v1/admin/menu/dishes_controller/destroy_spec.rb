# frozen_string_literal: true

require "rails_helper"

RSpec.describe V1::Admin::Menu::DishesController do
  include_context CONTROLLER_UTILS_CONTEXT
  include_context CONTROLLER_AUTHENTICATION_CONTEXT
  include_context TESTS_OPTIMIZATIONS_CONTEXT

  let(:instance) { described_class.new }

  describe "#destroy" do
    let(:menu_dish) { create(:menu_dish) }

    it { expect(instance).to respond_to(:destroy) }

    it {
      expect(subject).to route(:delete, "/v1/admin/menu/dishes/22").to(format: :json, action: :destroy,
                                                                       controller: "v1/admin/menu/dishes", id: 22)
    }

    def req(id, params = {})
      delete :destroy, params: params.merge(id:)
    end

    context "when user is not authenticated" do
      before { req(menu_dish.id) }

      it_behaves_like UNAUTHORIZED
    end

    context "[user is authenticated]" do
      before do
        authenticate_request(user: create(:user))
      end

      it { expect(req(menu_dish.id)).to be_successful }

      context "when item does not exist" do
        subject { response }

        before { req(999_999_999) }

        it_behaves_like NOT_FOUND
      end

      it "does not delete item from database but update its status" do
        menu_dish

        expect { req(menu_dish.id) }.not_to(change { Menu::Dish.count })
        expect(Menu::Dish.find(menu_dish.id).status).to eq("deleted")
      end

      it do
        menu_dish

        expect { req(menu_dish.id) }.to change { Menu::Dish.visible.count }.by(-1)
      end

      context "when cannot delete record" do
        subject do
          req(menu_dish.id)
          response
        end

        before do
          menu_dish
          allow_any_instance_of(Menu::Dish).to receive(:deleted!).and_return(false)
        end

        it { expect { subject }.not_to(change { Menu::Dish.visible.count }) }
        it { is_expected.to have_http_status(:unprocessable_entity) }
        it { is_expected.not_to be_successful }
      end

      context "when record deletion raises error" do
        subject do
          req(menu_dish.id)
          response
        end

        before do
          menu_dish
          allow_any_instance_of(Menu::Dish).to receive(:deleted!).and_raise(ActiveRecord::RecordInvalid)
        end

        it { expect { subject }.not_to(change { Menu::Dish.visible.count }) }
        it { is_expected.to have_http_status(:unprocessable_entity) }
        it { is_expected.not_to be_successful }
      end

      context "when item exists" do
        subject { parsed_response_body }

        before { req(menu_dish.id) }

        it { expect(response).to be_successful }
        it { is_expected.to eq({}) }
      end
    end
  end
end
