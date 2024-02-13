# frozen_string_literal: true

require 'rails_helper'

RESERVATION_TEST_STRUCTURE = 'RESERVATION_TEST_STRUCTURE'
RSpec.shared_context RESERVATION_TEST_STRUCTURE do |options = {}|
  it "should have valid structure" do
    expect(subject).to be_a(Hash)
    expect(subject).to include(id: Integer, created_at: String, updated_at: String, datetime: String, people: Integer, status: String)
  end

  # true => check presence
  # false => check absence
  # String => check exact value
  %i[phone email notes].each do |field|
    if options[field] == true
      it "should have #{field.inspect}" do
        expect(subject).to include(field.to_sym => String)
      end
    elsif options[field] == false
      it "should not have #{field}" do
        expect(subject[field].to_s).to be_blank
      end
    elsif options[field].is_a?(String)
      it "should have #{field.inspect} = #{options[field].inspect}" do
        expect(subject).to include(field.to_sym => options[field])
      end
    end
  end
end

RSpec.describe V1::Admin::ReservationsController, type: :controller do
  include_context CONTROLLER_UTILS_CONTEXT
  include_context CONTROLLER_AUTHENTICATION_CONTEXT
  include_context TESTS_OPTIMIZATIONS_CONTEXT

  let(:instance) { described_class.new }

  let(:user) { create(:user) }

  context '#index' do
    it { expect(instance).to respond_to(:index) }
    it { expect(described_class).to route(:get, '/v1/admin/reservations').to(action: :index, format: :json) }

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
          create(:reservation)
          req
        end

        subject { response }
        it { should have_http_status(:ok) }

        context 'response' do
          subject { parsed_response_body }
          it { should be_a(Hash) }
          it { should include(items: Array, metadata: Hash) }
          it { expect(parsed_response_body[:items].count).to eq 1 }
        end

        context 'response[:items][0]' do
          subject { parsed_response_body[:items][0] }
          it_behaves_like RESERVATION_TEST_STRUCTURE, phone: true, email: true, notes: true
        end
      end

      context 'when filtering by status, should return all reservations with that status' do
        before do
          create(:reservation, status: :active)
          create(:reservation, status: :deleted)
          create(:reservation, status: :noshow)
          create(:reservation, status: :cancelled)
        end

        %w[active noshow cancelled].each do |status|
          context "when filtering by status: #{status.inspect}" do
            before { req(status: status) }

            subject { response }
            it { should have_http_status(:ok) }

            context 'response' do
              subject { parsed_response_body }
              it { should be_a(Hash) }
              it { should include(items: Array, metadata: Hash) }
              it { expect(parsed_response_body[:items].count).to eq 1 }
            end

            context 'response[:items]' do
              subject { parsed_response_body[:items] }

              it { should all(include(status:)) }
            end
          end
        end
      end

      context 'when not filtering by status, should return all except deleted' do
        before do
          create(:reservation, status: :active)
          create(:reservation, status: :deleted)
          create(:reservation, status: :noshow)
          create(:reservation, status: :cancelled)
        end

        before { req }

        subject { response }
        it { should have_http_status(:ok) }

        context 'response' do
          subject { parsed_response_body }
          it { should be_a(Hash) }
          it { should include(items: Array, metadata: Hash) }
          it { expect(parsed_response_body[:items].count).to eq 3 }
        end

        context 'response[:items]' do
          subject { parsed_response_body[:items] }

          it { should all(include(status: 'active').or(include(status: 'noshow')).or(include(status: 'cancelled'))) }
          it { expect(subject.count).to eq 3 }
        end
      end

      context 'when filtering by statuses array' do
        before do
          create(:reservation, status: :active)
          create(:reservation, status: :deleted)
          create(:reservation, status: :noshow)
          create(:reservation, status: :cancelled)
        end

        before { req(status: %w[active noshow]) }

        subject { response }
        it { should have_http_status(:ok) }

        context 'response' do
          subject { parsed_response_body }
          it { should be_a(Hash) }
          it { should include(items: Array, metadata: Hash) }
          it { expect(parsed_response_body[:items].count).to eq 2 }
        end

        context 'response[:items]' do
          subject { parsed_response_body[:items] }

          it { should all(include(status: 'active').or(include(status: 'noshow'))) }
          it { expect(subject.count).to eq 2 }
        end
      end

      context 'when filtering by statuses string comma separated' do
        before do
          create(:reservation, status: :active)
          create(:reservation, status: :deleted)
          create(:reservation, status: :noshow)
          create(:reservation, status: :cancelled)
        end

        before { req(statuses: 'active, noshow') }

        subject { response }
        it { should have_http_status(:ok) }

        context 'response' do
          subject { parsed_response_body }
          it { should be_a(Hash) }
          it { should include(items: Array, metadata: Hash) }
          it { expect(parsed_response_body[:items].count).to eq 2 }
        end

        context 'response[:items]' do
          subject { parsed_response_body[:items] }

          it { should all(include(status: 'active').or(include(status: 'noshow'))) }
          it { expect(subject.count).to eq 2 }
        end
      end

      context 'search by secret' do
        before do
          create(:reservation, status: :active)
          create(:reservation, status: :active)
          create(:reservation, status: :active)
        end

        let(:secret) { Reservation.all.sample.secret }

        before { req(secret:) }

        subject { response }
        it { should have_http_status(:ok) }

        context 'response' do
          subject { parsed_response_body }
          it { should be_a(Hash) }
          it { should include(items: Array, metadata: Hash) }
          it { expect(parsed_response_body[:items].count).to eq 1 }
        end

        context 'response[:items]' do
          subject { parsed_response_body[:items] }

          it { should all(include(secret: secret)) }
        end

        context 'response[:items][0]' do
          subject { parsed_response_body[:items][0] }

          it_behaves_like RESERVATION_TEST_STRUCTURE, phone: true, email: true, notes: true
        end
      end

      context 'search by query' do
        let!(:reservations) do
          [
            create(:reservation, status: :active, fullname: 'Wassa Bratan', email: 'giuly@presley', notes: 'Please be kind'),
            create(:reservation, status: :active, fullname: 'Gigi', email: 'luis@sal', notes: 'Dont worry'),
            create(:reservation, status: :active, fullname: 'Orologio', email: 'gianni@morandi', notes: 'idk something else'),
          ]
        end

        let(:query) { nil }

        before { req(query:) }

        subject { response }

        context 'should filter by fullname' do
          let(:query) { reservations.sample.fullname.split(' ').sample }

          it { should have_http_status(:ok) }
          it { expect(parsed_response_body[:items].count).to eq 1 }
          it { expect(parsed_response_body[:items][0][:fullname]).to include(query) }
        end

        context 'should filter by email' do
          let(:query) { reservations.sample.email.split('@').first }

          it { should have_http_status(:ok) }
          it { expect(parsed_response_body[:items].count).to eq 1 }
          it { expect(parsed_response_body[:items][0][:email]).to include(query) }
        end

        context 'should filter by notes' do
          let(:query) { reservations.sample.notes.split(' ').sample }

          it { should have_http_status(:ok) }
          it { expect(parsed_response_body[:items].count).to eq 1 }
          it { expect(parsed_response_body[:items][0][:notes]).to include(query) }
        end
      end

      context 'search by date' do
        let!(:reservations) do
          [
            create(:reservation, status: :active, datetime: 1.day.from_now),
            create(:reservation, status: :active, datetime: Time.now),
            create(:reservation, status: :active, datetime: 1.day.ago),
            create(:reservation, status: :active, datetime: 2.day.ago),
            create(:reservation, status: :active, datetime: 3.day.ago),
          ]
        end

        context 'when filtering by today with {today: true}' do
          before { req(today: true) }

          subject { response }
          it { should have_http_status(:ok) }
          it { expect(parsed_response_body[:items].count).to eq 1 }
          it { expect(parsed_response_body[:items][0][:datetime].to_date).to eq Time.now.to_date }
        end

        context 'when filtering by today with {date: Date.today.to_date}' do
          before { req(date: Date.today.to_date) }

          subject { response }
          it { should have_http_status(:ok) }
          it { expect(parsed_response_body[:items].count).to eq 1 }
          it { expect(parsed_response_body[:items][0][:datetime].to_date).to eq Time.now.to_date }
        end

        context 'when filtering by {date_from: 1.day.from_now.to_date}' do
          before { req(date_from: 1.day.from_now.to_date) }

          subject { response }
          it { should have_http_status(:ok) }
          it { expect(parsed_response_body[:items].count).to eq 1 }
          it { expect(parsed_response_body[:items].map { |item| item[:datetime].to_date }).to all(eq(1.day.from_now.to_date.to_date)) }
        end

        context 'when filtering by {date_from: 1.day.from_now.to_date, date_to: 1.day.from_now.to_date}' do
          before { req(date_from: 1.day.from_now.to_date, date_to: 1.day.from_now.to_date) }

          it 'banana' do
            subject
          end

          subject { response }
          it { should have_http_status(:ok) }
          it { expect(parsed_response_body[:items].count).to eq 1 }
          it { expect(parsed_response_body[:items].map { |item| item[:datetime].to_date }).to all(eq(1.day.from_now.to_date.to_date)) }
        end

        # SHOULD ACTUALLY IGNORE TIME WHEN PROVIDING 'date_from'
        context 'when filtering by {date_from: 1.day.from_now.end_of_day.to_datetime.to_s, date_to: 1.day.from_now.to_date}' do
          before { req(date_from: 1.day.from_now.end_of_day.to_datetime.to_s, date_to: 1.day.from_now.to_date) }

          subject { response }
          it { should have_http_status(:ok) }
          it { expect(parsed_response_body[:items].count).to eq 1 }
          it { expect(parsed_response_body[:items].map { |item| item[:datetime].to_date }).to all(eq(1.day.from_now.to_date.to_date)) }
        end

        # SHOULD NOT IGNORE TIME WHEN PARAM IS CALLED 'datetime_from'
        context 'when filtering by {datetime_from: 1.day.from_now.end_of_day.to_datetime.to_s, datetime_to: 1.day.from_now.to_date}' do
          before { req(datetime_from: 1.day.from_now.end_of_day.to_datetime.to_s, datetime_to: 1.day.from_now.to_date) }

          subject { response }
          it { should have_http_status(:ok) }
          it { expect(parsed_response_body[:items].count).to eq 0 }
        end
      end
    end
  end

  context '#show' do
    it { expect(instance).to respond_to(:show) }
    it { expect(described_class).to route(:get, '/v1/admin/reservations/2').to(action: :show, format: :json, id: 2) }

    let(:reservation) { create(:reservation) }

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
        before { req(reservation.id) }
        subject { response }
        it { should have_http_status(:ok) }

        context 'response' do
          subject { parsed_response_body[:item].transform_keys(&:to_sym) }
          it { should be_a(Hash) }
          it { should include(:id, :updated_at) }

          it_behaves_like RESERVATION_TEST_STRUCTURE
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
    it { expect(described_class).to route(:post, '/v1/admin/reservations').to(action: :create, format: :json) }

    let(:params) { { reservation: attributes_for(:reservation) } }

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
    it { expect(described_class).to route(:patch, '/v1/admin/reservations/2').to(action: :update, id: "2", format: :json) }

    let(:reservation) { create(:reservation, starts_at: '10:00', ends_at: '13:00') }

    let(:params) { {} }

    def req(id = reservation.id, data = params)
      patch :update, params: data.merge(id:)
    end

    context 'when user is not authenticated' do
      before { req }
      it_behaves_like UNAUTHORIZED
    end

    context '(authenticated)' do
      before { authenticate_request }

      it do
        reservation
        expect { req(reservation.id, starts_at: "10:00") }.not_to change(ReservationTurn, :count)
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
    it { expect(described_class).to route(:delete, '/v1/admin/reservations/2').to(action: :destroy, id: "2", format: :json) }

    let(:reservation) { create(:reservation) }

    def req(id = reservation.id)
      delete :destroy, params: { id: id }
    end

    context 'when user is not authenticated' do
      before { req }
      it_behaves_like UNAUTHORIZED
    end

    context '(authenticated)' do
      before { authenticate_request }

      it do
        reservation
        expect { req(reservation.id) }.to change(ReservationTurn, :count).by(-1)
      end

      context 'when trying to delete a non-existing reservation turn' do
        before { req(999_999) }
        subject { response }
        it_behaves_like NOT_FOUND
      end
    end
  end
end
