# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V1::Admin::Menu::IngredientsController, type: :controller do
  include_context CONTROLLER_UTILS_CONTEXT
  include_context CONTROLLER_AUTHENTICATION_CONTEXT
  include_context TESTS_OPTIMIZATIONS_CONTEXT

  let(:instance) { described_class.new }

  context '#index' do
    it { expect(instance).to respond_to(:index) }
    it { should route(:get, '/v1/admin/menu/ingredients').to(format: :json, action: :index, controller: 'v1/admin/menu/ingredients') }

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

      context 'when there are no ingredients' do
        before { req }
        it { expect(parsed_response_body).to include(items: []) }
        it { expect(parsed_response_body).to include(metadata: Hash) }
      end

      context 'when there are some ingredients' do
        before do
          create_list(:menu_ingredient, 5)
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

      context 'when ingredients have images' do
        before do
          create(:menu_ingredient).images = [create(:image, :with_attached_image)]
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
        let!(:menu_ingredient) { create(:menu_ingredient, name: name, description: nil) }
        before do
          create(:menu_ingredient, name: 'second', description: nil)
        end

        context 'checking mock data' do
          it { expect(Menu::Ingredient.count).to eq(2) }
          it { expect(Menu::Ingredient.where_name(name).count).to eq(1) }
        end

        context 'when filtering by name {query: <name>}' do
          before { req(query: name) }
          subject { parsed_response_body[:items] }
          it { is_expected.to be_an(Array) }
          it { is_expected.to include(include(id: menu_ingredient.id)) }
          it { expect(subject.size).to eq 1 }
        end
      end

      context 'when filtering by description' do
        let(:description) { 'first' }
        let!(:menu_ingredient) { create(:menu_ingredient, name: nil, description:) }
        before do
          create(:menu_ingredient, name: nil, description: 'second')
        end

        context 'checking mock data' do
          it { expect(Menu::Ingredient.count).to eq(2) }
          it { expect(Menu::Ingredient.where_description(description).count).to eq(1) }
        end

        context 'when filtering by description {query: <description>}' do
          before { req(query: description) }
          subject { parsed_response_body[:items] }
          it { is_expected.to be_an(Array) }
          it { is_expected.to include(include(id: menu_ingredient.id)) }
          it { expect(subject.size).to eq 1 }
        end
      end
    end
  end

  context '#show' do
    it { expect(instance).to respond_to(:show) }
    it { should route(:get, '/v1/admin/menu/ingredients/1').to(format: :json, action: :show, controller: 'v1/admin/menu/ingredients', id: 1) }
    let(:menu_ingredient) { create(:menu_ingredient) }

    def req(id, params = {})
      get :show, params: params.merge(id:)
    end

    context 'when user is not authenticated' do
      before { req(menu_ingredient.id) }
      it_behaves_like UNAUTHORIZED
    end

    context '[user is authenticated]' do
      before do
        authenticate_request(user: create(:user))
      end

      it { expect(req(menu_ingredient.id)).to be_successful }

      context 'when item does not exist' do
        before { req(999_999_999) }
        subject { response }
        it_behaves_like NOT_FOUND
      end

      context 'when item exists' do
        before { req(menu_ingredient.id) }
        subject { parsed_response_body[:item] }

        it { is_expected.to include(id: menu_ingredient.id) }
        it { is_expected.to include(name: menu_ingredient.name) }
        it { is_expected.to include(description: menu_ingredient.description) }
        it { is_expected.to include(images: Array) }
      end
    end
  end

  context '#update' do
    it { expect(instance).to respond_to(:update) }
    it { should route(:patch, '/v1/admin/menu/ingredients/22').to(format: :json, action: :update, controller: 'v1/admin/menu/ingredients', id: 22) }
    let(:menu_ingredient) { create(:menu_ingredient) }

    def req(id, params = {})
      patch :update, params: params.merge(id:)
    end

    context 'when user is not authenticated' do
      before { req(menu_ingredient.id, name: Faker::Lorem.sentence) }
      it_behaves_like UNAUTHORIZED
    end

    context '[user is authenticated]' do
      before do
        authenticate_request(user: create(:user))
      end

      it { expect(req(menu_ingredient.id)).to be_successful }

      context 'when item does not exist' do
        before { req(999_999_999) }
        subject { response }
        it_behaves_like NOT_FOUND
      end

      context 'when updating name {name: <string>}' do
        let(:new_name) { Faker::Lorem.sentence }
        before { req(menu_ingredient.id, name: new_name, description: 'desc') }
        subject { parsed_response_body[:item] }
        it { is_expected.to include(id: menu_ingredient.id) }
        it { is_expected.to include(name: new_name) }
        it { is_expected.to include(description: 'desc') }
        it { expect(response).to be_successful }
      end

      context 'when updating description {description: <string>}' do
        let(:new_description) { Faker::Lorem.sentence }
        before { req(menu_ingredient.id, description: new_description, name: 'wassa') }
        subject { parsed_response_body[:item] }
        it { is_expected.to include(id: menu_ingredient.id) }
        it { is_expected.to include(description: new_description) }
        it { is_expected.to include(name: 'wassa') }
        it { expect(response).to be_successful }
      end

      context 'when setting name to nil {name: nil}' do
        before { req(menu_ingredient.id, name: nil) }
        subject { parsed_response_body[:item] }
        it { is_expected.to include(id: menu_ingredient.id) }
        it { is_expected.to include(name: nil) }
        it { expect(response).to be_successful }
      end

      context 'when setting description to nil {description: nil}' do
        before { req(menu_ingredient.id, description: nil) }
        subject { parsed_response_body[:item] }
        it { is_expected.to include(id: menu_ingredient.id) }
        it { is_expected.to include(description: nil) }
        it { expect(response).to be_successful }
      end

      context 'when setting name with hash {name: {<locale>: <string>}}' do
        let(:new_name) { Faker::Lorem.sentence }
        before { req(menu_ingredient.id, name: { en: new_name }) }
        subject { parsed_response_body[:item] }
        it { is_expected.to include(id: menu_ingredient.id) }
        it { is_expected.to include(name: new_name) }
        it { expect(response).to be_successful }
      end

      context 'when setting description with hash {description: {<locale>: <string>}}' do
        let(:new_description) { Faker::Lorem.sentence }
        before { req(menu_ingredient.id, description: { en: new_description }) }
        subject { parsed_response_body[:item] }
        it { is_expected.to include(id: menu_ingredient.id) }
        it { is_expected.to include(description: new_description) }
        it { expect(response).to be_successful }
      end

      context 'when setting name to nil with hash {name: {<locale>: nil}}' do
        let(:menu_ingredient) { create(:menu_ingredient, name: 'Ingredient name before') }
        before { req(menu_ingredient.id, name: { en: nil }) }
        subject { parsed_response_body[:item] }
        it { is_expected.to include(id: menu_ingredient.id) }
        it { is_expected.to include(name: nil) }
        it { expect(response).to be_successful }
      end

      context 'when setting name to nil with {name: nil}' do
        let(:menu_ingredient) { create(:menu_ingredient, name: 'Ingredient name before') }
        before { req(menu_ingredient.id, name: nil) }
        subject { parsed_response_body[:item] }
        it { is_expected.to include(id: menu_ingredient.id) }
        it { is_expected.to include(name: nil) }
        it { expect(response).to be_successful }
      end
    end
  end

  context '#create' do
    it { expect(instance).to respond_to(:create) }
    it { should route(:post, '/v1/admin/menu/ingredients').to(format: :json, action: :create, controller: 'v1/admin/menu/ingredients') }

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

      it { expect { req(description: 'desc') }.to change(Menu::Ingredient, :count).by(1) }
      context 'when creating new ingredient with {description: <string>}' do
        before { req(description: 'desc') }
        subject { parsed_response_body[:item] }
        it { is_expected.to include(name: nil) }
        it { is_expected.to include(description: 'desc') }
        it { expect(response).to be_successful }
      end

      it { expect { req(name: 'wassa') }.to change(Menu::Ingredient, :count).by(1) }
      context 'when creating new ingredient with {name: <string>}' do
        before { req(name: 'wassa') }
        subject { parsed_response_body[:item] }
        it { is_expected.to include(description: nil) }
        it { is_expected.to include(name: 'wassa') }
        it { expect(response).to be_successful }
      end

      it { expect { req }.to change(Menu::Ingredient, :count).by(1) }
      context 'when creating new ingredient with {}' do
        before { req }
        subject { parsed_response_body[:item] }
        it { is_expected.to include(name: nil) }
        it { is_expected.to include(description: nil) }
        it { expect(response).to be_successful }
      end

      it { expect { req(name: 'wassa', description: 'bratan') }.to change(Menu::Ingredient, :count).by(1) }
      context 'when creating new ingredient with {name: <name>, description: <description>}' do
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
    it { should route(:delete, '/v1/admin/menu/ingredients/22').to(format: :json, action: :destroy, controller: 'v1/admin/menu/ingredients', id: 22) }
    let(:menu_ingredient) { create(:menu_ingredient) }

    def req(id, params = {})
      delete :destroy, params: params.merge(id:)
    end

    context 'when user is not authenticated' do
      before { req(menu_ingredient.id) }
      it_behaves_like UNAUTHORIZED
    end

    context '[user is authenticated]' do
      before do
        authenticate_request(user: create(:user))
      end

      it { expect(req(menu_ingredient.id)).to be_successful }

      context 'when item does not exist' do
        before { req(999_999_999) }
        subject { response }
        it_behaves_like NOT_FOUND
      end

      it "should not delete item from database but update its status" do
        menu_ingredient

        expect { req(menu_ingredient.id) }.not_to change(Menu::Ingredient, :count)
        expect(Menu::Ingredient.find(menu_ingredient.id).status).to eq('deleted')
      end

      context 'when item exists' do
        before { req(menu_ingredient.id) }
        subject { parsed_response_body }

        it { expect(response).to be_successful }
        it { should eq({}) }
      end
    end
  end
end
