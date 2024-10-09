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
        notes:,
        lang:,
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
    let(:lang) { :en }
    let!(:turn) do
      create(:reservation_turn, starts_at: DateTime.parse("00:01"), ends_at: DateTime.parse("23:59"), weekday: Time.now.beginning_of_week.wday)
    end

    it { expect(instance).to respond_to(:create) }

    it {
      expect(subject).to route(:post, "/v1/reservations").to(format: :json, action: :create,
                                                             controller: "v1/reservations")
    }

    def req(data = params)
      post :create, params: data
    end

    [
      { name: :sunday, wday: 0 },
      { name: :monday, wday: 1 },
      { name: :tuesday, wday: 2 },
      { name: :wednesday, wday: 3 },
      { name: :friday, wday: 5 },
      { name: :saturday, wday: 6 },
    ].each do |scenario|
      context "when providing a #{scenario[:name]} date, should create a reservation for turn with weekday=#{scenario[:wday]}" do
        let(:date) { Date.current.next_occurring(scenario[:name]) }
        let!(:turn) do
          create(:reservation_turn, starts_at: DateTime.parse("00:01"), ends_at: DateTime.parse("23:59"), weekday: scenario[:wday])
        end

        it { expect { req }.to change { Reservation.all.filter{|r| r.turn.weekday == scenario[:wday] }.count }.by(1) }
      end
    end

    context "when lang is blank" do
      let(:lang) { nil }

      it { expect { req }.not_to(change { Reservation.count }) }
      it do
        req
        expect(json).to include(message: /ang/) # lang may have 'l' capitalized
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    %w[it en].each do |mylang|
      context "when lang is #{mylang.inspect}, should assign lang to reservation" do
        let(:lang) { mylang }

        it { expect { req }.to(change { Reservation.count }.by(1)) }
        it { expect { req }.to(change { Reservation.where(lang: mylang).count }.by(1)) }

        it do
          req
          expect(json).not_to include(message: String)
          expect(response).to have_http_status(:ok)
        end
      end
    end

    %w[mario].each do |invalid_lang|
      context "when lang is #{invalid_lang.inspect}, should not create reservation" do
        let(:lang) { invalid_lang }

        it { expect { req }.not_to(change { Reservation.count }) }

        it do
          req
          expect(json).to include(message: /ang/)
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end

    [
      "Nicolò",
      "O'Reilly",
      "Mc Donalds",
      "Gigi Pippo"
    ].each do |special_name|
      context "when first_name is #{special_name.inspect}" do
        let(:first_name) { special_name }

        it { expect { req }.to change { Reservation.count }.by(1) }

        it do
          req
          expect(json).not_to include(message: String)
          expect(response).to have_http_status(:ok)
          expect(Reservation.last.fullname).to include(special_name)
        end
      end
    end

    context "assuming nexi APIs are working and we're authorized" do
      before do
        stub_request(:post, "#{Config.nexi_api_url}/#{Config.nexi_hpp_payment_path}").to_return do |request|
          {
            body: {
              hostedPage: "https://xpaysandbox.nexigroup.com/monetaweb/page/hosted/2/html?paymentid=#{Array.new(18) { (0..9).to_a.sample }.join()}",
              securityToken: SecureRandom.hex,
              warnings: []
            }.to_json
          }
        end
      end

      context "when a payment is always required for that turn" do
        let(:group) do
          create(:preorder_reservation_group).tap do |grp|
            grp.turns = [turn]
          end
        end

        before do
          group
        end

        it { expect { req }.to(change { Reservation.count }.by(1)) }
        it { expect { req }.to(change { ReservationPayment.count }.by(1)) }
        it { expect { req }.to(change { Nexi::HttpRequest.count }.by(1)) }

        it do
          req
          expect(Nexi::HttpRequest.count).to eq 1
          expect(Nexi::HttpRequest.last.http_code).to eq 200
          expect(Nexi::HttpRequest.last.record_type).to eq("Reservation")
          expect(Nexi::HttpRequest.last.record_id).to eq(Reservation.last.id)
          expect(Nexi::HttpRequest.last.purpose).to eq("reservation_payment")
          expect(Nexi::HttpRequest.last.request_body).to be_present
          expect(Nexi::HttpRequest.last.response_body).to be_present
        end

        it do
          req
          expect(json).to include(item: Hash)
          expect(response).to have_http_status(:ok)
        end
      end

      context "when a payment is required for that turn only for certain dates" do
        let(:group) do
          create(:preorder_reservation_group).tap do |grp|
            grp.dates.create(reservation_turn: turn, date: Time.now.beginning_of_week + 7.days)
            grp.dates.create(reservation_turn: turn, date: Time.now.beginning_of_week + 14.days)
            grp.dates.create(reservation_turn: turn, date: Time.now.beginning_of_week + 70.days)
          end
        end

        before do
          (0..6).each do |wday|
            next if ReservationTurn.where(weekday: wday).any?

            create(:reservation_turn, starts_at: DateTime.parse("00:01"), ends_at: DateTime.parse("23:59"), weekday: wday)
          end

          group
        end

        [
          Time.now.beginning_of_week + 7.days,
          Time.now.beginning_of_week + 14.days,
          Time.now.beginning_of_week + 70.days,
        ].each do |date0|
          context "when date is in the list: #{date0.inspect}" do
            let(:date) { date0 }

            it { expect { req }.to(change { Reservation.count }.by(1)) }
            it { expect { req }.to(change { ReservationPayment.count }.by(1)) }
            it { expect { req }.to(change { Nexi::HttpRequest.count }.by(1)) }

            it do
              req
              expect(Nexi::HttpRequest.count).to eq 1
              expect(Nexi::HttpRequest.last.http_code).to eq 200
              expect(Nexi::HttpRequest.last.record_type).to eq("Reservation")
              expect(Nexi::HttpRequest.last.record_id).to eq(Reservation.last.id)
              expect(Nexi::HttpRequest.last.purpose).to eq("reservation_payment")
              expect(Nexi::HttpRequest.last.request_body).to be_present
              expect(Nexi::HttpRequest.last.response_body).to be_present
            end

            it do
              req
              expect(json[:item].keys).to include("payment")
              expect(json[:item]["payment"].keys).to include("hpp_url")
              expect(json[:item]["payment"]["hpp_url"]).to be_present
              expect(json[:item]["payment"].keys).to include("status")
              expect(json[:item]["payment"]["status"]).to be_present
            end

            it do
              req
              expect(json).to include(item: Hash)
              expect(response).to have_http_status(:ok)
            end
          end
        end

        [
          Time.now.beginning_of_week + 6.days,
          Time.now.beginning_of_week + 8.days,
        ].each do |date0|
          context "when date is NOT in the list: #{date0.inspect}" do
            let(:date) { date0 }

            it { expect { req }.to(change { Reservation.count }.by(1)) }
            it { expect { req }.not_to(change { ReservationPayment.count }) }
            it { expect { req }.not_to(change { Nexi::HttpRequest.count }) }

            it do
              req
              expect(Nexi::HttpRequest.count).to eq 0
            end


            it do
              req
              expect(json[:item]["payment"]).to be_nil
            end

            it do
              req
              expect(json).to include(item: Hash)
              expect(response).to have_http_status(:ok)
            end
          end
        end
      end
    end

    context "basic" do
      context "checking response" do
        before { req }

        it { expect(json).to include(item: Hash) }
        it { expect(response).to have_http_status(:ok) }
        it { expect(json[:item]).to include("datetime" => String, "email" => String, "fullname" => String) }
        it { expect(json[:item]).to include("secret" => String) }
      end

      it "creates a reservation" do
        req
        expect(parsed_response_body).to include(item: Hash)
        expect(response).to have_http_status(:ok)
      end

      it "does enqueue email to reservation email" do
        req
        expect(ActionMailer::MailDeliveryJob).to have_been_enqueued.with("ReservationMailer", "confirmation",
                                                                         "deliver_now", params: anything, args: anything)
      end

      it "can deliver email" do
        Sidekiq::Testing.inline! do
          allow(ReservationMailer).to receive(:with).and_call_original

          req

          expect(ReservationMailer).to have_received(:with).once
        end
      end

      context "sets a cookie to retrieve reservation informations" do
        before { req }

        it { expect(response.cookies).not_to be_empty }
        it { expect(response.cookies[Reservation::PUBLIC_CREATE_COOKIE]).to eq(Reservation.last.secret) }
      end

      context "when turn is not in that weekday" do
        let!(:turn) do
          create(:reservation_turn, starts_at: DateTime.parse("00:01"), ends_at: DateTime.parse("23:59"), weekday: Time.now.beginning_of_week.wday + 1)
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

      context "when datetime has ISO format with 'Z' at the end." do
        let(:datetime) { "#{date.to_date}T19:00:00.000Z" }

        it { expect { req }.to(change { Reservation.count }.by(1)) }
        it { expect { req }.to(change { Reservation.where(datetime: DateTime.parse(datetime)).count }.by(1)) }

        it "returns 200" do
          req
          expect(parsed_response_body).not_to include(message: String)
        end

        it do
          req
          expect(response).to have_http_status(:ok)
        end
      end

      context "when datetime has ISO format without 'Z' at the end." do
        let(:datetime) { "#{date.to_date}T19:00:00.000" }

        it { expect { req }.to(change { Reservation.count }.by(1)) }
        it { expect { req }.to(change { Reservation.where(datetime: DateTime.parse(datetime)).count }.by(1)) }

        it "returns 200" do
          req
          expect(parsed_response_body).not_to include(message: String)
        end

        it do
          req
          expect(response).to have_http_status(:ok)
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
              "notes" => reservation.notes,
              "secret" => reservation.secret,
              "updated_at" => String,
              "created_at" => String,
            )
          }
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
