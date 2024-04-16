# frozen_string_literal: true

require "rails_helper"

RSpec.describe V1::Admin::ReservationTurnsController, type: :controller do
  include_context CONTROLLER_UTILS_CONTEXT
  include_context CONTROLLER_AUTHENTICATION_CONTEXT
  include_context TESTS_OPTIMIZATIONS_CONTEXT

  let(:instance) { described_class.new }

  let(:user) { create(:user) }

  describe "#index" do
    it { expect(instance).to respond_to(:index) }
    it { expect(described_class).to route(:get, "/v1/admin/reservation_turns").to(action: :index, format: :json) }

    def req(params = {})
      get :index, params:
    end

    context "when user is not authenticated" do
      before { req }

      it_behaves_like UNAUTHORIZED
    end

    context "when user is authenticated" do
      before { authenticate_request(user:) }

      context "basic" do
        subject { response }

        before do
          create(:reservation_turn)
          req
        end

        it { is_expected.to have_http_status(:ok) }

        context "response" do
          subject { parsed_response_body }

          it { is_expected.to be_a(Hash) }
          it { is_expected.to include(items: Array) }
          it { expect(parsed_response_body[:items].count).to eq 1 }
          it { expect(parsed_response_body).to include(metadata: Hash) }
          it { expect(parsed_response_body.dig(:metadata, :offset)).to eq 0 }
        end
      end

      context "when filtering by {date: 'YYY-MM-dd'}" do
        subject { parsed_response_body }

        before do
          create(:reservation_turn, weekday: 0, starts_at: "10:00", ends_at: "13:00")
          create(:reservation_turn, weekday: 1, starts_at: "18:00", ends_at: "19:00")
          req(date: (Time.now.end_of_week + 1.day).strftime("%Y-%m-%d"))
        end

        it { expect(subject.dig(:metadata, :total_count)).to eq 1 }
      end

      context "when filtering by query" do
        subject { parsed_response_body }

        before do
          create(:reservation_turn, weekday: 0, name: "First", starts_at: "10:00", ends_at: "13:00")
          create(:reservation_turn, weekday: 1, name: "Last", starts_at: "18:00", ends_at: "19:00")
          req(query: "First")
        end

        it { expect(subject.dig(:metadata, :total_count)).to eq 1 }
        it { expect(subject[:items]).to all(include(name: "First")) }
      end
    end
  end

  describe "#show" do
    let(:reservation_turn) { create(:reservation_turn) }

    it { expect(instance).to respond_to(:show) }

    it {
      expect(described_class).to route(:get, "/v1/admin/reservation_turns/2").to(action: :show, format: :json, id: 2)
    }

    def req(id, params = {})
      get :show, params: params.merge(id:)
    end

    context "when user is not authenticated" do
      before { req(2) }

      it_behaves_like UNAUTHORIZED
    end

    context "when user is authenticated" do
      before { authenticate_request(user:) }

      context "basic" do
        subject { response }

        before { req(reservation_turn.id) }

        it { is_expected.to have_http_status(:ok) }

        context "response" do
          subject { parsed_response_body[:item].transform_keys(&:to_sym) }

          it { is_expected.to be_a(Hash) }
          it { is_expected.to include(:id, :starts_at, :ends_at, :created_at, :updated_at) }
        end
      end

      context "when passing a invalid id" do
        subject { response }

        before { req(id: 999_999) }

        it_behaves_like NOT_FOUND
      end
    end
  end

  describe "#create" do
    let(:params) { { reservation_turn: attributes_for(:reservation_turn) } }

    it { expect(instance).to respond_to(:create) }
    it { expect(described_class).to route(:post, "/v1/admin/reservation_turns").to(action: :create, format: :json) }

    def req(data = params)
      post :create, params: data
    end

    context "when user is not authenticated" do
      before { req }

      it_behaves_like UNAUTHORIZED
    end

    context "(authenticated)" do
      before { authenticate_request }

      it {
        expect do
          req(starts_at: "10:00", ends_at: "11:00", name: "Pranzo", weekday: 2)
        end.to change(ReservationTurn, :count).by(1)
      }

      context 'providing { starts_at: "10:00", ends_at: "11:00", name: "Pranzo", weekday: 2 }' do
        subject { response }

        let(:params) { { starts_at: "10:00", ends_at: "11:00", name: "Pranzo", weekday: 2 } }

        before { req }

        it { is_expected.to have_http_status(:ok) }

        it "contains all informations" do
          expect(parsed_response_body).to include(item: Hash)
          expect(parsed_response_body[:item]).to include(:id, :starts_at, :ends_at, :created_at, :updated_at)
          expect(parsed_response_body[:item]).to include(params.transform_keys(&:to_sym))
        end

        context "when trying to create a reservation turn with the same name and weekday" do
          before { req }

          it { is_expected.to have_http_status(:unprocessable_entity) }
          it { expect(parsed_response_body).to include(details: Hash, message: String) }
        end
      end

      context 'providing { starts_at: "18:00", ends_at: "19:00", name: "Cena 1", weekday: 5 }' do
        subject { response }

        let(:params) { { starts_at: "18:00", ends_at: "19:00", name: "Cena 1", weekday: 5 } }

        before { req }

        it { is_expected.to have_http_status(:ok) }

        it "contains all informations" do
          expect(parsed_response_body).to include(item: Hash)
          expect(parsed_response_body[:item]).to include(:id, :starts_at, :ends_at, :created_at, :updated_at)
          expect(parsed_response_body[:item]).to include(params.transform_keys(&:to_sym))
        end

        context "when trying to create a reservation turn with the same name and weekday" do
          before { req }

          it { is_expected.to have_http_status(:unprocessable_entity) }
          it { expect(parsed_response_body).to include(details: Hash, message: String) }
        end
      end
    end
  end

  describe "#update" do
    let(:params) { {} }
    let(:reservation_turn) { create(:reservation_turn, starts_at: "10:00", ends_at: "13:00") }

    it { expect(instance).to respond_to(:update) }

    it {
      expect(described_class).to route(:patch, "/v1/admin/reservation_turns/2").to(action: :update, id: "2",
                                                                                   format: :json)
    }

    def req(id = reservation_turn.id, data = params)
      patch :update, params: data.merge(id:)
    end

    context "when user is not authenticated" do
      before { req }

      it_behaves_like UNAUTHORIZED
    end

    context "(authenticated)" do
      before { authenticate_request }

      it do
        reservation_turn
        expect { req(reservation_turn.id, starts_at: "10:00") }.not_to change(ReservationTurn, :count)
      end

      context 'providing { starts_at: "11:00" }' do
        subject { response }

        let(:params) { { starts_at: "11:00" } }

        before { req }

        it { is_expected.to have_http_status(:ok) }

        it "contains all informations" do
          expect(parsed_response_body).to include(item: Hash)
          expect(parsed_response_body[:item]).to include(:id, :starts_at, :ends_at, :created_at, :updated_at)
          expect(parsed_response_body[:item]).to include(params.transform_keys(&:to_sym))
        end
      end

      context "providing { weekday: 5 }" do
        subject { response }

        let(:params) { { weekday: 5 } }

        before { req }

        it { is_expected.to have_http_status(:ok) }

        it "contains all informations" do
          expect(parsed_response_body).to include(item: Hash)
          expect(parsed_response_body[:item]).to include(:id, :starts_at, :ends_at, :created_at, :updated_at)
          expect(parsed_response_body[:item]).to include(params.transform_keys(&:to_sym))
        end
      end
    end
  end

  describe "#destroy" do
    let(:reservation_turn) { create(:reservation_turn) }

    it { expect(instance).to respond_to(:destroy) }

    it {
      expect(described_class).to route(:delete, "/v1/admin/reservation_turns/2").to(action: :destroy, id: "2",
                                                                                    format: :json)
    }

    def req(id = reservation_turn.id)
      delete :destroy, params: { id: }
    end

    context "when user is not authenticated" do
      before { req }

      it_behaves_like UNAUTHORIZED
    end

    context "(authenticated)" do
      before { authenticate_request }

      it do
        reservation_turn
        expect { req(reservation_turn.id) }.to change(ReservationTurn, :count).by(-1)
      end

      context "when trying to delete a non-existing reservation turn" do
        subject { response }

        before { req(999_999) }

        it_behaves_like NOT_FOUND
      end
    end
  end
end
