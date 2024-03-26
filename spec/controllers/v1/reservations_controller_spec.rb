# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V1::ReservationsController, type: :controller do
  let(:instance) { described_class.new }
  include_context CONTROLLER_UTILS_CONTEXT
  include_context TESTS_OPTIMIZATIONS_CONTEXT

  context 'POST #create' do
    it { expect(instance).to respond_to(:create) }
    it { should route(:post, '/v1/reservations').to(format: :json, action: :create, controller: 'v1/reservations') }

    let!(:turn) do
      create(:reservation_turn, starts_at: DateTime.parse('00:01'), ends_at: DateTime.parse('23:59'), weekday: 0)
    end

    let(:first_name) { Faker::Name.first_name }
    let(:last_name) { Faker::Name.last_name }
    let(:date) { Time.now.beginning_of_week + 7.days }
    let(:datetime) { "#{date.to_date} 19:00" }
    let(:people) { 2 }
    let(:email) { Faker::Internet.email }
    let(:phone) do
      [Faker::PhoneNumber.cell_phone, Faker::PhoneNumber.cell_phone_in_e164,
       Faker::PhoneNumber.cell_phone_with_country_code].sample
    end
    let(:notes) { Faker::Lorem.sentence }

    let(:params) do
      {
        first_name:,
        last_name:,
        datetime:,
        people:,
        email:,
        phone:,
        notes:
      }
    end

    def req(data = params)
      post :create, params: data
    end

    context 'basic' do
      it 'should create a reservation' do
        req
        expect(parsed_response_body).to include(item: Hash)
        expect(response).to have_http_status(:ok)
      end

      context 'when turn is not in that weekday' do
        let!(:turn) do
          create(:reservation_turn, starts_at: DateTime.parse('00:01'), ends_at: DateTime.parse('23:59'), weekday: 1)
        end

        it 'should return 422' do
          req
          expect(parsed_response_body).to include(message: String, details: Hash)
          expect(response).to have_http_status(422)
          expect(parsed_response_body[:details][:datetime]).to be_present
        end
      end

      context 'when datetime is null' do
        let(:datetime) { nil }

        it 'should return 422' do
          req
          expect(parsed_response_body).to include(message: String, details: Hash)
          expect(response).to have_http_status(422)
          expect(parsed_response_body[:details][:datetime]).to be_present
        end
      end

      context 'when datetime is not a valid datetime' do
        [
          'banana',
          'some string',
          '2020-01-01 25:00',
          '2020-01-01 00:60',
          '2020-01- 00:10',
          '2020-15-19 20:00',
          '2020-15-8 20:00'
        ].each do |invalid_datetime|
          context "if datetime is '#{invalid_datetime}'" do
            let(:datetime) { invalid_datetime }

            it 'should return 422' do
              req
              expect(parsed_response_body).to include(message: String, details: Hash)
              expect(response).to have_http_status(422)
              expect(parsed_response_body[:details][:datetime]).to be_present
              expect(parsed_response_body[:message].to_s.downcase).to include('datetime is not a valid datetime')
            end
          end
        end
      end

      context 'when datetime is not in the expected format' do
        [
          '2020-01-01 00:00:60',
          '2020-01-01 00:10:50.000',
          '2020-01-01 00:10:50',
          '12:00 2020-01-01',
          '12:00 2020-01-01',
          '2020-12-12',
          '20:00'
        ].each do |invalid_datetime|
          context "if datetime is '#{invalid_datetime}'" do
            let(:datetime) { invalid_datetime }

            it 'should return 422' do
              req
              expect(parsed_response_body).to include(message: String, details: Hash)
              expect(response).to have_http_status(422)
              expect(parsed_response_body[:details][:datetime]).to be_present
              expect(parsed_response_body[:message].to_s.downcase).to include('datetime has invalid format')
            end
          end
        end
      end

      context 'when people is null' do
        let(:people) { nil }

        it 'should return 422' do
          req
          expect(parsed_response_body).to include(message: String, details: Hash)
          expect(response).to have_http_status(422)
          expect(parsed_response_body[:details][:people]).to be_present
        end
      end

      context 'when people is 0' do
        let(:people) { 0 }

        it 'should return 422' do
          req
          expect(parsed_response_body).to include(message: String, details: Hash)
          expect(response).to have_http_status(422)
          expect(parsed_response_body[:details][:people]).to be_present
        end
      end

      context 'when people is greater than max_people_per_reservation' do
        let(:people) { Setting[:max_people_per_reservation].to_i + 1 }

        it 'should return 422' do
          req
          expect(parsed_response_body).to include(message: String, details: Hash)
          expect(response).to have_http_status(422)
          expect(parsed_response_body[:details][:people]).to be_present
        end
      end

      context 'when first_name is missing' do
        let(:first_name) { nil }

        it 'should return 422' do
          req
          expect(parsed_response_body).to include(message: String, details: Hash)
          expect(response).to have_http_status(422)
          expect(parsed_response_body[:details][:first_name]).to be_present
        end
      end

      context 'when first_name is empty' do
        let(:first_name) { ' ' }

        it 'should return 422' do
          req
          expect(parsed_response_body).to include(message: String, details: Hash)
          expect(response).to have_http_status(422)
          expect(parsed_response_body[:details][:first_name]).to be_present
        end
      end

      context 'when first_name is too short' do
        let(:first_name) { ' a ' }

        it 'should return 422' do
          req
          expect(parsed_response_body).to include(message: String, details: Hash)
          expect(response).to have_http_status(422)
          expect(parsed_response_body[:details][:first_name]).to be_present
        end
      end

      context 'when last_name is missing' do
        let(:last_name) { nil }

        it 'should return 422' do
          req
          expect(parsed_response_body).to include(message: String, details: Hash)
          expect(response).to have_http_status(422)
          expect(parsed_response_body[:details][:last_name]).to be_present
        end
      end

      context 'when last_name is empty' do
        let(:last_name) { ' ' }

        it 'should return 422' do
          req
          expect(parsed_response_body).to include(message: String, details: Hash)
          expect(response).to have_http_status(422)
          expect(parsed_response_body[:details][:last_name]).to be_present
        end
      end

      context 'when last_name is too short' do
        let(:last_name) { ' a ' }

        it 'should return 422' do
          req
          expect(parsed_response_body).to include(message: String, details: Hash)
          expect(response).to have_http_status(422)
          expect(parsed_response_body[:details][:last_name]).to be_present
        end
      end

      context 'when last_name has two letters' do
        let(:last_name) { ' ab ' }

        it { expect { req }.to change { Reservation.count }.by(1) }

        it 'should return 200 and create record' do
          req
          expect(parsed_response_body).to include(item: Hash)
          expect(response).to have_http_status(200)
        end
      end

      context 'when last_name is "O\'reilly"' do
        let(:last_name) { "O'reilly" }

        it { expect { req }.to change { Reservation.count }.by(1) }

        it 'should return 200 and create record' do
          req
          expect(parsed_response_body).to include(item: Hash)
          expect(response).to have_http_status(200)
        end
      end

      context 'when last_name is "Mc Donalds"' do
        let(:last_name) { 'Mc Donalds' }

        it { expect { req }.to change { Reservation.count }.by(1) }

        it 'should return 200 and create record' do
          req
          expect(parsed_response_body).to include(item: Hash)
          expect(response).to have_http_status(200)
        end
      end

      context 'should create a reservation with "<firstname> <lastname>" as fullname and save the detail in the "other" field' do
        let(:first_name) { 'Gigi' }
        let(:last_name) { 'Bagigi' }

        it 'should create a reservation' do
          req
          expect(parsed_response_body).to include(item: Hash)
          expect(response).to have_http_status(:ok)
          expect(Reservation.last.fullname).to eq("#{first_name} #{last_name}")
          expect(Reservation.last.other).to include('first_name' => first_name, 'last_name' => last_name)
        end
      end

      context 'should upcase first letter or first name and last name' do
        let(:first_name) { 'gigi' }
        let(:last_name) { 'bagigi wassa' }

        it 'should create a reservation' do
          req
          expect(parsed_response_body).to include(item: Hash)
          expect(response).to have_http_status(:ok)
          expect(Reservation.last.fullname).to eq('Gigi Bagigi Wassa')
          expect(Reservation.last.other).to include('first_name' => 'Gigi', 'last_name' => 'Bagigi Wassa')
        end
      end

      context 'should be able to provide multiple first name(s) and last name(s)' do
        let(:first_name) { 'gigi pippo' }
        let(:last_name) { 'bagigi wassa pluto' }

        it 'should create a reservation' do
          req
          expect(parsed_response_body).to include(item: Hash)
          expect(response).to have_http_status(:ok)
          expect(Reservation.last.fullname).to eq('Gigi Pippo Bagigi Wassa Pluto')
          expect(Reservation.last.other).to include('first_name' => 'Gigi Pippo', 'last_name' => 'Bagigi Wassa Pluto')
        end
      end

      context 'when email is empty' do
        let(:email) { '' }

        it { expect { req }.not_to(change { Reservation.count }) }

        it 'should return 422' do
          req
          expect(parsed_response_body).to include(message: String, details: Hash)
          expect(response).to have_http_status(422)
          expect(parsed_response_body[:details][:email]).to be_present
        end
      end

      context 'when email is nil' do
        let(:email) { nil }

        it { expect { req }.not_to(change { Reservation.count }) }

        it 'should return 422' do
          req
          expect(parsed_response_body).to include(message: String, details: Hash)
          expect(response).to have_http_status(422)
          expect(parsed_response_body[:details][:email]).to be_present
        end
      end

      context 'when email is invalid' do
        [
          'plainaddress',
          '@example.com',
          'Joe Smith <',
          'email.example.com'
        ].each do |invalid_email|
          context "if email is '#{invalid_email}'" do
            let(:email) { invalid_email }

            it { expect { req }.not_to(change { Reservation.count }) }

            it 'should return 422' do
              req
              expect(parsed_response_body).to include(message: String, details: Hash)
              expect(response).to have_http_status(422)
              expect(parsed_response_body[:details][:email]).to be_present
            end
          end
        end
      end

      context 'when already exists a reservation for same datetime and email' do
        let!(:reservation) { create(:reservation, datetime:, email:) }

        it { expect { req }.not_to(change { Reservation.count }) }

        it 'should return 422' do
          req
          expect(parsed_response_body).to include(message: String, details: Hash)
          expect(response).to have_http_status(422)
          expect(parsed_response_body[:message].to_s.downcase).to include('another reservation for this datetime')
          expect(parsed_response_body[:details][:email]).not_to be_empty
        end
      end

      context 'when email is empty' do
        let(:email) { '' }

        it { expect { req }.not_to(change { Reservation.count }) }

        it 'should return 422' do
          req
          expect(parsed_response_body).to include(message: String, details: Hash)
          expect(response).to have_http_status(422)
          expect(parsed_response_body[:details][:email]).to be_present
        end
      end

      context 'when email is nil' do
        let(:email) { nil }

        it { expect { req }.not_to(change { Reservation.count }) }

        it 'should return 422' do
          req
          expect(parsed_response_body).to include(message: String, details: Hash)
          expect(response).to have_http_status(422)
          expect(parsed_response_body[:details][:email]).to be_present
        end
      end

      context 'when email is invalid' do
        [
          'plainaddress',
          '@example.com',
          'Joe Smith <',
          'email.example.com'
        ].each do |invalid_email|
          context "if email is '#{invalid_email}'" do
            let(:email) { invalid_email }

            it { expect { req }.not_to(change { Reservation.count }) }

            it 'should return 422' do
              req
              expect(parsed_response_body).to include(message: String, details: Hash)
              expect(response).to have_http_status(422)
              expect(parsed_response_body[:details][:email]).to be_present
            end
          end
        end
      end

      context 'when phone is empty' do
        let(:phone) { '' }

        it { expect { req }.not_to(change { Reservation.count }) }

        it 'should return 422' do
          req
          expect(parsed_response_body).to include(message: String, details: Hash)
          expect(response).to have_http_status(422)
          expect(parsed_response_body[:details][:phone]).to be_present
        end
      end

      context 'when phone is nil' do
        let(:phone) { nil }

        it { expect { req }.not_to(change { Reservation.count }) }

        it 'should return 422' do
          req
          expect(parsed_response_body).to include(message: String, details: Hash)
          expect(response).to have_http_status(422)
          expect(parsed_response_body[:details][:phone]).to be_present
        end
      end

      context 'when phone is invalid' do
        [
          'plainaddress',
          '@example.com',
          'Joe Smith <',
          'phone.example.com',
          '123',
          '3566'
        ].each do |invalid_phone|
          context "if phone is '#{invalid_phone}'" do
            let(:phone) { invalid_phone }

            it { expect { req }.not_to(change { Reservation.count }) }

            it 'should return 422' do
              req
              expect(parsed_response_body).to include(message: String, details: Hash)
              expect(response).to have_http_status(422)
              expect(parsed_response_body[:details][:phone]).to be_present
            end
          end
        end
      end

      context 'when phone is valid' do
        [
          '3515590063',
          '351 559 0063',
          '+39 351 559 0063',
          '+39 351-559 0063',
          '+39 (351)-559 0063',
          '+39 (351) 559 0063',
          '(351) 559 0063',
          '(351)-559-0063',
          '351-559-0063',
          '351.559.0063',
          '+39 351.559.0063',
          '+39.351.559.0063',
          '491.332.7060',
          '+393358063066',
          ' +393358063066',
          ' +393358063066 ',
          '+393358063066 '
        ].each do |valid_phone|
          context "if phone is '#{valid_phone}'" do
            let(:phone) { valid_phone }

            it { expect { req }.to change { Reservation.count }.by(1) }

            it 'should clean the phone number before saving' do
              req
              vp = valid_phone.gsub('.', '').gsub(/\s+/, '').gsub(/\(/, '').gsub(/\)/, '').gsub(/-/, '')
              expect(Reservation.last.phone).to eq(vp)
            end

            it 'should return 200' do
              req
              expect(parsed_response_body).to include(item: Hash)
              expect(response).to have_http_status(200)
            end
          end
        end
      end
    end
  end

  context 'PATCH #cancel' do
    it { expect(instance).to respond_to(:cancel) }
    it {
      should route(:patch, '/v1/reservations/cancel').to(format: :json, action: :cancel, controller: 'v1/reservations')
    }

    let!(:reservation) { create(:reservation) }
    let(:params) { { secret: reservation.secret } }

    def req(data = params)
      patch :cancel, params: data
    end

    context 'basic' do
      context 'should cancel a reservation' do
        it do
          req
          expect(parsed_response_body).to include(item: Hash)
          expect(response).to have_http_status(:ok)
        end

        it { expect { req }.to change { reservation.reload.status }.to('cancelled') }
      end

      context 'if secret is not provided' do
        let(:params) { {} }
        before { req }
        subject { response }
        it_behaves_like NOT_FOUND
      end

      context 'if secret is invalid' do
        let(:params) { { secret: 'some-invalid-secret' } }
        before { req }
        subject { response }
        it_behaves_like NOT_FOUND
      end

      context 'when record is invalid' do
        before do
          reservation
          allow_any_instance_of(Reservation).to receive(:cancelled!).and_return(false)
          errors = ActiveModel::Errors.new(Reservation.new)
          errors.add(:base, 'some error')
          allow_any_instance_of(Reservation).to receive(:errors).and_return(errors)
        end

        it { expect { req }.not_to(change { Reservation.cancelled.count }) }
        it { expect { req }.not_to(change { reservation.reload.status }) }
        it 'should render errors' do
          req
          expect(parsed_response_body).to include(message: String, details: Hash)
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end
  end

  context 'GET #show' do
    it { expect(instance).to respond_to(:show) }
    it {
      should route(:get, '/v1/reservations/supersecret').to(format: :json, action: :show, controller: 'v1/reservations',
                                                            secret: 'supersecret')
    }

    let!(:reservation) { create(:reservation) }
    let(:params) { { secret: reservation.secret } }

    def req(data = params)
      get :show, params: data
    end

    context 'basic' do
      context 'should return a reservation' do
        it do
          req
          expect(parsed_response_body).to include(item: Hash)
          expect(response).to have_http_status(:ok)
        end

        it { expect { req }.not_to(change { reservation.reload.as_json }) }

        context 'checking data structure' do
          before { req }
          subject { parsed_response_body[:item] }

          it {
            is_expected.to include(
              'id' => reservation.id,
              'fullname' => reservation.fullname,
              'datetime' => reservation.datetime,
              'people' => reservation.people,
              'email' => reservation.email,
              'phone' => reservation.phone,
              'notes' => reservation.notes
            )
          }

          it { expect(subject.keys.map(&:to_s)).not_to include('secret') }
        end
      end

      context 'when secret is invalid' do
        let(:params) { { secret: 'some-invalid-secret' } }
        before { req }
        subject { response }
        it_behaves_like NOT_FOUND
      end

      context 'when reservation is deleted' do
        before do
          reservation.deleted!
          req
        end

        subject { response }
        it_behaves_like NOT_FOUND
      end
    end
  end
end
