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

    let(:params) { attributes_for(:reservation) }

    def req(data = params)
      post :create, params: data
    end

    context 'when user is not authenticated' do
      before { req }
      it_behaves_like UNAUTHORIZED
    end

    context '(authenticated)' do
      before { authenticate_request }

      context 'basic' do
        it { expect { req }.to change(Reservation, :count).by(1) }
        it 'should return reservation info' do
          req
          expect(parsed_response_body).to include(item: Hash)

          expect(parsed_response_body[:item]).to include(
                                                   fullname: String,
                                                   datetime: String,
                                                   status: String,
                                                   secret: String,
                                                   people: Integer,
                                                   table: String,
                                                   notes: String,
                                                   email: String,
                                                   phone: String,
                                                   other: Hash,
                                                   created_at: String,
                                                   updated_at: String,
                                                   id: Integer
                                                 )
          expect(response).to have_http_status(:ok)
        end
      end

      # MINIMUM REQUIRED INFO: fullname, datetime, people.
      ['Anne Marie', 'Luigi'].each do |fullname|
        ['2024-10-12 19:00', '2024-12-25 21:00'].each do |datetime|
          [1, 2, 3].each do |people|
            context "when providing {fullname: #{fullname.inspect}, datetime: #{datetime.inspect}, people: #{people}}" do
              let(:params) { { fullname:, datetime:, people: } }

              it { expect { req }.to change(Reservation, :count).by(1) }
              it 'should return provided info' do
                req
                expect(parsed_response_body).to include(item: Hash)
                expect(parsed_response_body[:item]).to include(fullname: fullname, people: people)
                expect(parsed_response_body.dig(:item, :datetime)).to include(datetime.split(' ').first)
                expect(parsed_response_body.dig(:item, :datetime)).to include(datetime.split(' ').last)
                expect(response).to have_http_status(:ok)
              end
            end

            [201, '204 fuori'].each do |table|
              ['bambini', 'bella vita'].each do |notes|
                ['sa@ba', 'gi@gi'].each do |email|
                  ['123 333 333', '456 666 666'].each do |phone|
                    context "when providing {fullname: #{fullname.inspect}, datetime: #{datetime.inspect}, people: #{people}, table: #{table.inspect}, notes: #{notes.inspect}, email: #{email.inspect}, phone: #{phone.inspect}}" do
                      let(:params) { { fullname:, datetime:, people:, table:, notes:, email:, phone: } }

                      it 'should return provided info' do
                        expect { req }.to change(Reservation, :count).by(1)
                        expect(parsed_response_body).to include(item: Hash)
                        expect(parsed_response_body[:item]).to include(fullname:, people:, email:, table: table.to_s, notes:)
                        expect(parsed_response_body.dig(:item, :datetime)).to include(datetime.split(' ').first)
                        expect(parsed_response_body.dig(:item, :datetime)).to include(datetime.split(' ').last)
                        expect(response).to have_http_status(:ok)
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end

  context '#update' do
    it { expect(instance).to respond_to(:update) }
    it { expect(described_class).to route(:patch, '/v1/admin/reservations/2').to(action: :update, id: "2", format: :json) }

    let(:reservation) { create(:reservation) }

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
        expect { req(reservation.id) }.not_to change(Reservation, :count)
      end

      context 'when trying to update a non-existing reservation' do
        before { req(999_999) }
        subject { response }
        it_behaves_like NOT_FOUND
      end

      context 'when updating people' do
        let(:params) { { people: 10 } }

        it do
          expect { req }.to change { reservation.reload.people }.from(reservation.people).to(10)
        end
      end

      context 'when updating fullname' do
        let(:fullname) { 'Anne Marie' + SecureRandom.hex }
        let(:params) { { fullname: } }

        it do
          expect { req }.to change { reservation.reload.fullname }.from(reservation.fullname).to(fullname)
        end
      end

      context 'when updating datetime' do
        let(:datetime) { reservation.datetime + 1.day }
        let(:params) { { datetime: } }

        it do
          expect { req }.to change { reservation.reload.datetime }.from(reservation.datetime).to(datetime)
        end
      end

      context 'when updating table' do
        let(:table) { '204' }
        let(:params) { { table: } }

        it do
          expect { req }.to change { reservation.reload.table }.from(reservation.table).to(table)
        end
      end

      context 'when updating notes' do
        let(:notes) { 'Please be kind' + SecureRandom.hex }
        let(:params) { { notes: } }

        it do
          expect { req }.to change { reservation.reload.notes }.from(reservation.notes).to(notes)
        end
      end

      context 'when updating email' do
        let(:email) { 'giuly@presley' + SecureRandom.hex }
        let(:params) { { email: } }

        it do
          expect { req }.to change { reservation.reload.email }.from(reservation.email).to(email)
        end
      end

      context 'when updating phone' do
        let(:phone) { '123 333 333' }
        let(:params) { { phone: } }

        it do
          expect { req }.to change { reservation.reload.phone }.from(reservation.phone).to(phone)
        end
      end

      context 'when updating status: does nothing' do
        let(:params) { { status: :cancelled } }

        it do
          reservation.active!

          expect { req }.not_to change { reservation.reload.status }.from(reservation.status)
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
        expect { req(reservation.id) }.not_to change(Reservation, :count)
      end

      it do
        reservation
        expect { req(reservation.id) }.to change { Reservation.visible.count }.by(-1)
      end

      it do
        expect { req(reservation.id) }.to change { reservation.reload.status }.from(reservation.status).to('deleted')
      end

      context 'when trying to delete a non-existing reservation' do
        before { req(999_999) }
        subject { response }
        it_behaves_like NOT_FOUND
      end
    end
  end

  context '#update_status' do
    it { expect(instance).to respond_to(:update) }
    it { expect(described_class).to route(:patch, '/v1/admin/reservations/2/status/arrived').to(status: 'arrived', action: :update_status, id: "2", format: :json) }

    let(:reservation) { create(:reservation) }

    let(:status) { 'arrived' }

    def req(id = reservation.id, status2set = status)
      patch :update_status, params: { id:, status: status2set }
    end

    context 'when user is not authenticated' do
      before { req }
      it_behaves_like UNAUTHORIZED
    end

    context 'when user is authenticated' do
      before { authenticate_request }

      context 'when trying to update a non-existing reservation' do
        before { req(999_999) }
        subject { response }
        it_behaves_like NOT_FOUND
      end

      context 'when updating status to arrived' do
        let(:status) { 'arrived' }

        it do
          expect { req }.to change { reservation.reload.status }.from(reservation.status).to(status)
          expect(parsed_response_body).to include(item: Hash)
          expect(parsed_response_body[:item]).to include(id: Integer, status:, created_at: String)
          expect(response).to have_http_status(:ok)
        end
      end

      context 'when updating status to noshow' do
        let(:status) { 'noshow' }

        it do
          expect { req }.to change { reservation.reload.status }.from(reservation.status).to(status)
          expect(parsed_response_body).to include(item: Hash)
          expect(parsed_response_body[:item]).to include(id: Integer, status:, created_at: String)
          expect(response).to have_http_status(:ok)
        end
      end

      context 'when updating status to cancelled' do
        let(:status) { 'cancelled' }

        it do
          expect { req }.not_to change { reservation.reload.status }
          expect(parsed_response_body).to include(message: String, details: Hash)
          expect(response).to have_http_status(:bad_request)
          expect(parsed_response_body[:message].to_s.downcase).to include('status')
        end
      end

      context 'when updating status to deleted' do
        let(:status) { 'deleted' }

        it do
          expect { req }.not_to change { reservation.reload.status }
          expect(parsed_response_body).to include(message: String, details: Hash)
          expect(response).to have_http_status(:bad_request)
          expect(parsed_response_body[:message].to_s.downcase).to include('status')
        end
      end
    end
  end

  context 'POST #add_tag' do
    it { expect(described_class).to route(:post, '/v1/admin/reservations/2/add_tag/3').to(tag_id: '3', action: :add_tag, id: "2", format: :json) }
    it { expect(instance).to respond_to(:add_tag) }

    let(:reservation) { create(:reservation) }
    let(:tag) { create(:reservation_tag) }

    def req(reservation_id = reservation.id, tag_id = tag.id)
      post :add_tag, params: { id: reservation_id, tag_id: }
    end

    context 'when user is not authenticated' do
      before { req }
      it_behaves_like UNAUTHORIZED
    end

    context 'when user is authenticated' do
      before { authenticate_request }

      context 'when trying to update a non-existing reservation' do
        before { req(999_999, tag.id) }
        subject { response }
        it_behaves_like NOT_FOUND
      end

      context 'when trying to add a non-existing tag' do
        before { req(reservation.id, 999_999_99) }
        subject { response }
        it_behaves_like NOT_FOUND
      end

      context 'when reservation and tag are valid' do
        before do
          reservation
          tag
        end

        it { expect { req }.to change { TagInReservation.count }.by(1) }
        it { expect { req }.not_to change { Reservation.count } }
        it { expect { req }.not_to change { ReservationTag.count } }
        it { expect { req }.to change { reservation.reload.tags.count }.from(0).to(1) }
        it { expect { req }.not_to change { tag.reload.as_json } }

        it 'should be successful' do
          req
          expect(parsed_response_body).to include(item: Hash)
          expect(response).to have_http_status(:ok)
          expect(parsed_response_body[:item]).to include(id: Integer, created_at: String)
          expect(parsed_response_body[:item]).to include(tags: Array)
          expect(parsed_response_body.dig(:item, :tags).count).to eq 1
        end

        it 'can try to add twice the tag, will be added just once.' do
          expect { req }.to change { TagInReservation.count }.by(1)
          expect(response).to have_http_status(:ok)
          expect { req }.not_to change { TagInReservation.count }
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end

      context 'when cannot add tag for some reason' do
        let(:error_msg) { 'OOps some invalid value here' }

        before do
          reservation
          tag
          allow_any_instance_of(TagInReservation).to receive(:valid?).and_return(false)
          errors = ActiveModel::Errors.new(TagInReservation.new)
          errors.add(:base, error_msg)
          allow_any_instance_of(TagInReservation).to receive(:errors).and_return(errors)
        end

        it { expect { req }.not_to change { TagInReservation.count } }
        it 'should return 422 with message' do
          req
          expect(parsed_response_body).to include(message: String)
          expect(response).to have_http_status(:unprocessable_entity)
          expect(parsed_response_body[:message]).to include(error_msg)
        end
      end
    end
  end

  context 'DELETE #remove_tag' do
    it { expect(described_class).to route(:delete, '/v1/admin/reservations/2/remove_tag/3').to(tag_id: '3', action: :remove_tag, id: "2", format: :json) }
    it { expect(instance).to respond_to(:remove_tag) }

    let(:reservation) { create(:reservation) }
    let(:tag) { create(:reservation_tag) }

    def req(reservation_id = reservation.id, tag_id = tag.id)
      delete :remove_tag, params: { id: reservation_id, tag_id: }
    end

    context 'when user is not authenticated' do
      before { req }
      it_behaves_like UNAUTHORIZED
    end

    context 'when user is authenticated' do
      before { authenticate_request }

      context 'when trying to update a non-existing reservation' do
        before { req(999_999, tag.id) }
        subject { response }
        it_behaves_like NOT_FOUND
      end

      context 'when trying to add a non-existing tag' do
        before { req(reservation.id, 999_999_99) }
        subject { response }
        it_behaves_like NOT_FOUND
      end

      context 'when reservation and tag are valid' do
        before do
          reservation.tags = [tag]
        end

        it { expect { req }.to change { TagInReservation.count }.by(-1) }
        it { expect { req }.not_to change { Reservation.count } }
        it { expect { req }.not_to change { ReservationTag.count } }
        it { expect { req }.to change { reservation.reload.tags.count }.from(1).to(0) }
        it { expect { req }.not_to change { tag.reload.as_json } }
        it { expect { req }.not_to change { reservation.reload.as_json } }

        it 'should be successful' do
          req
          expect(parsed_response_body).to include(item: Hash)
          expect(response).to have_http_status(:ok)
          expect(parsed_response_body[:item]).to include(id: Integer, created_at: String)
          expect(parsed_response_body[:item]).to include(tags: Array)
          expect(parsed_response_body.dig(:item, :tags).count).to eq 0
        end

        it 'when removing same tag twice, should be fine.' do
          expect { req }.to change { reservation.reload.tags.count }.from(1).to(0)
          expect(response).to have_http_status(:ok)
          expect { req }.not_to change { reservation.reload.tags.count }
          expect(response).to have_http_status(:ok)
        end
      end

      context 'when reservation has 3 tags' do
        let(:tags) { create_list(:reservation_tag, 3) }
        let(:tag) { tags.sample }

        before do
          reservation.tags = tags
        end

        it { expect { req }.to change { TagInReservation.count }.by(-1) }
        it { expect { req }.not_to change { Reservation.count } }
        it { expect { req }.not_to change { ReservationTag.count } }
        it { expect { req }.to change { reservation.reload.tags.count }.from(3).to(2) }
        it { expect { req }.not_to change { tag.reload.as_json } }
        it { expect { req }.not_to change { reservation.reload.as_json } }

        it 'should be successful' do
          req
          expect(parsed_response_body).to include(item: Hash)
          expect(response).to have_http_status(:ok)
          expect(parsed_response_body[:item]).to include(id: Integer, created_at: String)
          expect(parsed_response_body[:item]).to include(tags: Array)
          expect(parsed_response_body.dig(:item, :tags).count).to eq 2
        end

        it 'when removing same tag twice, should be fine.' do
          expect { req }.to change { reservation.reload.tags.count }.from(3).to(2)
          expect(response).to have_http_status(:ok)
          expect { req }.not_to change { reservation.reload.tags.count }
          expect(response).to have_http_status(:ok)
        end
      end
    end
  end

  context 'POST #deliver_confirmation_email' do
    it { expect(described_class).to route(:post, '/v1/admin/reservations/2/deliver_confirmation_email').to(action: :deliver_confirmation_email, id: "2", format: :json) }
    it { expect(described_class).to route(:post, '/v1/admin/reservations/55/deliver_confirmation_email').to(action: :deliver_confirmation_email, id: "55", format: :json) }
    it { expect(instance).to respond_to(:deliver_confirmation_email) }

    let(:reservation) { create(:reservation) }
    let(:params) { { id: reservation.id } }

    def req(_params = params)
      post :deliver_confirmation_email, params: _params
    end

    context 'when user is not authenticated' do
      before { req }
      it_behaves_like UNAUTHORIZED
    end

    context 'when user is authenticated' do
      before { authenticate_request }

      context 'when trying to deliver a non-existing reservation' do
        before { req(id: 999_999) }
        subject { response }
        it_behaves_like NOT_FOUND
      end

      context 'when reservation is valid' do
        before { allow_any_instance_of(Hash).to receive(:dig!).and_return('something') }

        it { expect { req }.to change { ActionMailer::Base.deliveries.count }.by(1) }
        it 'should be successful' do
          req
          expect(parsed_response_body).not_to include(message: String)
          expect(response).to have_http_status(:ok)
        end
      end
    end
  end
end
