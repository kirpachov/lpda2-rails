# frozen_string_literal: true

require "rails_helper"

RSpec.describe V1::Admin::Menu::DishesController, type: :controller do
  include_context CONTROLLER_UTILS_CONTEXT
  include_context CONTROLLER_AUTHENTICATION_CONTEXT
  include_context TESTS_OPTIMIZATIONS_CONTEXT

  let(:instance) { described_class.new }

  describe "#index" do
    it { expect(instance).to respond_to(:index) }

    it {
      expect(subject).to route(:get, "/v1/admin/menu/dishes").to(format: :json, action: :index,
                                                                 controller: "v1/admin/menu/dishes")
    }

    def req(params = {})
      get :index, params:
    end

    context "when user is not authenticated" do
      before { req }

      it_behaves_like UNAUTHORIZED
    end

    context "[user is authenticated]" do
      before do
        authenticate_request(user: create(:user))
      end

      it { expect(req).to be_successful }

      context "when there are no dishes" do
        before { req }

        it { expect(parsed_response_body).to include(items: []) }
        it { expect(parsed_response_body).to include(metadata: Hash) }
      end

      context "when there are some dishes" do
        before do
          create_list(:menu_dish, 5, :with_name, :with_description)
          req
        end

        it { expect(parsed_response_body).to include(items: Array) }
        it { expect(parsed_response_body).to include(metadata: Hash) }
        it { expect(parsed_response_body[:items].size).to eq(5) }

        context "checking items structure" do
          subject { parsed_response_body[:items].sample }

          it { is_expected.to include(id: Integer) }
          it { is_expected.to include(name: String) }
          it { is_expected.to include(description: String) }
          it { is_expected.to include(images: Array) }
        end
      end

      context "when filtering by category_id" do
        let!(:category) do
          create(:menu_category).tap do |cat|
            cat.dishes << create(:menu_dish)
          end
        end

        before do
          create(:menu_category).dishes << create(:menu_dish)
        end

        context "checking mock data" do
          it { expect(Menu::Dish.count).to be >= 2 }
          it { expect(Menu::Category.count).to be >= 2 }
          it { expect(category.dishes.count).to eq 1 }
        end

        context "when {category_id: <id>}" do
          subject { parsed_response_body }

          before { req(category_id: category.id) }

          it { expect(response).to have_http_status(:ok) }

          it do
            expect(subject).not_to include(message: String)
            expect(subject).to include(items: Array)
            expect(subject[:items].count).to eq 1
          end
        end
      end

      context "when dishes have images" do
        before do
          create(:menu_dish).images = [create(:image, :with_attached_image)]
          req
        end

        context "checking images structure" do
          subject { parsed_response_body[:items].sample[:images].sample }

          it { is_expected.to include(id: Integer) }
          it { is_expected.to include(url: String) }
          it { is_expected.to include(filename: String) }
        end
      end

      context "when filtering by name" do
        let(:name) { "first" }
        let!(:menu_dish) { create(:menu_dish, name:, description: nil) }

        before do
          create(:menu_dish, name: "second", description: nil)
        end

        context "checking mock data" do
          it { expect(Menu::Dish.count).to eq(2) }
          it { expect(Menu::Dish.where_name(name).count).to eq(1) }
        end

        context "when filtering by name {query: <name>}" do
          subject { parsed_response_body[:items] }

          before { req(query: name) }

          it { is_expected.to be_an(Array) }
          it { is_expected.to include(include(id: menu_dish.id)) }
          it { expect(subject.size).to eq 1 }
        end
      end

      context "when filtering by description" do
        let(:description) { "first" }
        let!(:menu_dish) { create(:menu_dish, name: nil, description:) }

        before do
          create(:menu_dish, name: nil, description: "second")
        end

        context "checking mock data" do
          it { expect(Menu::Dish.count).to eq(2) }
          it { expect(Menu::Dish.where_description(description).count).to eq(1) }
        end

        context "when filtering by description {query: <description>}" do
          subject { parsed_response_body[:items] }

          before { req(query: description) }

          it { is_expected.to be_an(Array) }
          it { is_expected.to include(include(id: menu_dish.id)) }
          it { expect(subject.size).to eq 1 }
        end
      end

      context "when filtering by status {status: :active}" do
        subject do
          req(status: :active)
          parsed_response_body[:items]
        end

        before do
          Menu::Dish.delete_all
          create(:menu_dish, status: :active)
          create(:menu_dish, status: :deleted)
        end

        it { expect(Menu::Dish.count).to eq 2 }
        it { expect(Menu::Dish.visible.count).to eq 1 }
        it { expect(subject.size).to eq 1 }
        it { expect(subject.first[:status]).to eq "active" }
      end

      context "when filtering by status {status: :deleted}" do
        subject do
          req(status: :deleted)
          parsed_response_body[:items]
        end

        before do
          Menu::Dish.delete_all
          create(:menu_dish, status: :active)
          create(:menu_dish, status: :deleted)
        end

        it { expect(Menu::Dish.count).to eq 2 }
        it { expect(Menu::Dish.visible.count).to eq 1 }
        it { is_expected.to be_empty }
      end

      context "when filtering by price {price: 15}" do
        subject do
          req(price: 15)
          parsed_response_body[:items]
        end

        before do
          Menu::Dish.delete_all
          create(:menu_dish, price: 15)
          create(:menu_dish, price: 15)
          create(:menu_dish, price: 16)
        end

        it { expect(Menu::Dish.count).to eq 3 }
        it { expect(Menu::Dish.pluck(:price).uniq).to contain_exactly(15, 16) }
        it { expect(subject.size).to eq 2 }
        it { is_expected.to all(include(price: 15)) }
      end

      context 'when filtering by price {price: "15.5"}' do
        subject do
          req(price: "15.5")
          parsed_response_body[:items]
        end

        before do
          Menu::Dish.delete_all
          create(:menu_dish, price: 15)
          create(:menu_dish, price: 15)
          create(:menu_dish, price: 16)
        end

        it { expect(Menu::Dish.count).to eq 3 }
        it { expect(Menu::Dish.pluck(:price).uniq).to contain_exactly(15, 16) }
        it { expect(subject.size).to eq 0 }
      end

      context 'when filtering by price {price: "15.5"}' do
        subject do
          req(price: "15.5")
          parsed_response_body[:items]
        end

        before do
          Menu::Dish.delete_all
          create(:menu_dish, price: 15.5)
          create(:menu_dish, price: 15)
          create(:menu_dish, price: 16)
        end

        it { expect(Menu::Dish.count).to eq 3 }
        it { expect(Menu::Dish.pluck(:price).uniq).to contain_exactly(15.5, 15, 16) }
        it { expect(subject.size).to eq 1 }
        it { is_expected.to all(include(price: 15.5)) }
      end

      context "when filtering by price {price: 15.5}" do
        subject do
          req(price: 15.5)
          parsed_response_body[:items]
        end

        before do
          Menu::Dish.delete_all
          create(:menu_dish, price: 15.5)
          create(:menu_dish, price: 15)
          create(:menu_dish, price: 16)
        end

        it { expect(Menu::Dish.count).to eq 3 }
        it { expect(Menu::Dish.pluck(:price).uniq).to contain_exactly(15, 15.5, 16) }
        it { expect(subject.size).to eq 1 }
        it { is_expected.to all(include(price: 15.5)) }
      end

      context "when filtering by price {price: {less_than: 10}" do
        subject do
          req(price: { less_than: 10 })
          parsed_response_body[:items]
        end

        before do
          Menu::Dish.delete_all
          create(:menu_dish, price: 8)
          create(:menu_dish, price: 10)
          create(:menu_dish, price: 12)
        end

        it { expect(Menu::Dish.count).to eq 3 }
        it { expect(Menu::Dish.pluck(:price).uniq).to contain_exactly(8, 10, 12) }
        it { expect(subject.size).to eq 2 }
        it { is_expected.to all(include(price: Numeric)) }
        it { expect(subject.map { |j| j[:price] }).to contain_exactly(8, 10) }
      end

      context "when filtering by price {price: {more_than: 10}" do
        subject do
          req(price: { more_than: 10 })
          parsed_response_body[:items]
        end

        before do
          Menu::Dish.delete_all
          create(:menu_dish, price: 8)
          create(:menu_dish, price: 10)
          create(:menu_dish, price: 12)
        end

        it { expect(Menu::Dish.count).to eq 3 }
        it { expect(Menu::Dish.pluck(:price).uniq).to contain_exactly(8, 10, 12) }
        it { expect(subject.size).to eq 2 }
        it { is_expected.to all(include(price: Numeric)) }
        it { expect(subject.map { |j| j[:price] }).to contain_exactly(10, 12) }
      end

      context "when filtering by price {price: {more_than: 10.1}" do
        subject do
          req(price: { more_than: 10.1 })
          parsed_response_body[:items]
        end

        before do
          Menu::Dish.delete_all
          create(:menu_dish, price: 8)
          create(:menu_dish, price: 10)
          create(:menu_dish, price: 12)
        end

        it { expect(Menu::Dish.count).to eq 3 }
        it { expect(Menu::Dish.pluck(:price).uniq).to contain_exactly(8, 10, 12) }
        it { expect(subject.size).to eq 1 }
        it { is_expected.to all(include(price: 12)) }
      end

      context 'when filtering by price {price: {more_than: "10.1"}' do
        subject do
          req(price: { more_than: "10.1" })
          parsed_response_body[:items]
        end

        before do
          Menu::Dish.delete_all
          create(:menu_dish, price: 8)
          create(:menu_dish, price: 10)
          create(:menu_dish, price: 12)
        end

        it { expect(Menu::Dish.count).to eq 3 }
        it { expect(Menu::Dish.pluck(:price).uniq).to contain_exactly(8, 10, 12) }
        it { expect(subject.size).to eq 1 }
        it { is_expected.to all(include(price: 12)) }
      end

      context 'when filtering by price {price: {more_than: "10", less_than: "12"}' do
        subject do
          req(price: { more_than: "10", less_than: "12" })
          parsed_response_body[:items]
        end

        before do
          Menu::Dish.delete_all
          create(:menu_dish, price: 8)
          create(:menu_dish, price: 10)
          create(:menu_dish, price: 12)
          create(:menu_dish, price: 14)
        end

        it { expect(Menu::Dish.count).to eq 4 }
        it { expect(Menu::Dish.pluck(:price).uniq).to contain_exactly(8, 10, 12, 14) }
        it { expect(subject.size).to eq 2 }
        it { expect(subject.map { |j| j[:price] }).to contain_exactly(10, 12) }
      end

      context 'when filtering by price {price: {more_than: "10", less_than: 11.9}' do
        subject do
          req(price: { more_than: "10", less_than: 11.9 })
          parsed_response_body[:items]
        end

        before do
          Menu::Dish.delete_all
          create(:menu_dish, price: 8)
          create(:menu_dish, price: 10)
          create(:menu_dish, price: 12)
          create(:menu_dish, price: 14)
        end

        it { expect(Menu::Dish.count).to eq 4 }
        it { expect(Menu::Dish.pluck(:price).uniq).to contain_exactly(8, 10, 12, 14) }
        it { expect(subject.size).to eq 1 }
        it { expect(subject.map { |j| j[:price] }).to contain_exactly(10) }
      end
    end
  end

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

  describe "#create" do
    it { expect(instance).to respond_to(:create) }

    it do
      expect(subject).to route(:post, "/v1/admin/menu/dishes").to(format: :json, action: :create,
                                                                  controller: "v1/admin/menu/dishes")
    end

    def req(params = {})
      post :create, params:
    end

    context "when user is not authenticated" do
      before { req(name: Faker::Lorem.sentence) }

      it_behaves_like UNAUTHORIZED
    end

    context "[user is authenticated]" do
      before do
        authenticate_request(user: create(:user))
      end

      it { expect(req).to be_successful }

      it { expect { req(description: "desc") }.to change(Menu::Dish, :count).by(1) }

      context "when category_id is provided but blank, should create dish without category (root dish)." do
        subject do
          req(category_id: "", description: "desc")
          parsed_response_body[:item]
        end

        it { is_expected.to include(name: nil) }
        it { is_expected.to include(description: "desc") }

        it {
          subject
          expect(response).to be_successful
        }

        it { expect { subject }.to change { Menu::Dish.count }.by(1) }
        it { expect { subject }.to change { Menu::DishesInCategory.count }.by(1) }
        it { expect { subject }.to change { Menu::DishesInCategory.where(menu_category_id: nil).count }.by(1) }
      end

      context "when category_id is present, should create dish as category child" do
        subject do
          req(category_id: category.id, description: "desc")
          parsed_response_body[:item]
        end

        let(:category) { create(:menu_category) }

        it { is_expected.to include(name: nil) }
        it { is_expected.to include(description: "desc") }
        it { expect(response).to be_successful }
        it { expect { subject }.to change { Menu::Dish.count }.by(1) }
        it { expect { subject }.to change { Menu::DishesInCategory.count }.by(1) }
        it { expect { subject }.to change { Menu::DishesInCategory.where(menu_category_id: category.id).count }.by(1) }
      end

      context "when creating new dish with {description: <string>}" do
        subject { parsed_response_body[:item] }

        before { req(description: "desc") }

        it { is_expected.to include(name: nil) }
        it { is_expected.to include(description: "desc") }
        it { expect(response).to be_successful }
      end

      it { expect { req(price: 15) }.to change(Menu::Dish, :count).by(1) }

      context "when creating new dish with {price: 15}" do
        subject { parsed_response_body[:item] }

        before { req(price: 15) }

        it { is_expected.to include(name: nil) }
        it { is_expected.to include(description: nil) }
        it { is_expected.to include(price: 15.0) }
        it { expect(response).to be_successful }
      end

      it { expect { req(price: 15.7) }.to change(Menu::Dish, :count).by(1) }

      context "when creating new dish with {price: 15.7}" do
        subject { parsed_response_body[:item] }

        before { req(price: 15.7) }

        it { is_expected.to include(name: nil) }
        it { is_expected.to include(description: nil) }
        it { is_expected.to include(price: 15.7) }
        it { expect(response).to be_successful }
      end

      it { expect { req(price: "15.7") }.to change(Menu::Dish, :count).by(1) }

      context 'when creating new dish with {price: "15.7"}' do
        subject { parsed_response_body[:item] }

        before { req(price: "15.7") }

        it { is_expected.to include(name: nil) }
        it { is_expected.to include(description: nil) }
        it { is_expected.to include(price: 15.7) }
        it { expect(response).to be_successful }
      end

      it { expect { req(name: "wassa") }.to change(Menu::Dish, :count).by(1) }

      context "when creating new dish with {name: <string>}" do
        subject { parsed_response_body[:item] }

        before { req(name: "wassa") }

        it { is_expected.to include(description: nil) }
        it { is_expected.to include(name: "wassa") }
        it { expect(response).to be_successful }
      end

      it { expect { req }.to change(Menu::Dish, :count).by(1) }

      context "when creating new dish with {}" do
        subject { parsed_response_body[:item] }

        before { req }

        it { is_expected.to include(name: nil) }
        it { is_expected.to include(description: nil) }
        it { expect(response).to be_successful }
      end

      it { expect { req(name: "wassa", description: "bratan") }.to change(Menu::Dish, :count).by(1) }

      context "when creating new dish with {name: <name>, description: <description>}" do
        subject { parsed_response_body[:item] }

        before { req(name: "wassa", description: "bratan") }

        it { is_expected.to include(name: "wassa") }
        it { is_expected.to include(description: "bratan") }
        it { expect(response).to be_successful }
      end
    end
  end

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

  describe "#remove_from_category" do
    let(:dish) { create(:menu_dish) }
    let(:category) do
      create(:menu_category).tap do |cat|
        cat.dishes << dish
      end
    end

    it { expect(instance).to respond_to(:remove_from_category) }

    it do
      expect(subject).to route(:delete, "/v1/admin/menu/dishes/22/remove_from_category").to(format: :json, action: :remove_from_category,
                                                                                            controller: "v1/admin/menu/dishes", id: 22)
    end

    it do
      expect(subject).to route(:delete, "/v1/admin/menu/dishes/22/remove_from_category/7").to(format: :json, action: :remove_from_category,
                                                                                              controller: "v1/admin/menu/dishes", id: 22, category_id: 7)
    end

    def req(id = dish.id, category_id = category.id, params = {})
      delete :remove_from_category, params: params.merge(id:, category_id:)
    end

    context "when user is not authenticated" do
      before { req(dish.id) }

      it_behaves_like UNAUTHORIZED
    end

    context "[user is authenticated]" do
      before do
        authenticate_request(user: create(:user))
      end

      it { expect(req(dish.id)).to be_successful }

      context "when item does not exist" do
        subject { response }

        before { req(999_999_999) }

        it_behaves_like NOT_FOUND
      end

      context "when category has dishes" do
        before { category }

        it { expect { req }.not_to(change { Menu::Dish.count }) }
        it { expect { req }.not_to(change { Menu::Dish.visible.count }) }
        it { expect { req }.not_to(change { dish.reload.status }) }
        it { expect { req }.to change { category.dishes.count }.by(-1) }
        it { expect { req }.to change { Menu::DishesInCategory.count }.by(-1) }
      end

      context "when dish is root" do
        before do
          category.dishes.delete_all # should not be necessary, just to be sure.

          Menu::DishesInCategory.create!(dish:)
        end

        context "checking mock data" do
          it { expect(dish.categories.count).to eq 0 }
          it { expect(Menu::Category.count).to eq 1 }
          it { expect(Menu::DishesInCategory.count).to eq 1 }
          it { expect(Menu::DishesInCategory.where(dish:, category: nil).count).to eq 1 }
        end

        it { expect { req(dish.id, nil) }.to change { Menu::DishesInCategory.count }.by(-1) }
        it { expect { req(dish.id, nil) }.not_to(change { Menu::Dish.count }) }
        it { expect { req(dish.id, nil) }.not_to(change { Menu::Dish.visible.count }) }
        it { expect { req(dish.id, nil) }.not_to(change { dish.reload.status }) }
      end
    end
  end

  describe "#copy" do
    subject { req(dish.id) }

    let!(:dish) { create(:menu_dish) }

    it { expect(instance).to respond_to(:copy) }

    it {
      expect(subject).to route(:post, "/v1/admin/menu/dishes/22/copy").to(format: :json, action: :copy,
                                                                          controller: "v1/admin/menu/dishes", id: 22)
    }

    def req(id, params = {})
      post :copy, params: params.merge(id:)
    end

    context "when user is not authenticated" do
      before { req(dish.id, name: Faker::Lorem.sentence) }

      it_behaves_like UNAUTHORIZED
    end

    context "[user is authenticated]" do
      before do
        authenticate_request(user: create(:user))
      end

      it { is_expected.to be_successful }

      it { expect { subject }.to change { Menu::Dish.count }.by(1) }

      context "when item does not exist" do
        subject { response }

        before { req(999_999_999) }

        it_behaves_like NOT_FOUND
      end

      context "if dish has images" do
        let!(:images) { create_list(:image, 3, :with_attached_image) }

        before { dish.images = images }

        it { expect(dish.images.map(&:id)).to match_array(images.map(&:id)) }
        it { expect(dish.images.count).to be_positive }

        context 'and providing {copy_images: "full"}' do
          subject { req(dish.id, { copy_images: "full" }) }

          it { is_expected.to be_successful }
          it { is_expected.to have_http_status(:ok) }

          it { expect { subject }.to change { Image.count }.by(images.count) }
          it { expect { subject }.to change { ImageToRecord.count }.by(images.count) }

          context "[after req]" do
            before { subject }

            let(:result) { Menu::Dish.find(parsed_response_body.dig(:item, :id)) }

            it { expect(parsed_response_body).to include(item: Hash) }
            it { expect(result.images.count).to eq(images.count) }
            it { expect(result.images.map(&:id)).not_to match_array(images.map(&:id)) }
          end
        end

        context 'and providing {copy_images: "link"}' do
          subject { req(dish.id, { copy_images: "link" }) }

          it { expect { subject }.not_to(change { Image.count }) }
          it { expect { subject }.to change { ImageToRecord.count }.by(images.count) }

          context "[after req]" do
            before { subject }

            let(:result) { Menu::Dish.find(parsed_response_body.dig(:item, :id)) }

            it { expect(result.images.count).to eq(images.count) }
          end
        end

        context 'and providing {copy_images: "none"}' do
          subject { req(dish.id, { copy_images: "none" }) }

          it { expect { subject }.not_to(change { Image.count }) }
          it { expect { subject }.not_to(change { ImageToRecord.count }) }

          context "[after req]" do
            before { subject }

            let(:result) { Menu::Dish.find(parsed_response_body.dig(:item, :id)) }

            it { expect(result.images.count).to eq(0) }
          end
        end
      end

      context "if dish has ingredients" do
        let!(:ingredients) { create_list(:menu_ingredient, 3) }

        before { dish.ingredients = ingredients }

        it { expect(dish.ingredients.map(&:id)).to match_array(ingredients.map(&:id)) }
        it { expect(dish.ingredients.count).to be_positive }

        context 'and providing {copy_ingredients: "full"}' do
          subject { req(dish.id, { copy_ingredients: "full" }) }

          it { is_expected.to be_successful }
          it { is_expected.to have_http_status(:ok) }

          it { expect { subject }.to change { Menu::Ingredient.count }.by(ingredients.count) }
          it { expect { subject }.to change { Menu::IngredientsInDish.count }.by(ingredients.count) }

          context "[after req]" do
            before { subject }

            let(:result) { Menu::Dish.find(parsed_response_body.dig(:item, :id)) }

            it { expect(parsed_response_body).to include(item: Hash) }
            it { expect(result.ingredients.count).to eq(ingredients.count) }
            it { expect(result.ingredients.map(&:id)).not_to match_array(ingredients.map(&:id)) }
          end
        end

        context 'and providing {copy_ingredients: "link"}' do
          subject { req(dish.id, { copy_ingredients: "link" }) }

          it { expect { subject }.not_to(change { Menu::Ingredient.count }) }
          it { expect { subject }.to change { Menu::IngredientsInDish.count }.by(ingredients.count) }

          context "[after req]" do
            before { subject }

            let(:result) { Menu::Dish.find(parsed_response_body.dig(:item, :id)) }

            it { expect(result.ingredients.count).to eq(ingredients.count) }
          end
        end

        context 'and providing {copy_ingredients: "none"}' do
          subject { req(dish.id, { copy_ingredients: "none" }) }

          it { expect { subject }.not_to(change { Menu::Ingredient.count }) }
          it { expect { subject }.not_to(change { Menu::IngredientsInDish.count }) }

          context "[after req]" do
            before { subject }

            let(:result) { Menu::Dish.find(parsed_response_body.dig(:item, :id)) }

            it { expect(result.ingredients.count).to eq(0) }
          end
        end
      end

      context "if dish has allergens" do
        let!(:allergens) { create_list(:menu_allergen, 3) }

        before { dish.allergens = allergens }

        it { expect(dish.allergens.map(&:id)).to match_array(allergens.map(&:id)) }
        it { expect(dish.allergens.count).to be_positive }

        context 'and providing {copy_allergens: "full"}' do
          subject { req(dish.id, { copy_allergens: "full" }) }

          it { is_expected.to be_successful }
          it { is_expected.to have_http_status(:ok) }

          it { expect { subject }.to change { Menu::Allergen.count }.by(allergens.count) }
          it { expect { subject }.to change { Menu::AllergensInDish.count }.by(allergens.count) }

          context "[after req]" do
            before { subject }

            let(:result) { Menu::Dish.find(parsed_response_body.dig(:item, :id)) }

            it { expect(parsed_response_body).to include(item: Hash) }
            it { expect(result.allergens.count).to eq(allergens.count) }
            it { expect(result.allergens.map(&:id)).not_to match_array(allergens.map(&:id)) }
          end
        end

        context 'and providing {copy_allergens: "link"}' do
          subject { req(dish.id, { copy_allergens: "link" }) }

          it { expect { subject }.not_to(change { Menu::Allergen.count }) }
          it { expect { subject }.to change { Menu::AllergensInDish.count }.by(allergens.count) }

          context "[after req]" do
            before { subject }

            let(:result) { Menu::Dish.find(parsed_response_body.dig(:item, :id)) }

            it { expect(result.allergens.count).to eq(allergens.count) }
          end
        end

        context 'and providing {copy_allergens: "none"}' do
          subject { req(dish.id, { copy_allergens: "none" }) }

          it { expect { subject }.not_to(change { Menu::Allergen.count }) }
          it { expect { subject }.not_to(change { Menu::AllergensInDish.count }) }

          context "[after req]" do
            before { subject }

            let(:result) { Menu::Dish.find(parsed_response_body.dig(:item, :id)) }

            it { expect(result.allergens.count).to eq(0) }
          end
        end
      end

      context "if dish has tags" do
        let!(:tags) { create_list(:menu_tag, 3) }

        before { dish.tags = tags }

        it { expect(dish.tags.map(&:id)).to match_array(tags.map(&:id)) }
        it { expect(dish.tags.count).to be_positive }

        context 'and providing {copy_tags: "full"}' do
          subject { req(dish.id, { copy_tags: "full" }) }

          it { is_expected.to be_successful }
          it { is_expected.to have_http_status(:ok) }

          it { expect { subject }.to change { Menu::Tag.count }.by(tags.count) }
          it { expect { subject }.to change { Menu::TagsInDish.count }.by(tags.count) }

          context "[after req]" do
            before { subject }

            let(:result) { Menu::Dish.find(parsed_response_body.dig(:item, :id)) }

            it { expect(parsed_response_body).to include(item: Hash) }
            it { expect(result.tags.count).to eq(tags.count) }
            it { expect(result.tags.map(&:id)).not_to match_array(tags.map(&:id)) }
          end
        end

        context 'and providing {copy_tags: "link"}' do
          subject { req(dish.id, { copy_tags: "link" }) }

          it { expect { subject }.not_to(change { Menu::Tag.count }) }
          it { expect { subject }.to change { Menu::TagsInDish.count }.by(tags.count) }

          context "[after req]" do
            before { subject }

            let(:result) { Menu::Dish.find(parsed_response_body.dig(:item, :id)) }

            it { expect(result.tags.count).to eq(tags.count) }
          end
        end

        context 'and providing {copy_tags: "none"}' do
          subject { req(dish.id, { copy_tags: "none" }) }

          it { expect { subject }.not_to(change { Menu::Tag.count }) }
          it { expect { subject }.not_to(change { Menu::TagsInDish.count }) }

          context "[after req]" do
            before { subject }

            let(:result) { Menu::Dish.find(parsed_response_body.dig(:item, :id)) }

            it { expect(result.tags.count).to eq(0) }
          end
        end
      end
    end
  end

  describe "#add_ingredient" do
    subject { req }

    let!(:ingredient) { create(:menu_ingredient) }
    let!(:dish) { create(:menu_dish) }

    it { expect(instance).to respond_to(:add_ingredient) }

    it {
      expect(subject).to route(:post, "/v1/admin/menu/dishes/22/ingredients/55").to(format: :json, action: :add_ingredient,
                                                                                    controller: "v1/admin/menu/dishes", id: 22, ingredient_id: 55)
    }

    def req(dish_id = dish.id, ingredient_id = ingredient.id, params = {})
      post :add_ingredient, params: params.merge(id: dish_id, ingredient_id:)
    end

    context "when user is not authenticated" do
      before { req }

      it_behaves_like UNAUTHORIZED
    end

    context "[user is authenticated]" do
      before do
        authenticate_request(user: create(:user))
      end

      it { is_expected.to be_successful }
      it { expect { subject }.to change { dish.reload.ingredients.count }.by(1) }
      it { expect { subject }.to change { Menu::IngredientsInDish.count }.by(1) }
      it { expect { subject }.not_to(change { Menu::Dish.count }) }
      it { expect { subject }.not_to(change { Menu::Ingredient.count }) }

      context "when adding twice same ingredient" do
        before { req }

        it { expect { req }.not_to(change { dish.reload.ingredients.count }) }
        it { expect { req }.not_to(change { Menu::IngredientsInDish.count }) }

        context "[after second request]" do
          before { req }

          it { is_expected.to have_http_status(:unprocessable_entity) }
          it { expect(parsed_response_body).to include(message: String) }
        end
      end

      context "when adding ingredient to non-existing dish" do
        subject { response }

        before { req(999_999_999) }

        it_behaves_like NOT_FOUND
      end

      context "when adding non-existing ingredient to dish" do
        subject { response }

        before { req(dish.id, 999_999_999) }

        it_behaves_like NOT_FOUND
      end

      context "when adding deleted ingredient to dish" do
        subject { response }

        before do
          ingredient.deleted!
          req
        end

        it_behaves_like NOT_FOUND
      end

      context "when providing {copy: true}, should attach a copy of the ingredient" do
        subject do
          req(dish.id, ingredient.id, copy: true)
          response
        end

        it { expect { subject }.to change { dish.reload.ingredients.count }.by(1) }
        it { expect { subject }.to change { Menu::IngredientsInDish.count }.by(1) }
        it { expect { subject }.to change { Menu::Ingredient.count }.by(1) }
        it { expect { subject }.not_to(change { Menu::Dish.count }) }

        context "[after request]" do
          before { subject }

          it { expect(parsed_response_body).not_to include(message: String) }
          it { expect(parsed_response_body).to include(item: Hash) }
          it { expect(dish.reload.ingredients.count).to eq 1 }
          it { expect(dish.reload.ingredients.first.id).not_to eq ingredient.id }
        end

        context "when addition fails, should return 422 and not create any new record" do
          before do
            allow_any_instance_of(Menu::IngredientsInDish).to receive(:valid?).and_return(false)
            req(dish.id, ingredient.id, copy: true)
          end

          it { is_expected.to have_http_status(:unprocessable_entity) }
          it { expect(parsed_response_body).to include(message: String) }
          it { expect { subject }.not_to(change { dish.reload.ingredients.count }) }
          it { expect { subject }.not_to(change { Menu::IngredientsInDish.count }) }
          it { expect { subject }.not_to(change { Menu::Ingredient.count }) }
        end
      end
    end
  end

  describe "#remove_ingredient" do
    subject { req }

    before { dish.ingredients << ingredient }

    let!(:ingredient) { create(:menu_ingredient) }
    let!(:dish) { create(:menu_dish) }

    it { expect(instance).to respond_to(:remove_ingredient) }

    it {
      expect(subject).to route(:delete, "/v1/admin/menu/dishes/22/ingredients/55").to(format: :json, action: :remove_ingredient,
                                                                                      controller: "v1/admin/menu/dishes", id: 22, ingredient_id: 55)
    }

    def req(dish_id = dish.id, ingredient_id = ingredient.id, params = {})
      post :remove_ingredient, params: params.merge(id: dish_id, ingredient_id:)
    end

    it { expect(dish.ingredients.count).to be_positive }

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
      it { expect { subject }.to change { dish.reload.ingredients.count }.by(-1) }
      it { expect { subject }.to change { Menu::IngredientsInDish.count }.by(-1) }

      context "if removing non-existing ingredient" do
        subject { response }

        before { req(dish.id, 999_999_999) }

        it_behaves_like NOT_FOUND
      end

      context "if removing ingredient from non-existing dish" do
        subject { response }

        before { req(999_999_999) }

        it_behaves_like NOT_FOUND
      end
    end
  end

  describe "#add_tag" do
    subject { req }

    let!(:tag) { create(:menu_tag) }
    let!(:dish) { create(:menu_dish) }

    it { expect(instance).to respond_to(:add_tag) }

    it {
      expect(subject).to route(:post, "/v1/admin/menu/dishes/22/tags/55").to(format: :json, action: :add_tag,
                                                                             controller: "v1/admin/menu/dishes", id: 22, tag_id: 55)
    }

    def req(dish_id = dish.id, tag_id = tag.id, params = {})
      post :add_tag, params: params.merge(id: dish_id, tag_id:)
    end

    context "when user is not authenticated" do
      before { req }

      it_behaves_like UNAUTHORIZED
    end

    context "[user is authenticated]" do
      before do
        authenticate_request(user: create(:user))
      end

      it { is_expected.to be_successful }
      it { expect { subject }.to change { dish.reload.tags.count }.by(1) }
      it { expect { subject }.to change { Menu::TagsInDish.count }.by(1) }
      it { expect { subject }.not_to(change { Menu::Dish.count }) }
      it { expect { subject }.not_to(change { Menu::Tag.count }) }

      context "when adding twice same tag" do
        before { req }

        it { expect { req }.not_to(change { dish.reload.tags.count }) }
        it { expect { req }.not_to(change { Menu::TagsInDish.count }) }

        context "[after second request]" do
          before { req }

          it { is_expected.to have_http_status(:unprocessable_entity) }
          it { expect(parsed_response_body).to include(message: String) }
        end
      end

      context "when adding tag to non-existing dish" do
        subject { response }

        before { req(999_999_999) }

        it_behaves_like NOT_FOUND
      end

      context "when adding non-existing tag to dish" do
        subject { response }

        before { req(dish.id, 999_999_999) }

        it_behaves_like NOT_FOUND
      end

      context "when adding deleted tag to dish" do
        subject { response }

        before do
          tag.deleted!
          req
        end

        it_behaves_like NOT_FOUND
      end

      context "when providing {copy: true}, should attach a copy of the tag" do
        subject do
          req(dish.id, tag.id, copy: true)
          response
        end

        it { expect { subject }.to change { dish.reload.tags.count }.by(1) }
        it { expect { subject }.to change { Menu::TagsInDish.count }.by(1) }
        it { expect { subject }.to change { Menu::Tag.count }.by(1) }
        it { expect { subject }.not_to(change { Menu::Dish.count }) }

        context "[after request]" do
          before { subject }

          it { expect(parsed_response_body).not_to include(message: String) }
          it { expect(parsed_response_body).to include(item: Hash) }
          it { expect(dish.reload.tags.count).to eq 1 }
          it { expect(dish.reload.tags.first.id).not_to eq tag.id }
        end

        context "when addition fails, should return 422 and not create any new record" do
          before do
            allow_any_instance_of(Menu::TagsInDish).to receive(:valid?).and_return(false)
            req(dish.id, tag.id, copy: true)
          end

          it { is_expected.to have_http_status(:unprocessable_entity) }
          it { expect(parsed_response_body).to include(message: String) }
          it { expect { subject }.not_to(change { dish.reload.tags.count }) }
          it { expect { subject }.not_to(change { Menu::TagsInDish.count }) }
          it { expect { subject }.not_to(change { Menu::Tag.count }) }
        end
      end
    end
  end

  describe "#remove_tag" do
    subject { req }

    before { dish.tags << tag }

    let!(:tag) { create(:menu_tag) }
    let!(:dish) { create(:menu_dish) }

    it { expect(instance).to respond_to(:remove_tag) }

    it {
      expect(subject).to route(:delete, "/v1/admin/menu/dishes/22/tags/55").to(format: :json, action: :remove_tag,
                                                                               controller: "v1/admin/menu/dishes", id: 22, tag_id: 55)
    }

    def req(dish_id = dish.id, tag_id = tag.id, params = {})
      post :remove_tag, params: params.merge(id: dish_id, tag_id:)
    end

    it { expect(dish.tags.count).to be_positive }

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
      it { expect { subject }.to change { dish.reload.tags.count }.by(-1) }
      it { expect { subject }.to change { Menu::TagsInDish.count }.by(-1) }

      context "if removing non-existing tag" do
        subject { response }

        before { req(dish.id, 999_999_999) }

        it_behaves_like NOT_FOUND
      end

      context "if removing tag from non-existing dish" do
        subject { response }

        before { req(999_999_999) }

        it_behaves_like NOT_FOUND
      end
    end
  end

  describe "#add_allergen" do
    subject { req }

    let!(:allergen) { create(:menu_allergen) }
    let!(:dish) { create(:menu_dish) }

    it { expect(instance).to respond_to(:add_allergen) }

    it {
      expect(subject).to route(:post, "/v1/admin/menu/dishes/22/allergens/55").to(format: :json, action: :add_allergen,
                                                                                  controller: "v1/admin/menu/dishes", id: 22, allergen_id: 55)
    }

    def req(dish_id = dish.id, allergen_id = allergen.id, params = {})
      post :add_allergen, params: params.merge(id: dish_id, allergen_id:)
    end

    context "when user is not authenticated" do
      before { req }

      it_behaves_like UNAUTHORIZED
    end

    context "[user is authenticated]" do
      before do
        authenticate_request(user: create(:user))
      end

      it { is_expected.to be_successful }
      it { expect { subject }.to change { dish.reload.allergens.count }.by(1) }
      it { expect { subject }.to change { Menu::AllergensInDish.count }.by(1) }
      it { expect { subject }.not_to(change { Menu::Dish.count }) }
      it { expect { subject }.not_to(change { Menu::Allergen.count }) }

      context "when adding twice same allergen" do
        before { req }

        it { expect { req }.not_to(change { dish.reload.allergens.count }) }
        it { expect { req }.not_to(change { Menu::AllergensInDish.count }) }

        context "[after second request]" do
          before { req }

          it { is_expected.to have_http_status(:unprocessable_entity) }
          it { expect(parsed_response_body).to include(message: String) }
        end
      end

      context "when adding allergen to non-existing dish" do
        subject { response }

        before { req(999_999_999) }

        it_behaves_like NOT_FOUND
      end

      context "when adding non-existing allergen to dish" do
        subject { response }

        before { req(dish.id, 999_999_999) }

        it_behaves_like NOT_FOUND
      end

      context "when adding deleted allergen to dish" do
        subject { response }

        before do
          allergen.deleted!
          req
        end

        it_behaves_like NOT_FOUND
      end

      context "when providing {copy: true}, should attach a copy of the allergen" do
        subject do
          req(dish.id, allergen.id, copy: true)
          response
        end

        it { expect { subject }.to change { dish.reload.allergens.count }.by(1) }
        it { expect { subject }.to change { Menu::AllergensInDish.count }.by(1) }
        it { expect { subject }.to change { Menu::Allergen.count }.by(1) }
        it { expect { subject }.not_to(change { Menu::Dish.count }) }

        context "[after request]" do
          before { subject }

          it { expect(parsed_response_body).not_to include(message: String) }
          it { expect(parsed_response_body).to include(item: Hash) }
          it { expect(dish.reload.allergens.count).to eq 1 }
          it { expect(dish.reload.allergens.first.id).not_to eq allergen.id }
        end

        context "when addition fails, should return 422 and not create any new record" do
          before do
            allow_any_instance_of(Menu::AllergensInDish).to receive(:valid?).and_return(false)
            req(dish.id, allergen.id, copy: true)
          end

          it { is_expected.to have_http_status(:unprocessable_entity) }
          it { expect(parsed_response_body).to include(message: String) }
          it { expect { subject }.not_to(change { dish.reload.allergens.count }) }
          it { expect { subject }.not_to(change { Menu::AllergensInDish.count }) }
          it { expect { subject }.not_to(change { Menu::Allergen.count }) }
        end
      end
    end
  end

  describe "#remove_allergen" do
    subject { req }

    before { dish.allergens << allergen }

    let!(:allergen) { create(:menu_allergen) }
    let!(:dish) { create(:menu_dish) }

    it { expect(instance).to respond_to(:remove_allergen) }

    it {
      expect(subject).to route(:delete, "/v1/admin/menu/dishes/22/allergens/55").to(format: :json, action: :remove_allergen,
                                                                                    controller: "v1/admin/menu/dishes", id: 22, allergen_id: 55)
    }

    def req(dish_id = dish.id, allergen_id = allergen.id, params = {})
      post :remove_allergen, params: params.merge(id: dish_id, allergen_id:)
    end

    it { expect(dish.allergens.count).to be_positive }

    context "when user is not authenticated" do
      before { req }

      it_behaves_like UNAUTHORIZED
    end

    context "when user is authenticated" do
      before do
        authenticate_request(user: create(:user))
      end

      it { is_expected.to be_successful }
      it { is_expected.to have_http_status(:ok) }
      it { expect { subject }.to change { dish.reload.allergens.count }.by(-1) }
      it { expect { subject }.to change { Menu::AllergensInDish.count }.by(-1) }

      it do
        req
        expect(parsed_response_body).to include(item: Hash)
        expect(parsed_response_body[:item]).to include(id: Integer, created_at: String, updated_at: String)
      end

      context "when removing non-existing allergen" do
        subject { response }

        before { req(dish.id, 999_999_999) }

        it_behaves_like NOT_FOUND
      end

      context "when removing allergen from non-existing dish" do
        subject { response }

        before { req(999_999_999) }

        it_behaves_like NOT_FOUND
      end
    end
  end

  describe "#add_image" do
    subject { req }

    let!(:image) { create(:image, :with_attached_image) }
    let!(:dish) { create(:menu_dish) }

    it { expect(instance).to respond_to(:add_image) }

    it {
      expect(subject).to route(:post, "/v1/admin/menu/dishes/22/images/55").to(format: :json, action: :add_image,
                                                                               controller: "v1/admin/menu/dishes", id: 22, image_id: 55)
    }

    def req(dish_id = dish.id, image_id = image.id, params = {})
      post :add_image, params: params.merge(id: dish_id, image_id:)
    end

    context "when user is not authenticated" do
      before { req }

      it_behaves_like UNAUTHORIZED
    end

    context "[user is authenticated]" do
      before do
        authenticate_request(user: create(:user))
      end

      it { is_expected.to be_successful }
      it { expect { subject }.to change { dish.reload.images.count }.by(1) }
      it { expect { subject }.to change { ImageToRecord.count }.by(1) }
      it { expect { subject }.not_to(change { Menu::Dish.count }) }
      it { expect { subject }.not_to(change { Image.count }) }

      context "when adding twice same image" do
        before { req }

        it { expect { req }.not_to(change { dish.reload.images.count }) }
        it { expect { req }.not_to(change { ImageToRecord.count }) }

        context "[after second request]" do
          before { req }

          it { is_expected.to have_http_status(:unprocessable_entity) }
          it { expect(parsed_response_body).to include(message: String) }
        end
      end

      context "when adding image to non-existing dish" do
        subject { response }

        before { req(999_999_999) }

        it_behaves_like NOT_FOUND
      end

      context "when adding non-existing image to dish" do
        subject { response }

        before { req(dish.id, 999_999_999) }

        it_behaves_like NOT_FOUND
      end

      context "when adding deleted image to dish" do
        subject { response }

        before do
          image.deleted!
          req
        end

        it_behaves_like NOT_FOUND
      end

      context "when providing {copy: true}, should attach a copy of the image" do
        subject do
          req(dish.id, image.id, copy: true)
          response
        end

        it { expect { subject }.to change { dish.reload.images.count }.by(1) }
        it { expect { subject }.to change { ImageToRecord.count }.by(1) }
        it { expect { subject }.to change { Image.count }.by(1) }
        it { expect { subject }.not_to(change { Menu::Dish.count }) }

        context "[after request]" do
          before { subject }

          it { expect(parsed_response_body).not_to include(message: String) }
          it { expect(parsed_response_body).to include(item: Hash) }
          it { expect(dish.reload.images.count).to eq 1 }
          it { expect(dish.reload.images.first.id).not_to eq image.id }
        end

        context "when addition fails, should return 422 and not create any new record" do
          before do
            allow_any_instance_of(ImageToRecord).to receive(:valid?).and_return(false)
            req(dish.id, image.id, copy: true)
          end

          it { is_expected.to have_http_status(:unprocessable_entity) }
          it { expect(parsed_response_body).to include(message: String) }
          it { expect { subject }.not_to(change { dish.reload.images.count }) }
          it { expect { subject }.not_to(change { ImageToRecord.count }) }
          it { expect { subject }.not_to(change { Image.count }) }
        end
      end
    end
  end

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
