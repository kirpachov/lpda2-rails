# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V1::Admin::Menu::DishesController, type: :controller do
  include_context CONTROLLER_UTILS_CONTEXT
  include_context CONTROLLER_AUTHENTICATION_CONTEXT
  include_context TESTS_OPTIMIZATIONS_CONTEXT

  let(:instance) { described_class.new }

  context '#index' do
    it { expect(instance).to respond_to(:index) }
    it { should route(:get, '/v1/admin/menu/dishes').to(format: :json, action: :index, controller: 'v1/admin/menu/dishes') }

    def req(params = {})
      get :index, params: params
    end

    context 'when user is not authenticated' do
      before { req }
      it_behaves_like UNAUTHORIZED
    end

    context '[user is authenticated]' do
      before do
        authenticate_request(user: create(:user))
      end

      it { expect(req).to be_successful }

      context 'when there are no dishes' do
        before { req }
        it { expect(parsed_response_body).to include(items: []) }
        it { expect(parsed_response_body).to include(metadata: Hash) }
      end

      context 'when there are some dishes' do
        before do
          create_list(:menu_dish, 5, :with_name, :with_description)
          req
        end

        it { expect(parsed_response_body).to include(items: Array) }
        it { expect(parsed_response_body).to include(metadata: Hash) }
        it { expect(parsed_response_body[:items].size).to eq(5) }

        context 'checking items structure' do
          subject { parsed_response_body[:items].sample }
          it { is_expected.to include(id: Integer) }
          it { is_expected.to include(name: String) }
          it { is_expected.to include(description: String) }
          it { is_expected.to include(images: Array) }
        end
      end

      context 'when dishes have images' do
        before do
          create(:menu_dish).images = [create(:image, :with_attached_image)]
          req
        end

        context 'checking images structure' do
          subject { parsed_response_body[:items].sample[:images].sample }
          it { should include(id: Integer) }
          it { should include(url: String) }
          it { should include(filename: String) }
        end
      end

      context 'when filtering by name' do
        let(:name) { 'first' }
        let!(:menu_dish) { create(:menu_dish, name: name, description: nil) }
        before do
          create(:menu_dish, name: 'second', description: nil)
        end

        context 'checking mock data' do
          it { expect(Menu::Dish.count).to eq(2) }
          it { expect(Menu::Dish.where_name(name).count).to eq(1) }
        end

        context 'when filtering by name {query: <name>}' do
          before { req(query: name) }
          subject { parsed_response_body[:items] }
          it { is_expected.to be_an(Array) }
          it { is_expected.to include(include(id: menu_dish.id)) }
          it { expect(subject.size).to eq 1 }
        end
      end

      context 'when filtering by description' do
        let(:description) { 'first' }
        let!(:menu_dish) { create(:menu_dish, name: nil, description:) }
        before do
          create(:menu_dish, name: nil, description: 'second')
        end

        context 'checking mock data' do
          it { expect(Menu::Dish.count).to eq(2) }
          it { expect(Menu::Dish.where_description(description).count).to eq(1) }
        end

        context 'when filtering by description {query: <description>}' do
          before { req(query: description) }
          subject { parsed_response_body[:items] }
          it { is_expected.to be_an(Array) }
          it { is_expected.to include(include(id: menu_dish.id)) }
          it { expect(subject.size).to eq 1 }
        end
      end

      context 'when filtering by status {status: :active}' do
        before do
          Menu::Dish.delete_all
          create(:menu_dish, status: :active)
          create(:menu_dish, status: :deleted)
        end

        subject do
          req(status: :active)
          parsed_response_body[:items]
        end

        it { expect(Menu::Dish.count).to eq 2 }
        it { expect(Menu::Dish.visible.count).to eq 1 }
        it { expect(subject.size).to eq 1 }
        it { expect(subject.first[:status]).to eq 'active' }
      end

      context 'when filtering by status {status: :deleted}' do
        before do
          Menu::Dish.delete_all
          create(:menu_dish, status: :active)
          create(:menu_dish, status: :deleted)
        end

        subject do
          req(status: :deleted)
          parsed_response_body[:items]
        end

        it { expect(Menu::Dish.count).to eq 2 }
        it { expect(Menu::Dish.visible.count).to eq 1 }
        it { is_expected.to be_empty }
      end

      context 'when filtering by price {price: 15}' do
        before do
          Menu::Dish.delete_all
          create(:menu_dish, price: 15)
          create(:menu_dish, price: 15)
          create(:menu_dish, price: 16)
        end

        subject do
          req(price: 15)
          parsed_response_body[:items]
        end

        it { expect(Menu::Dish.count).to eq 3 }
        it { expect(Menu::Dish.pluck(:price).uniq).to match_array([15, 16]) }
        it { expect(subject.size).to eq 2 }
        it { expect(subject).to all(include(price: 15)) }
      end

      context 'when filtering by price {price: "15.5"}' do
        before do
          Menu::Dish.delete_all
          create(:menu_dish, price: 10) # making test fail to check if arrives email from github ci
          create(:menu_dish, price: 15)
          create(:menu_dish, price: 16)
        end

        subject do
          req(price: "15.5")
          parsed_response_body[:items]
        end

        it { expect(Menu::Dish.count).to eq 3 }
        it { expect(Menu::Dish.pluck(:price).uniq).to match_array([15, 16]) }
        it { expect(subject.size).to eq 0 }
      end

      context 'when filtering by price {price: "15.5"}' do
        before do
          Menu::Dish.delete_all
          create(:menu_dish, price: 15.5)
          create(:menu_dish, price: 15)
          create(:menu_dish, price: 16)
        end

        subject do
          req(price: "15.5")
          parsed_response_body[:items]
        end

        it { expect(Menu::Dish.count).to eq 3 }
        it { expect(Menu::Dish.pluck(:price).uniq).to match_array([15.5, 15, 16]) }
        it { expect(subject.size).to eq 1 }
        it { expect(subject).to all(include(price: 15.5)) }
      end

      context 'when filtering by price {price: 15.5}' do
        before do
          Menu::Dish.delete_all
          create(:menu_dish, price: 15.5)
          create(:menu_dish, price: 15)
          create(:menu_dish, price: 16)
        end

        subject do
          req(price: 15.5)
          parsed_response_body[:items]
        end

        it { expect(Menu::Dish.count).to eq 3 }
        it { expect(Menu::Dish.pluck(:price).uniq).to match_array([15, 15.5, 16]) }
        it { expect(subject.size).to eq 1 }
        it { expect(subject).to all(include(price: 15.5)) }
      end

      context 'when filtering by price {price: {less_than: 10}' do
        before do
          Menu::Dish.delete_all
          create(:menu_dish, price: 8)
          create(:menu_dish, price: 10)
          create(:menu_dish, price: 12)
        end

        subject do
          req(price: { less_than: 10 })
          parsed_response_body[:items]
        end

        it { expect(Menu::Dish.count).to eq 3 }
        it { expect(Menu::Dish.pluck(:price).uniq).to match_array([8, 10, 12]) }
        it { expect(subject.size).to eq 2 }
        it { expect(subject).to all(include(price: Numeric)) }
        it { expect(subject.map { |j| j[:price] }).to match_array([8, 10]) }
      end

      context 'when filtering by price {price: {more_than: 10}' do
        before do
          Menu::Dish.delete_all
          create(:menu_dish, price: 8)
          create(:menu_dish, price: 10)
          create(:menu_dish, price: 12)
        end

        subject do
          req(price: { more_than: 10 })
          parsed_response_body[:items]
        end

        it { expect(Menu::Dish.count).to eq 3 }
        it { expect(Menu::Dish.pluck(:price).uniq).to match_array([8, 10, 12]) }
        it { expect(subject.size).to eq 2 }
        it { expect(subject).to all(include(price: Numeric)) }
        it { expect(subject.map { |j| j[:price] }).to match_array([10, 12]) }
      end

      context 'when filtering by price {price: {more_than: 10.1}' do
        before do
          Menu::Dish.delete_all
          create(:menu_dish, price: 8)
          create(:menu_dish, price: 10)
          create(:menu_dish, price: 12)
        end

        subject do
          req(price: { more_than: 10.1 })
          parsed_response_body[:items]
        end

        it { expect(Menu::Dish.count).to eq 3 }
        it { expect(Menu::Dish.pluck(:price).uniq).to match_array([8, 10, 12]) }
        it { expect(subject.size).to eq 1 }
        it { expect(subject).to all(include(price: 12)) }
      end

      context 'when filtering by price {price: {more_than: "10.1"}' do
        before do
          Menu::Dish.delete_all
          create(:menu_dish, price: 8)
          create(:menu_dish, price: 10)
          create(:menu_dish, price: 12)
        end

        subject do
          req(price: { more_than: "10.1" })
          parsed_response_body[:items]
        end

        it { expect(Menu::Dish.count).to eq 3 }
        it { expect(Menu::Dish.pluck(:price).uniq).to match_array([8, 10, 12]) }
        it { expect(subject.size).to eq 1 }
        it { expect(subject).to all(include(price: 12)) }
      end

      context 'when filtering by price {price: {more_than: "10", less_than: "12"}' do
        before do
          Menu::Dish.delete_all
          create(:menu_dish, price: 8)
          create(:menu_dish, price: 10)
          create(:menu_dish, price: 12)
          create(:menu_dish, price: 14)
        end

        subject do
          req(price: { more_than: "10", less_than: "12" })
          parsed_response_body[:items]
        end

        it { expect(Menu::Dish.count).to eq 4 }
        it { expect(Menu::Dish.pluck(:price).uniq).to match_array([8, 10, 12, 14]) }
        it { expect(subject.size).to eq 2 }
        it { expect(subject.map { |j| j[:price] }).to match_array([10, 12]) }
      end

      context 'when filtering by price {price: {more_than: "10", less_than: 11.9}' do
        before do
          Menu::Dish.delete_all
          create(:menu_dish, price: 8)
          create(:menu_dish, price: 10)
          create(:menu_dish, price: 12)
          create(:menu_dish, price: 14)
        end

        subject do
          req(price: { more_than: "10", less_than: 11.9 })
          parsed_response_body[:items]
        end

        it { expect(Menu::Dish.count).to eq 4 }
        it { expect(Menu::Dish.pluck(:price).uniq).to match_array([8, 10, 12, 14]) }
        it { expect(subject.size).to eq 1 }
        it { expect(subject.map { |j| j[:price] }).to match_array([10]) }
      end
    end
  end

  context '#update' do
    it { expect(instance).to respond_to(:update) }
    it { should route(:patch, '/v1/admin/menu/dishes/22').to(format: :json, action: :update, controller: 'v1/admin/menu/dishes', id: 22) }
    let(:menu_dish) { create(:menu_dish) }

    def req(id, params = {})
      patch :update, params: params.merge(id:)
    end

    context 'when user is not authenticated' do
      before { req(menu_dish.id, name: Faker::Lorem.sentence) }
      it_behaves_like UNAUTHORIZED
    end

    context '[user is authenticated]' do
      before do
        authenticate_request(user: create(:user))
      end

      it { expect(req(menu_dish.id)).to be_successful }

      context 'when item does not exist' do
        before { req(999_999_999) }
        subject { response }
        it_behaves_like NOT_FOUND
      end

      context 'when updating name {name: <string>}' do
        let(:new_name) { Faker::Lorem.sentence }
        before { req(menu_dish.id, name: new_name, description: 'desc') }
        subject { parsed_response_body[:item] }
        it { is_expected.to include(id: menu_dish.id) }
        it { is_expected.to include(name: new_name) }
        it { is_expected.to include(description: 'desc') }
        it { expect(response).to be_successful }
      end

      context 'when updating description {description: <string>}' do
        let(:new_description) { Faker::Lorem.sentence }
        before { req(menu_dish.id, description: new_description, name: 'wassa') }
        subject { parsed_response_body[:item] }
        it { is_expected.to include(id: menu_dish.id) }
        it { is_expected.to include(description: new_description) }
        it { is_expected.to include(name: 'wassa') }
        it { expect(response).to be_successful }
      end

      context 'when setting name to nil {name: nil}' do
        before { req(menu_dish.id, name: nil) }
        subject { parsed_response_body[:item] }
        it { is_expected.to include(id: menu_dish.id) }
        it { is_expected.to include(name: nil) }
        it { expect(response).to be_successful }
      end

      context 'when setting description to nil {description: nil}' do
        before { req(menu_dish.id, description: nil) }
        subject { parsed_response_body[:item] }
        it { is_expected.to include(id: menu_dish.id) }
        it { is_expected.to include(description: nil) }
        it { expect(response).to be_successful }
      end

      context 'when setting name with hash {name: {<locale>: <string>}}' do
        let(:new_name) { Faker::Lorem.sentence }
        before { req(menu_dish.id, name: { en: new_name }) }
        subject { parsed_response_body[:item] }
        it { is_expected.to include(id: menu_dish.id) }
        it { is_expected.to include(name: new_name) }
        it { expect(response).to be_successful }
      end

      context 'when setting description with hash {description: {<locale>: <string>}}' do
        let(:new_description) { Faker::Lorem.sentence }
        before { req(menu_dish.id, description: { en: new_description }) }
        subject { parsed_response_body[:item] }
        it { is_expected.to include(id: menu_dish.id) }
        it { is_expected.to include(description: new_description) }
        it { expect(response).to be_successful }
      end

      context 'when setting name to nil with hash {name: {<locale>: nil}}' do
        let(:menu_dish) { create(:menu_dish, name: 'Dish name before') }
        before { req(menu_dish.id, name: { en: nil }) }
        subject { parsed_response_body[:item] }
        it { is_expected.to include(id: menu_dish.id) }
        it { is_expected.to include(name: nil) }
        it { expect(response).to be_successful }
      end

      context 'when setting name to nil with {name: nil}' do
        let(:menu_dish) { create(:menu_dish, name: 'Dish name before') }
        before { req(menu_dish.id, name: nil) }
        subject { parsed_response_body[:item] }
        it { is_expected.to include(id: menu_dish.id) }
        it { is_expected.to include(name: nil) }
        it { expect(response).to be_successful }
      end

      context 'when setting price from nil to 15' do
        let(:name) { 'Dish name' }
        let(:description) { 'Dish description' }
        let(:price) { 15 }
        let(:menu_dish) { create(:menu_dish, name:, description:, price: nil) }
        before { req(menu_dish.id, price:) }
        subject { parsed_response_body[:item] }
        it { is_expected.to include(id: menu_dish.id) }
        it { is_expected.to include(name:) }
        it { is_expected.to include(description:) }
        it { is_expected.to include(price: 15.0) }
        it { expect(response).to be_successful }
      end

      context 'when setting price from nil to 15.9' do
        let(:name) { 'Dish name' }
        let(:description) { 'Dish description' }
        let(:price) { 15.9 }
        let(:menu_dish) { create(:menu_dish, name:, description:, price: nil) }
        before { req(menu_dish.id, price:) }
        subject { parsed_response_body[:item] }
        it { is_expected.to include(id: menu_dish.id) }
        it { is_expected.to include(name:) }
        it { is_expected.to include(description:) }
        it { is_expected.to include(price:) }
        it { expect(response).to be_successful }
      end

      context 'when setting price from 15.9 to nil' do
        let(:name) { 'Dish name' }
        let(:description) { 'Dish description' }
        let(:price) { 15.9 }
        let(:menu_dish) { create(:menu_dish, name:, description:, price:) }
        before { req(menu_dish.id, price: nil) }
        subject { parsed_response_body[:item] }
        it { is_expected.to include(id: menu_dish.id) }
        it { is_expected.to include(name:) }
        it { is_expected.to include(description:) }
        it { is_expected.to include(price: nil) }
        it { expect(response).to be_successful }
      end

      context 'when setting price from 15 to nil' do
        let(:name) { 'Dish name' }
        let(:description) { 'Dish description' }
        let(:price) { 15 }
        let(:menu_dish) { create(:menu_dish, name:, description:, price:) }
        before { req(menu_dish.id, price: nil) }
        subject { parsed_response_body[:item] }
        it { is_expected.to include(id: menu_dish.id) }
        it { is_expected.to include(name:) }
        it { is_expected.to include(description:) }
        it { is_expected.to include(price: nil) }
        it { expect(response).to be_successful }
      end

      context 'when setting price from 15.9 to 0' do
        let(:name) { 'Dish name' }
        let(:description) { 'Dish description' }
        let(:price) { 15.9 }
        let(:menu_dish) { create(:menu_dish, name:, description:, price:) }
        before { req(menu_dish.id, price: 0) }
        subject { parsed_response_body[:item] }
        it { is_expected.to include(id: menu_dish.id) }
        it { is_expected.to include(name:) }
        it { is_expected.to include(description:) }
        it { is_expected.to include(price: 0) }
        it { expect(response).to be_successful }
      end

      context 'when setting price from 15 to 0' do
        let(:name) { 'Dish name' }
        let(:description) { 'Dish description' }
        let(:price) { 15 }
        let(:menu_dish) { create(:menu_dish, name:, description:, price:) }
        before { req(menu_dish.id, price: 0) }
        subject { parsed_response_body[:item] }
        it { is_expected.to include(id: menu_dish.id) }
        it { is_expected.to include(name:) }
        it { is_expected.to include(description:) }
        it { is_expected.to include(price: 0) }
        it { expect(response).to be_successful }
      end
    end
  end

  context '#create' do
    it { expect(instance).to respond_to(:create) }
    it { should route(:post, '/v1/admin/menu/dishes').to(format: :json, action: :create, controller: 'v1/admin/menu/dishes') }

    def req(params = {})
      post :create, params: params
    end

    context 'when user is not authenticated' do
      before { req(name: Faker::Lorem.sentence) }
      it_behaves_like UNAUTHORIZED
    end

    context '[user is authenticated]' do
      before do
        authenticate_request(user: create(:user))
      end

      it { expect(req).to be_successful }

      it { expect { req(description: 'desc') }.to change(Menu::Dish, :count).by(1) }
      context 'when creating new dish with {description: <string>}' do
        before { req(description: 'desc') }
        subject { parsed_response_body[:item] }
        it { is_expected.to include(name: nil) }
        it { is_expected.to include(description: 'desc') }
        it { expect(response).to be_successful }
      end

      it { expect { req(price: 15) }.to change(Menu::Dish, :count).by(1) }
      context 'when creating new dish with {price: 15}' do
        before { req(price: 15) }
        subject { parsed_response_body[:item] }
        it { is_expected.to include(name: nil) }
        it { is_expected.to include(description: nil) }
        it { is_expected.to include(price: 15.0) }
        it { expect(response).to be_successful }
      end

      it { expect { req(price: 15.7) }.to change(Menu::Dish, :count).by(1) }
      context 'when creating new dish with {price: 15.7}' do
        before { req(price: 15.7) }
        subject { parsed_response_body[:item] }
        it { is_expected.to include(name: nil) }
        it { is_expected.to include(description: nil) }
        it { is_expected.to include(price: 15.7) }
        it { expect(response).to be_successful }
      end

      it { expect { req(price: "15.7") }.to change(Menu::Dish, :count).by(1) }
      context 'when creating new dish with {price: "15.7"}' do
        before { req(price: "15.7") }
        subject { parsed_response_body[:item] }
        it { is_expected.to include(name: nil) }
        it { is_expected.to include(description: nil) }
        it { is_expected.to include(price: 15.7) }
        it { expect(response).to be_successful }
      end

      it { expect { req(name: 'wassa') }.to change(Menu::Dish, :count).by(1) }
      context 'when creating new dish with {name: <string>}' do
        before { req(name: 'wassa') }
        subject { parsed_response_body[:item] }
        it { is_expected.to include(description: nil) }
        it { is_expected.to include(name: 'wassa') }
        it { expect(response).to be_successful }
      end

      it { expect { req }.to change(Menu::Dish, :count).by(1) }
      context 'when creating new dish with {}' do
        before { req }
        subject { parsed_response_body[:item] }
        it { is_expected.to include(name: nil) }
        it { is_expected.to include(description: nil) }
        it { expect(response).to be_successful }
      end

      it { expect { req(name: 'wassa', description: 'bratan') }.to change(Menu::Dish, :count).by(1) }
      context 'when creating new dish with {name: <name>, description: <description>}' do
        before { req(name: 'wassa', description: 'bratan') }
        subject { parsed_response_body[:item] }
        it { is_expected.to include(name: 'wassa') }
        it { is_expected.to include(description: 'bratan') }
        it { expect(response).to be_successful }
      end
    end
  end

  context '#destroy' do
    it { expect(instance).to respond_to(:destroy) }
    it { should route(:delete, '/v1/admin/menu/dishes/22').to(format: :json, action: :destroy, controller: 'v1/admin/menu/dishes', id: 22) }
    let(:menu_dish) { create(:menu_dish) }

    def req(id, params = {})
      delete :destroy, params: params.merge(id:)
    end

    context 'when user is not authenticated' do
      before { req(menu_dish.id) }
      it_behaves_like UNAUTHORIZED
    end

    context '[user is authenticated]' do
      before do
        authenticate_request(user: create(:user))
      end

      it { expect(req(menu_dish.id)).to be_successful }

      context 'when item does not exist' do
        before { req(999_999_999) }
        subject { response }
        it_behaves_like NOT_FOUND
      end

      it "should not delete item from database but update its status" do
        menu_dish

        expect { req(menu_dish.id) }.not_to change { Menu::Dish.count }
        expect(Menu::Dish.find(menu_dish.id).status).to eq('deleted')
      end

      it do
        menu_dish

        expect { req(menu_dish.id) }.to change { Menu::Dish.visible.count }.by(-1)
      end

      context 'when cannot delete record' do
        before do
          menu_dish
          allow_any_instance_of(Menu::Dish).to receive(:deleted!).and_return(false)
        end

        subject do
          req(menu_dish.id)
          response
        end

        it { expect { subject }.not_to change { Menu::Dish.visible.count } }
        it { should have_http_status(:unprocessable_entity) }
        it { should_not be_successful }
      end

      context 'when record deletion raises error' do
        before do
          menu_dish
          allow_any_instance_of(Menu::Dish).to receive(:deleted!).and_raise(ActiveRecord::RecordInvalid)
        end

        subject do
          req(menu_dish.id)
          response
        end

        it { expect { subject }.not_to change { Menu::Dish.visible.count } }
        it { should have_http_status(:unprocessable_entity) }
        it { should_not be_successful }
      end

      context 'when item exists' do
        before { req(menu_dish.id) }
        subject { parsed_response_body }

        it { expect(response).to be_successful }
        it { should eq({}) }
      end
    end
  end
end
