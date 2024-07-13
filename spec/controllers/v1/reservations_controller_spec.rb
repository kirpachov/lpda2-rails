# frozen_string_literal: true

require "rails_helper"

RSpec.describe V1::ReservationsController, type: :controller do
  let(:instance) { described_class.new }

  include_context CONTROLLER_UTILS_CONTEXT
  include_context TESTS_OPTIMIZATIONS_CONTEXT

  context "POST #create" do
    let(:params) do
      {
        first_name:,
        last_name:,
        datetime:,
        adults:,
        children:,
        email:,
        phone:,
        notes:
      }
    end
    let(:notes) { Faker::Lorem.sentence }
    let(:phone) do
      [Faker::PhoneNumber.cell_phone, Faker::PhoneNumber.cell_phone_in_e164,
       Faker::PhoneNumber.cell_phone_with_country_code].sample
    end
    let(:email) { Faker::Internet.email }
    let(:adults) { 2 }
    let(:children) { 0 }
    let(:datetime) { "#{date.to_date} 19:00" }
    let(:date) { Time.now.beginning_of_week + 7.days }
    let(:last_name) { Faker::Name.last_name }
    let(:first_name) { Faker::Name.first_name }
    let!(:turn) do
      create(:reservation_turn, starts_at: DateTime.parse("00:01"), ends_at: DateTime.parse("23:59"), weekday: 0)
    end

    it { expect(instance).to respond_to(:create) }

    it {
      expect(subject).to route(:post, "/v1/reservations").to(format: :json, action: :create,
                                                             controller: "v1/reservations")
    }

    def req(data = params)
      post :create, params: data
    end

    context "basic" do
      it "creates a reservation" do
        req
        expect(parsed_response_body).to include(item: Hash)
        expect(response).to have_http_status(:ok)
      end

      context "when turn is not in that weekday" do
        let!(:turn) do
          create(:reservation_turn, starts_at: DateTime.parse("00:01"), ends_at: DateTime.parse("23:59"), weekday: 1)
        end

        it "returns 422" do
          req
          expect(parsed_response_body).to include(message: String, details: Hash)
          expect(response).to have_http_status(:unprocessable_entity)
          expect(parsed_response_body[:details][:datetime]).to be_present
        end
      end

      context "when datetime is null" do
        let(:datetime) { nil }

        it "returns 422" do
          req
          expect(parsed_response_body).to include(message: String, details: Hash)
          expect(response).to have_http_status(:unprocessable_entity)
          expect(parsed_response_body[:details][:datetime]).to be_present
        end
      end

      context "when datetime is not a valid datetime" do
        [
          "banana",
          "some string",
          "2020-01-01 25:00",
          "2020-01-01 00:60",
          "2020-01- 00:10",
          "2020-15-19 20:00",
          "2020-15-8 20:00"
        ].each do |invalid_datetime|
          context "if datetime is '#{invalid_datetime}'" do
            let(:datetime) { invalid_datetime }

            it "returns 422" do
              req
              expect(parsed_response_body).to include(message: String, details: Hash)
              expect(response).to have_http_status(:unprocessable_entity)
              expect(parsed_response_body[:details][:datetime]).to be_present
              expect(parsed_response_body[:message].to_s.downcase).to include("datetime is not a valid datetime")
            end
          end
        end
      end

      context "when datetime is not in the expected format" do
        [
          "2020-01-01 00:00:60",
          "2020-01-01 00:10:50.000",
          "2020-01-01 00:10:50",
          "12:00 2020-01-01",
          "12:00 2020-01-01",
          "2020-12-12",
          "20:00"
        ].each do |invalid_datetime|
          context "if datetime is '#{invalid_datetime}'" do
            let(:datetime) { invalid_datetime }

            it "returns 422" do
              req
              expect(parsed_response_body).to include(message: String, details: Hash)
              expect(response).to have_http_status(:unprocessable_entity)
              expect(parsed_response_body[:details][:datetime]).to be_present
              expect(parsed_response_body[:message].to_s.downcase).to include("datetime has invalid format")
            end
          end
        end
      end

      context "when people is null (both adults and children)" do
        let(:adults) { nil }
        let(:children) { nil }

        it "returns 422" do
          req
          expect(parsed_response_body).to include(message: String, details: Hash)
          expect(response).to have_http_status(:unprocessable_entity)
          expect(parsed_response_body[:details][:adults]).to be_present
          expect(parsed_response_body[:details][:children]).to be_present
        end
      end

      context "when people is 0 (both adults and children)" do
        let(:adults) { 0 }
        let(:children) { 0 }

        it "returns 422" do
          req
          expect(parsed_response_body).to include(message: String, details: Hash)
          expect(response).to have_http_status(:unprocessable_entity)
          expect(parsed_response_body[:details][:adults]).to be_present
          expect(parsed_response_body[:details][:children]).to be_present
        end
      end

      context "when people is greater than max_people_per_reservation" do
        let(:adults) { Setting[:max_people_per_reservation].to_i + 1 }

        it "returns 422" do
          req
          expect(parsed_response_body).to include(message: String, details: Hash)
          expect(response).to have_http_status(:unprocessable_entity)
          expect(parsed_response_body[:details][:adults]).to be_present
          expect(parsed_response_body[:details][:children]).to be_present
        end
      end

      context "when sum between children and adults is greater than max_people_per_reservation" do
        let(:adults) { Setting[:max_people_per_reservation].to_i - 1 }
        let(:children) { Setting[:max_people_per_reservation].to_i - 1 }

        it "returns 422" do
          req
          expect(parsed_response_body).to include(message: String, details: Hash)
          expect(response).to have_http_status(:unprocessable_entity)
          expect(parsed_response_body[:details][:adults]).to be_present
          expect(parsed_response_body[:details][:children]).to be_present
        end
      end

      context "when first_name is missing" do
        let(:first_name) { nil }

        it "returns 422" do
          req
          expect(parsed_response_body).to include(message: String, details: Hash)
          expect(response).to have_http_status(:unprocessable_entity)
          expect(parsed_response_body[:details][:first_name]).to be_present
        end
      end

      context "when first_name is empty" do
        let(:first_name) { " " }

        it "returns 422" do
          req
          expect(parsed_response_body).to include(message: String, details: Hash)
          expect(response).to have_http_status(:unprocessable_entity)
          expect(parsed_response_body[:details][:first_name]).to be_present
        end
      end

      context "when first_name is too short" do
        let(:first_name) { " a " }

        it "returns 422" do
          req
          expect(parsed_response_body).to include(message: String, details: Hash)
          expect(response).to have_http_status(:unprocessable_entity)
          expect(parsed_response_body[:details][:first_name]).to be_present
        end
      end

      context "when last_name is missing" do
        let(:last_name) { nil }

        it "returns 422" do
          req
          expect(parsed_response_body).to include(message: String, details: Hash)
          expect(response).to have_http_status(:unprocessable_entity)
          expect(parsed_response_body[:details][:last_name]).to be_present
        end
      end

      context "when last_name is empty" do
        let(:last_name) { " " }

        it "returns 422" do
          req
          expect(parsed_response_body).to include(message: String, details: Hash)
          expect(response).to have_http_status(:unprocessable_entity)
          expect(parsed_response_body[:details][:last_name]).to be_present
        end
      end

      context "when last_name is too short" do
        let(:last_name) { " a " }

        it "returns 422" do
          req
          expect(parsed_response_body).to include(message: String, details: Hash)
          expect(response).to have_http_status(:unprocessable_entity)
          expect(parsed_response_body[:details][:last_name]).to be_present
        end
      end

      context "when last_name has two letters" do
        let(:last_name) { " ab " }

        it { expect { req }.to change { Reservation.count }.by(1) }

        it "returns 200 and create record" do
          req
          expect(parsed_response_body).to include(item: Hash)
          expect(response).to have_http_status(:ok)
        end
      end

      context 'when last_name is "O\'reilly"' do
        let(:last_name) { "O'reilly" }

        it { expect { req }.to change { Reservation.count }.by(1) }

        it "returns 200 and create record" do
          req
          expect(parsed_response_body).to include(item: Hash)
          expect(response).to have_http_status(:ok)
        end
      end

      context 'when last_name is "Mc Donalds"' do
        let(:last_name) { "Mc Donalds" }

        it { expect { req }.to change { Reservation.count }.by(1) }

        it "returns 200 and create record" do
          req
          expect(parsed_response_body).to include(item: Hash)
          expect(response).to have_http_status(:ok)
        end
      end

      context 'should create a reservation with "<firstname> <lastname>" as fullname and save the detail in the "other" field' do
        let(:first_name) { "Gigi" }
        let(:last_name) { "Bagigi" }

        it "creates a reservation" do
          req
          expect(parsed_response_body).to include(item: Hash)
          expect(response).to have_http_status(:ok)
          expect(Reservation.last.fullname).to eq("#{first_name} #{last_name}")
          expect(Reservation.last.other).to include("first_name" => first_name, "last_name" => last_name)
        end
      end

      context "should upcase first letter or first name and last name" do
        let(:first_name) { "gigi" }
        let(:last_name) { "bagigi wassa" }

        it "creates a reservation" do
          req
          expect(parsed_response_body).to include(item: Hash)
          expect(response).to have_http_status(:ok)
          expect(Reservation.last.fullname).to eq("Gigi Bagigi Wassa")
          expect(Reservation.last.other).to include("first_name" => "Gigi", "last_name" => "Bagigi Wassa")
        end
      end

      context "should be able to provide multiple first name(s) and last name(s)" do
        let(:first_name) { "gigi pippo" }
        let(:last_name) { "bagigi wassa pluto" }

        it "creates a reservation" do
          req
          expect(parsed_response_body).to include(item: Hash)
          expect(response).to have_http_status(:ok)
          expect(Reservation.last.fullname).to eq("Gigi Pippo Bagigi Wassa Pluto")
          expect(Reservation.last.other).to include("first_name" => "Gigi Pippo", "last_name" => "Bagigi Wassa Pluto")
        end
      end

      context "when email is empty" do
        let(:email) { "" }

        it { expect { req }.not_to(change { Reservation.count }) }

        it "returns 422" do
          req
          expect(parsed_response_body).to include(message: String, details: Hash)
          expect(response).to have_http_status(:unprocessable_entity)
          expect(parsed_response_body[:details][:email]).to be_present
        end
      end

      context "when email is nil" do
        let(:email) { nil }

        it { expect { req }.not_to(change { Reservation.count }) }

        it "returns 422" do
          req
          expect(parsed_response_body).to include(message: String, details: Hash)
          expect(response).to have_http_status(:unprocessable_entity)
          expect(parsed_response_body[:details][:email]).to be_present
        end
      end

      context "when email is invalid" do
        [
          "plainaddress",
          "@example.com",
          "Joe Smith <",
          "email.example.com"
        ].each do |invalid_email|
          context "if email is '#{invalid_email}'" do
            let(:email) { invalid_email }

            it { expect { req }.not_to(change { Reservation.count }) }

            it "returns 422" do
              req
              expect(parsed_response_body).to include(message: String, details: Hash)
              expect(response).to have_http_status(:unprocessable_entity)
              expect(parsed_response_body[:details][:email]).to be_present
            end
          end
        end
      end

      context "when already exists a reservation for same datetime and email" do
        let!(:reservation) { create(:reservation, datetime:, email:) }

        it { expect { req }.not_to(change { Reservation.count }) }

        it "returns 422" do
          req
          expect(parsed_response_body).to include(message: String, details: Hash)
          expect(response).to have_http_status(:unprocessable_entity)
          expect(parsed_response_body[:message].to_s.downcase).to include("another reservation for this datetime")
          expect(parsed_response_body[:details][:email]).not_to be_empty
        end
      end

      context "when email is empty" do
        let(:email) { "" }

        it { expect { req }.not_to(change { Reservation.count }) }

        it "returns 422" do
          req
          expect(parsed_response_body).to include(message: String, details: Hash)
          expect(response).to have_http_status(:unprocessable_entity)
          expect(parsed_response_body[:details][:email]).to be_present
        end
      end

      context "when email is nil" do
        let(:email) { nil }

        it { expect { req }.not_to(change { Reservation.count }) }

        it "returns 422" do
          req
          expect(parsed_response_body).to include(message: String, details: Hash)
          expect(response).to have_http_status(:unprocessable_entity)
          expect(parsed_response_body[:details][:email]).to be_present
        end
      end

      context "when email is invalid" do
        [
          "plainaddress",
          "@example.com",
          "Joe Smith <",
          "email.example.com"
        ].each do |invalid_email|
          context "if email is '#{invalid_email}'" do
            let(:email) { invalid_email }

            it { expect { req }.not_to(change { Reservation.count }) }

            it "returns 422" do
              req
              expect(parsed_response_body).to include(message: String, details: Hash)
              expect(response).to have_http_status(:unprocessable_entity)
              expect(parsed_response_body[:details][:email]).to be_present
            end
          end
        end
      end

      context "when phone is empty" do
        let(:phone) { "" }

        it { expect { req }.not_to(change { Reservation.count }) }

        it "returns 422" do
          req
          expect(parsed_response_body).to include(message: String, details: Hash)
          expect(response).to have_http_status(:unprocessable_entity)
          expect(parsed_response_body[:details][:phone]).to be_present
        end
      end

      context "when phone is nil" do
        let(:phone) { nil }

        it { expect { req }.not_to(change { Reservation.count }) }

        it "returns 422" do
          req
          expect(parsed_response_body).to include(message: String, details: Hash)
          expect(response).to have_http_status(:unprocessable_entity)
          expect(parsed_response_body[:details][:phone]).to be_present
        end
      end

      context "when phone is invalid" do
        [
          "plainaddress",
          "@example.com",
          "Joe Smith <",
          "phone.example.com",
          "123",
          "3566"
        ].each do |invalid_phone|
          context "if phone is '#{invalid_phone}'" do
            let(:phone) { invalid_phone }

            it { expect { req }.not_to(change { Reservation.count }) }

            it "returns 422" do
              req
              expect(parsed_response_body).to include(message: String, details: Hash)
              expect(response).to have_http_status(:unprocessable_entity)
              expect(parsed_response_body[:details][:phone]).to be_present
            end
          end
        end
      end

      context "when phone is valid" do
        [
          "3515590063",
          "351 559 0063",
          "+39 351 559 0063",
          "+39 351-559 0063",
          "+39 (351)-559 0063",
          "+39 (351) 559 0063",
          "(351) 559 0063",
          "(351)-559-0063",
          "351-559-0063",
          "351.559.0063",
          "+39 351.559.0063",
          "+39.351.559.0063",
          "491.332.7060",
          "+393358063066",
          " +393358063066",
          " +393358063066 ",
          "+393358063066 "
        ].each do |valid_phone|
          context "if phone is '#{valid_phone}'" do
            let(:phone) { valid_phone }

            it { expect { req }.to change { Reservation.count }.by(1) }

            it "cleans the phone number before saving" do
              req
              vp = valid_phone.delete(".").gsub(/\s+/, "").delete("(").delete(")").delete("-")
              expect(Reservation.last.phone).to eq(vp)
            end

            it "returns 200" do
              req
              expect(parsed_response_body).to include(item: Hash)
              expect(response).to have_http_status(:ok)
            end
          end
        end
      end
    end
  end

  context "PATCH #cancel" do
    let(:params) { { secret: reservation.secret } }
    let!(:reservation) { create(:reservation) }

    it { expect(instance).to respond_to(:cancel) }

    it {
      expect(subject).to route(:patch, "/v1/reservations/cancel").to(format: :json, action: :cancel,
                                                                     controller: "v1/reservations")
    }

    def req(data = params)
      patch :cancel, params: data
    end

    context "basic" do
      context "should cancel a reservation" do
        it do
          req
          expect(parsed_response_body).to include(item: Hash)
          expect(response).to have_http_status(:ok)
        end

        it { expect { req }.to change { reservation.reload.status }.to("cancelled") }
      end

      context "if secret is not provided" do
        subject { response }

        let(:params) { {} }

        before { req }

        it_behaves_like NOT_FOUND
      end

      context "if secret is invalid" do
        subject { response }

        let(:params) { { secret: "some-invalid-secret" } }

        before { req }

        it_behaves_like NOT_FOUND
      end

      context "when record is invalid" do
        before do
          reservation
          allow_any_instance_of(Reservation).to receive(:cancelled!).and_return(false)
          errors = ActiveModel::Errors.new(Reservation.new)
          errors.add(:base, "some error")
          allow_any_instance_of(Reservation).to receive(:errors).and_return(errors)
        end

        it { expect { req }.not_to(change { Reservation.cancelled.count }) }
        it { expect { req }.not_to(change { reservation.reload.status }) }

        it "renders errors" do
          req
          expect(parsed_response_body).to include(message: String, details: Hash)
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end
  end

  context "GET #show" do
    let(:params) { { secret: reservation.secret } }
    let!(:reservation) { create(:reservation) }

    it { expect(instance).to respond_to(:show) }

    it {
      expect(subject).to route(:get, "/v1/reservations/supersecret").to(format: :json, action: :show, controller: "v1/reservations",
                                                                        secret: "supersecret")
    }

    def req(data = params)
      get :show, params: data
    end

    context "basic" do
      context "should return a reservation" do
        it do
          req
          expect(parsed_response_body).to include(item: Hash)
          expect(response).to have_http_status(:ok)
        end

        it { expect { req }.not_to(change { reservation.reload.as_json }) }

        context "checking data structure" do
          subject { parsed_response_body[:item] }

          before { req }

          it {
            expect(subject).to include(
                                 "id" => reservation.id,
                                 "fullname" => reservation.fullname,
                                 "datetime" => reservation.datetime,
                                 "adults" => reservation.adults,
                                 "children" => reservation.children,
                                 "email" => reservation.email,
                                 "phone" => reservation.phone,
                                 "notes" => reservation.notes
                               )
          }

          it { expect(subject.keys.map(&:to_s)).not_to include("secret") }
        end
      end

      context "when secret is invalid" do
        subject { response }

        let(:params) { { secret: "some-invalid-secret" } }

        before { req }

        it_behaves_like NOT_FOUND
      end

      context "when reservation is deleted" do
        subject { response }

        before do
          reservation.deleted!
          req
        end

        it_behaves_like NOT_FOUND
      end
    end
  end
end
