# frozen_string_literal: true

require "rails_helper"

RSpec.describe V1::Admin::Menu::DishesController do
  include_context CONTROLLER_UTILS_CONTEXT
  include_context CONTROLLER_AUTHENTICATION_CONTEXT
  include_context TESTS_OPTIMIZATIONS_CONTEXT

  let(:instance) { described_class.new }

  describe "#references" do
    subject { req }

    before do
      pranzo1 = create(:menu_category)
      pranzo1.name = "Pranzo1"
      pranzo1.save!

      pranzo2 = create(:menu_category)
      pranzo2.name = "Pranzo2"
      pranzo2.save!

      paste1 = create(:menu_category, visibility: nil, parent: pranzo1)
      paste1.name = "Paste1"
      paste1.save!

      paste2 = create(:menu_category, visibility: nil, parent: pranzo2)
      paste2.name = "Paste2"
      paste2.save!

      paste1.dishes = [dish]
      paste2.dishes = [dish]
    end

    let!(:dish) { create(:menu_dish) }

    it { expect(instance).to respond_to(:references) }

    it do
      expect(subject).to route(:get, "/v1/admin/menu/dishes/22/references").to(format: :json, action: :references,
                                                                                controller: "v1/admin/menu/dishes", id: 22)
    end

    def req(dish_id = dish.id, params = {})
      get :references, params: params.merge(id: dish_id)
    end

    context "when user is not authenticated" do
      before { req }

      it_behaves_like UNAUTHORIZED
    end

    context "[user is authenticated]" do
      before do
        authenticate_request(user: create(:user))
      end

      context "when dish does not exist" do
        subject { response }

        before { req(999_999_999) }

        it_behaves_like NOT_FOUND
      end

      context "basic" do
        subject do
          req
          response
        end
        before { subject }

        it do
          expect(parsed_response_body).not_to include(message: String)
          expect(response).to have_http_status(:ok)
        end

        it { expect(parsed_response_body).to include(categories: Array) }
        it do
          # { categories: [
          # { id: 1, name: "Pranzo1", breadcrumbs: [{ id: 1, name: "Pranzo1" }] },
          # ] }
          puts parsed_response_body
          expect(parsed_response_body).to include(categories: Array)
          expect(parsed_response_body[:categories].length).to eq 2
          expect(parsed_response_body[:categories]).to all(be_a(Hash))
          expect(parsed_response_body.dig(:categories, 0, :breadcrumbs)).to be_a(Array)
          expect(parsed_response_body.dig(:categories, 0, :breadcrumbs)).to all(be_a(Hash))
          expect(parsed_response_body.dig(:categories, 0, :breadcrumbs).count).to eq 2
          expect(parsed_response_body.dig(:categories, 0, :breadcrumbs, 0)).to include(id: Integer, name: String)
        end
      end
    end
  end
end
