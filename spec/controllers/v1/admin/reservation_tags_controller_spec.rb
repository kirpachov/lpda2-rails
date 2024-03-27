# frozen_string_literal: true

require 'rails_helper'

RESERVATION_TAG_ADMIN_CONTROLLER_STRUCTURE = 'RESERVATION_TAG_ADMIN_CONTROLLER_STRUCTURE'
RSpec.shared_examples RESERVATION_TAG_ADMIN_CONTROLLER_STRUCTURE do |options = {}|
  it 'has valid structure' do
    expect(subject).to be_a(Hash)
    expect(subject).to include(id: Integer, title: String, bg_color: String, color: String, created_at: String,
                               updated_at: String)
  end

  if options
    %w[title bg_color color].each do |field|
      next unless options[field]

      it "has #{options[field].to_s.inspect} #{field}" do
        expect(subject).to include(title: options[field])
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

  describe '#index' do
    let(:params) { {} }
    let(:reservation_tag) { create(:reservation_tag) }

    it { expect(instance).to respond_to(:index) }
    it { expect(described_class).to route(:get, '/v1/admin/reservation_tags').to(action: :index, format: :json) }

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
        subject { parsed_response_body }

        before { req }

        it { expect(response).to have_http_status(:ok) }
        it { is_expected.to include(items: Array, metadata: Hash) }
      end

      context '[:items].sample' do
        subject { parsed_response_body[:items].sample }

        before do
          create_list(:reservation_tag, 3)
          req
        end

        it_behaves_like RESERVATION_TAG_ADMIN_CONTROLLER_STRUCTURE
        it { expect(parsed_response_body[:items].count).to eq 3 }
      end
    end
  end

  describe '#update' do
    let(:params) { {} }
    let(:reservation_tag) { create(:reservation_tag) }

    it { expect(instance).to respond_to(:update) }

    it {
      expect(described_class).to route(:patch, '/v1/admin/reservation_tags/21').to(id: '21', action: :update,
                                                                                   format: :json)
    }

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

        it { expect { req }.not_to(change { reservation_tag.reload.as_json }) }
      end

      context 'when :title is provided, will update title' do
        before { reservation_tag }

        let(:title) { Faker::Lorem.sentence }
        let(:params) { { title: } }

        it { expect { req }.to(change { reservation_tag.reload.title }) }
      end

      context 'when :bg_color is provided, will update bg_color' do
        before { reservation_tag }

        let(:bg_color) { Faker::Color.hex_color }
        let(:params) { { bg_color: } }

        it { expect { req }.to(change { reservation_tag.reload.bg_color }) }
      end

      context 'when :color is provided, will update color' do
        before { reservation_tag }

        let(:color) { Faker::Color.hex_color }
        let(:params) { { color: } }

        it { expect { req }.to(change { reservation_tag.reload.color }) }
      end
    end
  end

  describe '#create' do
    let(:params) { attributes_for(:reservation_tag) }

    it { expect(instance).to respond_to(:create) }
    it { expect(described_class).to route(:post, '/v1/admin/reservation_tags').to(action: :create, format: :json) }

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
        subject { parsed_response_body[:item] }

        before { req }

        it { expect(response).to have_http_status(:ok) }

        it_behaves_like RESERVATION_TAG_ADMIN_CONTROLLER_STRUCTURE
      end

      context 'if name is missing should return 422' do
        let(:params) { { title: nil, color: Faker::Color.hex_color, bg_color: Faker::Color.hex_color } }

        it { expect { req(params) }.not_to change(ReservationTag, :count) }

        context '[after req]' do
          subject { response }

          before { req(params) }

          it { is_expected.to have_http_status(:unprocessable_entity) }
          it { expect(parsed_response_body).to include(details: Hash, message: String) }
        end
      end

      context 'if color is missing should return 422' do
        let(:params) { { title: Faker::Lorem.paragraph, color: nil, bg_color: Faker::Color.hex_color } }

        it { expect { req(params) }.not_to change(ReservationTag, :count) }

        context '[after req]' do
          subject { response }

          before { req(params) }

          it { is_expected.to have_http_status(:unprocessable_entity) }
          it { expect(parsed_response_body).to include(details: Hash, message: String) }
        end
      end

      context 'if bg_color is missing should return 422' do
        let(:params) { { title: Faker::Lorem.paragraph, color: Faker::Color.hex_color, bg_color: nil } }

        it { expect { req(params) }.not_to change(ReservationTag, :count) }

        context '[after req]' do
          subject { response }

          before { req(params) }

          it { is_expected.to have_http_status(:unprocessable_entity) }
          it { expect(parsed_response_body).to include(details: Hash, message: String) }
        end
      end

      context 'if name, color and bg_color are provided, is ok.' do
        let(:params) do
          { title: Faker::Lorem.paragraph, color: Faker::Color.hex_color, bg_color: Faker::Color.hex_color }
        end

        it { expect { req(params) }.to change(ReservationTag, :count).by(1) }

        context '[after req]' do
          subject { parsed_response_body[:item] }

          before { req(params) }

          it { expect(response).to have_http_status(:ok) }

          it_behaves_like RESERVATION_TAG_ADMIN_CONTROLLER_STRUCTURE
        end
      end
    end
  end

  describe '#destroy' do
    let(:reservation_tag) { create(:reservation_tag) }
    let(:params) { {} }

    it { expect(instance).to respond_to(:destroy) }

    it {
      expect(described_class).to route(:delete, '/v1/admin/reservation_tags/77').to(id: '77', action: :destroy,
                                                                                    format: :json)
    }

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

      it 'deletes element from database' do
        reservation_tag
        expect { req }.to change(ReservationTag, :count).by(-1)
      end

      context 'if item could not be found' do
        subject { response }

        before { req(999_999_999) }

        it { is_expected.to have_http_status(:not_found) }
      end
    end
  end
end
