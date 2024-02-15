# frozen_string_literal: true

require 'rails_helper'

RESERVATION_TAG_ADMIN_CONTROLLER_STRUCTURE = 'RESERVATION_TAG_ADMIN_CONTROLLER_STRUCTURE'
RSpec.shared_examples RESERVATION_TAG_ADMIN_CONTROLLER_STRUCTURE do |options = {}|
  it 'should have valid structure' do
    should be_a(Hash)
    should include(id: Integer, title: String, bg_color: String, color: String, created_at: String, updated_at: String)
  end

  if options
    %w[title bg_color color].each do |field|
      if options[field]
        it "should have #{options[field].to_s.inspect} #{field}" do
          should include(title: options[field])
        end
      end
    end
  end
end

RSpec.describe V1::Admin::ReservationTagsController, type: :controller do
  include_context CONTROLLER_UTILS_CONTEXT
  include_context CONTROLLER_AUTHENTICATION_CONTEXT
  include_context TESTS_OPTIMIZATIONS_CONTEXT

  let(:instance) { described_class.new }

  let(:user) { create(:user) }

  context '#index' do
    it { expect(instance).to respond_to(:index) }
    it { expect(described_class).to route(:get, '/v1/admin/reservation_tags').to(action: :index, format: :json) }

    let(:reservation_tag) { create(:reservation_tag) }

    let(:params) { {} }

    def req(data = params)
      get :index, params: data
    end

    context 'when user is not authenticated' do
      before { req }
      it_behaves_like UNAUTHORIZED
    end

    context 'when user is authenticated' do
      before do
        authenticate_request(user:)
      end

      context 'should return a Hash with {items: Array, metadata: Hash}' do
        before { req }
        subject { parsed_response_body }

        it { expect(response).to have_http_status(:ok) }
        it { should include(items: Array, metadata: Hash) }
      end

      context '[:items].sample' do
        before do
          create_list(:reservation_tag, 3)
          req
        end

        subject { parsed_response_body[:items].sample }

        it_behaves_like RESERVATION_TAG_ADMIN_CONTROLLER_STRUCTURE
        it { expect(parsed_response_body[:items].count).to eq 3 }
      end
    end
  end

  context '#update' do
    it { expect(instance).to respond_to(:update) }
    it { expect(described_class).to route(:patch, '/v1/admin/reservation_tags/21').to(id: "21", action: :update, format: :json) }

    let(:reservation_tag) { create(:reservation_tag) }

    let(:params) { {} }

    def req(id = reservation_tag.id, data = params)
      patch :update, params: data.merge(id:)
    end

    context 'when user is not authenticated' do
      before { req }
      it_behaves_like UNAUTHORIZED
    end

    context 'when user is authenticated' do
      before { authenticate_request(user:) }

      context 'when no data is provided, nothing is changed.' do
        before { reservation_tag }

        it { expect { req }.not_to change { reservation_tag.reload.as_json } }
      end

      context 'when :title is provided, will update title' do
        before { reservation_tag }
        let(:title) { Faker::Lorem.sentence }
        let(:params) { { title: } }

        it { expect { req }.to change { reservation_tag.reload.title } }
      end

      context 'when :bg_color is provided, will update bg_color' do
        before { reservation_tag }
        let(:bg_color) { Faker::Color.hex_color }
        let(:params) { { bg_color: } }

        it { expect { req }.to change { reservation_tag.reload.bg_color } }
      end

      context 'when :color is provided, will update color' do
        before { reservation_tag }
        let(:color) { Faker::Color.hex_color }
        let(:params) { { color: } }

        it { expect { req }.to change { reservation_tag.reload.color } }
      end
    end
  end

  context '#create' do
    it { expect(instance).to respond_to(:create) }
    it { expect(described_class).to route(:post, '/v1/admin/reservation_tags').to(action: :create, format: :json) }

    let(:params) { attributes_for(:reservation_tag) }

    def req(data = params)
      post :create, params: data
    end

    context 'when user is not authenticated' do
      before { req }
      it_behaves_like UNAUTHORIZED
    end

    context 'when user is authenticated' do
      before do
        authenticate_request(user:)
      end

      context 'will return items json' do
        before { req }
        subject { parsed_response_body[:item] }

        it { expect(response).to have_http_status(:ok) }

        it_behaves_like RESERVATION_TAG_ADMIN_CONTROLLER_STRUCTURE
      end

      context 'if name is missing should return 422' do
        let(:params) { { title: nil, color: Faker::Color.hex_color, bg_color: Faker::Color.hex_color } }

        it { expect { req(params) }.not_to change(ReservationTag, :count) }

        context '[after req]' do
          before { req(params) }
          subject { response }

          it { should have_http_status(:unprocessable_entity) }
          it { expect(parsed_response_body).to include(details: Hash, message: String) }
        end
      end

      context 'if color is missing should return 422' do
        let(:params) { { title: Faker::Lorem.paragraph, color: nil, bg_color: Faker::Color.hex_color } }

        it { expect { req(params) }.not_to change(ReservationTag, :count) }

        context '[after req]' do
          before { req(params) }
          subject { response }

          it { should have_http_status(:unprocessable_entity) }
          it { expect(parsed_response_body).to include(details: Hash, message: String) }
        end
      end

      context 'if bg_color is missing should return 422' do
        let(:params) { { title: Faker::Lorem.paragraph, color: Faker::Color.hex_color, bg_color: nil } }

        it { expect { req(params) }.not_to change(ReservationTag, :count) }

        context '[after req]' do
          before { req(params) }
          subject { response }

          it { should have_http_status(:unprocessable_entity) }
          it { expect(parsed_response_body).to include(details: Hash, message: String) }
        end
      end

      context 'if name, color and bg_color are provided, is ok.' do
        let(:params) { { title: Faker::Lorem.paragraph, color: Faker::Color.hex_color, bg_color: Faker::Color.hex_color } }

        it { expect { req(params) }.to change(ReservationTag, :count).by(1) }

        context '[after req]' do
          before { req(params) }
          subject { parsed_response_body[:item] }

          it { expect(response).to have_http_status(:ok) }
          it_behaves_like RESERVATION_TAG_ADMIN_CONTROLLER_STRUCTURE
        end
      end
    end
  end

  context '#destroy' do
    it { expect(instance).to respond_to(:destroy) }
    it { expect(described_class).to route(:delete, '/v1/admin/reservation_tags/77').to(id: '77', action: :destroy, format: :json) }

    let(:params) { {} }

    let(:reservation_tag) { create(:reservation_tag) }

    def req(id = reservation_tag.id, data = params)
      delete :destroy, params: data.merge(id:)
    end

    context 'when user is not authenticated' do
      before { req }
      it_behaves_like UNAUTHORIZED
    end

    context 'when user is authenticated' do
      before do
        authenticate_request(user:)
      end

      it 'will delete element from database' do
        reservation_tag
        expect { req }.to change(ReservationTag, :count).by(-1)
      end

      context 'if item could not be found' do
        before { req(999_999_999) }
        subject { response }
        it { should have_http_status(:not_found) }
      end
    end
  end
end
