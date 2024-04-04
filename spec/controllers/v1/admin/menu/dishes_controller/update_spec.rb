# frozen_string_literal: true

require "rails_helper"

RSpec.describe V1::Admin::Menu::DishesController do
  include_context CONTROLLER_UTILS_CONTEXT
  include_context CONTROLLER_AUTHENTICATION_CONTEXT
  include_context TESTS_OPTIMIZATIONS_CONTEXT

  let(:instance) { described_class.new }

  describe "#update" do
    let(:menu_dish) { create(:menu_dish) }

    it { expect(instance).to respond_to(:update) }

    it {
      expect(subject).to route(:patch, "/v1/admin/menu/dishes/22").to(format: :json, action: :update,
                                                                      controller: "v1/admin/menu/dishes", id: 22)
    }

    def req(id, params = {})
      patch :update, params: params.merge(id:)
    end

    context "when user is not authenticated" do
      before { req(menu_dish.id, name: Faker::Lorem.sentence) }

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

      context "when updating name {name: <string>}" do
        subject { parsed_response_body[:item] }

        let(:new_name) { Faker::Lorem.sentence }

        before { req(menu_dish.id, name: new_name, description: "desc") }

        it { is_expected.to include(id: menu_dish.id) }
        it { is_expected.to include(name: new_name) }
        it { is_expected.to include(description: "desc") }
        it { expect(response).to be_successful }
      end

      context "when updating description {description: <string>}" do
        subject { parsed_response_body[:item] }

        let(:new_description) { Faker::Lorem.sentence }

        before { req(menu_dish.id, description: new_description, name: "wassa") }

        it { is_expected.to include(id: menu_dish.id) }
        it { is_expected.to include(description: new_description) }
        it { is_expected.to include(name: "wassa") }
        it { expect(response).to be_successful }
      end

      context "when setting name to nil {name: nil}" do
        subject { parsed_response_body[:item] }

        before { req(menu_dish.id, name: nil) }

        it { is_expected.to include(id: menu_dish.id) }
        it { is_expected.to include(name: nil) }
        it { expect(response).to be_successful }
      end

      context "when setting description to nil {description: nil}" do
        subject { parsed_response_body[:item] }

        before { req(menu_dish.id, description: nil) }

        it { is_expected.to include(id: menu_dish.id) }
        it { is_expected.to include(description: nil) }
        it { expect(response).to be_successful }
      end

      context "when setting name with hash {name: {<locale>: <string>}}" do
        subject { parsed_response_body[:item] }

        let(:new_name) { Faker::Lorem.sentence }

        before { req(menu_dish.id, name: { en: new_name }) }

        it { is_expected.to include(id: menu_dish.id) }
        it { is_expected.to include(name: new_name) }
        it { expect(response).to be_successful }
      end

      context "when setting description with hash {description: {<locale>: <string>}}" do
        subject { parsed_response_body[:item] }

        let(:new_description) { Faker::Lorem.sentence }

        before { req(menu_dish.id, description: { en: new_description }) }

        it { is_expected.to include(id: menu_dish.id) }
        it { is_expected.to include(description: new_description) }
        it { expect(response).to be_successful }
      end

      context "when setting name to nil with hash {name: {<locale>: nil}}" do
        subject { parsed_response_body[:item] }

        let(:menu_dish) { create(:menu_dish, name: "Dish name before") }

        before { req(menu_dish.id, name: { en: nil }) }

        it { is_expected.to include(id: menu_dish.id) }
        it { is_expected.to include(name: nil) }
        it { expect(response).to be_successful }
      end

      context "when setting name to nil with {name: nil}" do
        subject { parsed_response_body[:item] }

        let(:menu_dish) { create(:menu_dish, name: "Dish name before") }

        before { req(menu_dish.id, name: nil) }

        it { is_expected.to include(id: menu_dish.id) }
        it { is_expected.to include(name: nil) }
        it { expect(response).to be_successful }
      end

      context "when setting price from nil to 15" do
        subject { parsed_response_body[:item] }

        let(:name) { "Dish name" }
        let(:description) { "Dish description" }
        let(:price) { 15 }
        let(:menu_dish) { create(:menu_dish, name:, description:, price: nil) }

        before { req(menu_dish.id, price:) }

        it { is_expected.to include(id: menu_dish.id) }
        it { is_expected.to include(name:) }
        it { is_expected.to include(description:) }
        it { is_expected.to include(price: 15.0) }
        it { expect(response).to be_successful }
      end

      context "when setting price from nil to 15.9" do
        subject { parsed_response_body[:item] }

        let(:name) { "Dish name" }
        let(:description) { "Dish description" }
        let(:price) { 15.9 }
        let(:menu_dish) { create(:menu_dish, name:, description:, price: nil) }

        before { req(menu_dish.id, price:) }

        it { is_expected.to include(id: menu_dish.id) }
        it { is_expected.to include(name:) }
        it { is_expected.to include(description:) }
        it { is_expected.to include(price:) }
        it { expect(response).to be_successful }
      end

      context "when setting price from 15.9 to nil" do
        subject { parsed_response_body[:item] }

        let(:name) { "Dish name" }
        let(:description) { "Dish description" }
        let(:price) { 15.9 }
        let(:menu_dish) { create(:menu_dish, name:, description:, price:) }

        before { req(menu_dish.id, price: nil) }

        it { is_expected.to include(id: menu_dish.id) }
        it { is_expected.to include(name:) }
        it { is_expected.to include(description:) }
        it { is_expected.to include(price: nil) }
        it { expect(response).to be_successful }
      end

      context "when setting price from 15 to nil" do
        subject { parsed_response_body[:item] }

        let(:name) { "Dish name" }
        let(:description) { "Dish description" }
        let(:price) { 15 }
        let(:menu_dish) { create(:menu_dish, name:, description:, price:) }

        before { req(menu_dish.id, price: nil) }

        it { is_expected.to include(id: menu_dish.id) }
        it { is_expected.to include(name:) }
        it { is_expected.to include(description:) }
        it { is_expected.to include(price: nil) }
        it { expect(response).to be_successful }
      end

      context "when setting price from 15.9 to 0" do
        subject { parsed_response_body[:item] }

        let(:name) { "Dish name" }
        let(:description) { "Dish description" }
        let(:price) { 15.9 }
        let(:menu_dish) { create(:menu_dish, name:, description:, price:) }

        before { req(menu_dish.id, price: 0) }

        it { is_expected.to include(id: menu_dish.id) }
        it { is_expected.to include(name:) }
        it { is_expected.to include(description:) }
        it { is_expected.to include(price: 0) }
        it { expect(response).to be_successful }
      end

      context "when setting price from 15 to 0" do
        subject { parsed_response_body[:item] }

        let(:name) { "Dish name" }
        let(:description) { "Dish description" }
        let(:price) { 15 }
        let(:menu_dish) { create(:menu_dish, name:, description:, price:) }

        before { req(menu_dish.id, price: 0) }

        it { is_expected.to include(id: menu_dish.id) }
        it { is_expected.to include(name:) }
        it { is_expected.to include(description:) }
        it { is_expected.to include(price: 0) }
        it { expect(response).to be_successful }
      end
    end
  end
end