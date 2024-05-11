# frozen_string_literal: true

require "rails_helper"

RSpec.describe V1::Admin::Menu::DishesController do
  include_context CONTROLLER_UTILS_CONTEXT
  include_context CONTROLLER_AUTHENTICATION_CONTEXT
  include_context TESTS_OPTIMIZATIONS_CONTEXT

  let(:instance) { described_class.new }

  describe "#remove_image" do
    subject { req }

    before { dish.images << image }

    let!(:image) { create(:image, :with_attached_image) }
    let!(:dish) { create(:menu_dish) }

    it { expect(instance).to respond_to(:remove_image) }

    it {
      expect(subject).to route(:delete, "/v1/admin/menu/dishes/22/images/55").to(format: :json, action: :remove_image,
                                                                                 controller: "v1/admin/menu/dishes", id: 22, image_id: 55)
    }

    def req(dish_id = dish.id, image_id = image.id, params = {})
      post :remove_image, params: params.merge(id: dish_id, image_id:)
    end

    it { expect(dish.images.count).to be_positive }

    context "when user is not authenticated" do
      before { req }

      it_behaves_like UNAUTHORIZED
    end

    context "[user is authenticated]" do
      before do
        authenticate_request(user: create(:user))
      end

      it { is_expected.to be_successful }
      it { is_expected.to have_http_status(:ok) }
      it { expect { subject }.to change { dish.reload.images.count }.by(-1) }
      it { expect { subject }.to change { ImageToRecord.count }.by(-1) }
      it { expect { subject }.not_to(change { Image.count }) }

      context "if removing non-existing image" do
        subject { response }

        before { req(dish.id, 999_999_999) }

        it_behaves_like NOT_FOUND
      end

      context "if removing image from non-existing dish" do
        subject { response }

        before { req(999_999_999) }

        it_behaves_like NOT_FOUND
      end
    end
  end
end
