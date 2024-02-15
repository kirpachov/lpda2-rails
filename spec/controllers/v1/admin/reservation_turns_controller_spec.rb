# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V1::Admin::ReservationTurnsController, type: :controller do
  include_context CONTROLLER_UTILS_CONTEXT
  include_context CONTROLLER_AUTHENTICATION_CONTEXT
  include_context TESTS_OPTIMIZATIONS_CONTEXT

  let(:instance) { described_class.new }

  let(:user) { create(:user) }

  context '#index' do
    it { expect(instance).to respond_to(:index) }
    it { expect(described_class).to route(:get, '/v1/admin/reservation_turns').to(action: :index, format: :json) }

    def req(params = {})
      get :index, params:
    end

    context 'when user is not authenticated' do
      before { req }
      it_behaves_like UNAUTHORIZED
    end

    context 'when user is authenticated' do
      before { authenticate_request(user:) }

      context 'basic' do
        before do
          create(:reservation_turn)
          req
        end

        subject { response }
        it { should have_http_status(:ok) }

        context 'response' do
          subject { parsed_response_body }
          it { should be_a(Hash) }
          it { should include(items: Array) }
          it { should_not include(:metadata) }
          it { expect(parsed_response_body[:items].count).to eq 1 }
        end
      end
    end
  end

  context '#show' do
    it { expect(instance).to respond_to(:show) }
    it { expect(described_class).to route(:get, '/v1/admin/reservation_turns/2').to(action: :show, format: :json, id: 2) }

    let(:reservation_turn) { create(:reservation_turn) }

    def req(id, params = {})
      get :show, params: params.merge(id:)
    end

    context 'when user is not authenticated' do
      before { req(2) }
      it_behaves_like UNAUTHORIZED
    end

    context 'when user is authenticated' do
      before { authenticate_request(user:) }

      context 'basic' do
        before { req(reservation_turn.id) }
        subject { response }
        it { should have_http_status(:ok) }

        context 'response' do
          subject { parsed_response_body[:item].transform_keys(&:to_sym) }
          it { should be_a(Hash) }
          it { should include(:id, :starts_at, :ends_at, :created_at, :updated_at) }
        end
      end

      context 'when passing a invalid id' do
        before { req(id: 999_999) }
        subject { response }
        it_behaves_like NOT_FOUND
      end
    end
  end

  context '#create' do
    it { expect(instance).to respond_to(:create) }
    it { expect(described_class).to route(:post, '/v1/admin/reservation_turns').to(action: :create, format: :json) }

    let(:params) { { reservation_turn: attributes_for(:reservation_turn) } }

    def req(data = params)
      post :create, params: data
    end

    context 'when user is not authenticated' do
      before { req }
      it_behaves_like UNAUTHORIZED
    end

    context '(authenticated)' do
      before { authenticate_request }

      it { expect { req(starts_at: "10:00", ends_at: "11:00", name: "Pranzo", weekday: 2) }.to change(ReservationTurn, :count).by(1) }

      context 'providing { starts_at: "10:00", ends_at: "11:00", name: "Pranzo", weekday: 2 }' do
        let(:params) { { starts_at: "10:00", ends_at: "11:00", name: "Pranzo", weekday: 2 } }
        before { req }

        subject { response }
        it { should have_http_status(:ok) }
        it 'should contain all informations' do
          expect(parsed_response_body).to include(item: Hash)
          expect(parsed_response_body[:item]).to include(:id, :starts_at, :ends_at, :created_at, :updated_at)
          expect(parsed_response_body[:item]).to include(params.transform_keys(&:to_sym))
        end

        context 'when trying to create a reservation turn with the same name and weekday' do
          before { req }

          it { should have_http_status(:unprocessable_entity) }
          it { expect(parsed_response_body).to include(details: Hash, message: String) }
        end
      end

      context 'providing { starts_at: "18:00", ends_at: "19:00", name: "Cena 1", weekday: 5 }' do
        let(:params) { { starts_at: "18:00", ends_at: "19:00", name: "Cena 1", weekday: 5 } }
        before { req }

        subject { response }
        it { should have_http_status(:ok) }
        it 'should contain all informations' do
          expect(parsed_response_body).to include(item: Hash)
          expect(parsed_response_body[:item]).to include(:id, :starts_at, :ends_at, :created_at, :updated_at)
          expect(parsed_response_body[:item]).to include(params.transform_keys(&:to_sym))
        end

        context 'when trying to create a reservation turn with the same name and weekday' do
          before { req }

          it { should have_http_status(:unprocessable_entity) }
          it { expect(parsed_response_body).to include(details: Hash, message: String) }
        end
      end
    end
  end

  context '#update' do
    it { expect(instance).to respond_to(:update) }
    it { expect(described_class).to route(:patch, '/v1/admin/reservation_turns/2').to(action: :update, id: "2", format: :json) }

    let(:reservation_turn) { create(:reservation_turn, starts_at: '10:00', ends_at: '13:00') }

    let(:params) { {} }

    def req(id = reservation_turn.id, data = params)
      patch :update, params: data.merge(id:)
    end

    context 'when user is not authenticated' do
      before { req }
      it_behaves_like UNAUTHORIZED
    end

    context '(authenticated)' do
      before { authenticate_request }

      it do
        reservation_turn
        expect { req(reservation_turn.id, starts_at: "10:00") }.not_to change(ReservationTurn, :count)
      end

      context 'providing { starts_at: "11:00" }' do
        let(:params) { { starts_at: "11:00" } }
        before { req }

        subject { response }
        it { should have_http_status(:ok) }
        it 'should contain all informations' do
          expect(parsed_response_body).to include(item: Hash)
          expect(parsed_response_body[:item]).to include(:id, :starts_at, :ends_at, :created_at, :updated_at)
          expect(parsed_response_body[:item]).to include(params.transform_keys(&:to_sym))
        end
      end

      context 'providing { weekday: 5 }' do
        let(:params) { { weekday: 5 } }
        before { req }

        subject { response }
        it { should have_http_status(:ok) }
        it 'should contain all informations' do
          expect(parsed_response_body).to include(item: Hash)
          expect(parsed_response_body[:item]).to include(:id, :starts_at, :ends_at, :created_at, :updated_at)
          expect(parsed_response_body[:item]).to include(params.transform_keys(&:to_sym))
        end
      end
    end
  end

  context '#destroy' do
    it { expect(instance).to respond_to(:destroy) }
    it { expect(described_class).to route(:delete, '/v1/admin/reservation_turns/2').to(action: :destroy, id: "2", format: :json) }

    let(:reservation_turn) { create(:reservation_turn) }

    def req(id = reservation_turn.id)
      delete :destroy, params: { id: id }
    end

    context 'when user is not authenticated' do
      before { req }
      it_behaves_like UNAUTHORIZED
    end

    context '(authenticated)' do
      before { authenticate_request }

      it do
        reservation_turn
        expect { req(reservation_turn.id) }.to change(ReservationTurn, :count).by(-1)
      end

      context 'when trying to delete a non-existing reservation turn' do
        before { req(999_999) }
        subject { response }
        it_behaves_like NOT_FOUND
      end
    end
  end
end