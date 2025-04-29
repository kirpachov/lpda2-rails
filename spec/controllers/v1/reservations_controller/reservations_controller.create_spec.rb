# frozen_string_literal: true

require "rails_helper"

# Usage:
# include_context "SUCCESSFUL V1::ReservationsController POST #create"
# include_context "SUCCESSFUL V1::ReservationsController POST #create", payment: true
# include_context "SUCCESSFUL V1::ReservationsController POST #create", payment: false
# include_context "SUCCESSFUL V1::ReservationsController POST #create", payment: { deferred: true }
RSpec.shared_examples "SUCCESSFUL V1::ReservationsController POST #create" do |options = {}|
  it do
    allow(ReservationsChannel).to receive(:notify_creation).and_call_original
    req
    expect(ReservationsChannel).to have_received(:notify_creation).once
  end

  it do
    req
    expect(json).not_to include(:message)
  end

  it do
    req
    expect(response).to have_http_status(:ok)
  end

  it { expect { req }.to(change(Reservation, :count).by(1)) }

  it do
    req
    expect(response.cookies["reservation_created"]).to eq(Reservation.last.secret)
  end

  it do
    req
    expect(response.cookies[Reservation::PUBLIC_CREATE_COOKIE]).to eq(Reservation.last.secret)
  end

  it do
    Sidekiq::Testing.inline! do
      allow(ReservationMailer).to receive(:with).and_call_original

      req

      expect(ReservationMailer).to have_received(:with).once
    end
  end

  if options[:payment]
    it { expect { req }.to(change(ReservationPayment, :count).by(1)) }
    it { expect { req }.to(change { Nexi::HttpRequest.count }.by(1)) }

    if options[:payment].is_a?(Hash)
      if options[:payment][:deferred] == true
        it { expect { req }.to(change { Nexi::HttpRequest.where("request_body->>'TCONTAB' = 'D'").count }.by(1)) }
        it { expect { req }.to(change { ReservationPayment.deferred.count }.by(1)) }
      end

      if options[:payment][:deferred] == false
        it { expect { req }.to(change { Nexi::HttpRequest.where("request_body->>'TCONTAB' = 'C'").count }.by(1)) }
        it { expect { req }.to(change { ReservationPayment.not_deferred.count }.by(1)) }
        it { expect { req }.to(change { ReservationPayment.todo.not_deferred.count }.by(1)) }
      end
    end
  end

  if options[:payment] == false
    it { expect { req }.not_to(change(ReservationPayment, :count)) }
    it { expect { req }.not_to(change(Nexi::HttpRequest, :count)) }
  end
end

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
        table_type_id:
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
    let(:date) { Time.zone.now.beginning_of_week + 7.days }
    let(:last_name) { Faker::Name.last_name }
    let(:first_name) { Faker::Name.first_name }
    let(:lang) { :en }
    let(:table_type_id) { nil }
    let!(:turn) do
      create(:reservation_turn, starts_at: DateTime.parse("00:01"), ends_at: DateTime.parse("23:59"),
                                weekday: Time.zone.now.beginning_of_week.wday)
    end

    before do
      Setting[:reservation_max_days_in_advance] = 0
    end

    it { expect(instance).to respond_to(:create) }

    it {
      expect(subject).to route(:post, "/v1/reservations").to(format: :json, action: :create,
                                                             controller: "v1/reservations")
    }

    def req(data = params)
      post :create, params: data
    end

    context "when number of children and adults are equal" do
      let(:adults) { 2 }
      let(:children) { 2 }

      it { expect { req }.to change { Reservation.count }.by(1) }

      context do
        before { req }

        it { expect(response).to have_http_status(:ok) }
        it { expect(json).to include(item: Hash) }
      end
    end

    context "when where are no adults, only children" do
      let(:adults) { 0 }
      let(:children) { 4 }

      it { expect { req }.to change { Reservation.count }.by(1) }

      context do
        before { req }

        it { expect(response).to have_http_status(:ok) }
        it { expect(json).to include(item: Hash) }
      end
    end

    context "when where are no adults nor children" do
      let(:adults) { 0 }
      let(:children) { 0 }

      it { expect { req }.not_to(change { Reservation.count }) }

      context do
        before { req }

        it { expect(response).to have_http_status(:unprocessable_entity) }
        it { expect(json).to include(message: String) }
      end
    end

    [
      { name: :sunday, wday: 0 },
      { name: :monday, wday: 1 },
      { name: :tuesday, wday: 2 },
      { name: :wednesday, wday: 3 },
      { name: :friday, wday: 5 },
      { name: :saturday, wday: 6 }
    ].each do |scenario|
      context "when providing a #{scenario[:name]} date, should create a reservation for turn with weekday=#{scenario[:wday]}" do
        let(:date) { Date.current.next_occurring(scenario[:name]) }
        let!(:turn) do
          create(:reservation_turn, starts_at: DateTime.parse("00:01"), ends_at: DateTime.parse("23:59"),
                                    weekday: scenario[:wday])
        end

        it { expect { req }.to change { Reservation.all.filter { |r| r.turn.weekday == scenario[:wday] }.count }.by(1) }
      end
    end

    context "when setting reservation_max_days_in_advance" do
      let!(:turn) do
        create(:reservation_turn, weekday: date.wday, starts_at: DateTime.parse("12:00"),
                                  ends_at: DateTime.parse("15:00"))
      end
      let(:datetime) { "#{date.to_date} #{time}" }
      let(:date) { Time.zone.now }
      let(:time) { "12:00" }

      before do
        Setting[:reservation_max_days_in_advance] = 3
      end

      def doit
        travel_to(Time.zone.now.beginning_of_day + 10.hours) do
          req
        end
      end

      context "when reserving for today" do
        it { expect { doit }.to(change { Reservation.count }) }

        it do
          doit
          expect(response).to have_http_status(:ok)
        end

        it do
          doit
          expect(json).not_to include(message: String)
        end
      end

      [2, 3].each do |days|
        context "when reserving for #{days} days in advance, is allowed" do
          let(:date) { Time.zone.now + days.days }

          it { expect { doit }.to(change { Reservation.count }) }

          it do
            doit
            expect(response).to have_http_status(:ok)
          end

          it do
            doit
            expect(json).not_to include(message: String)
          end
        end
      end

      [4, 5, 10].each do |days|
        context "when reserving for #{days} days in advance, is not allowed." do
          let(:date) { Time.zone.now + days.days }

          it { expect { doit }.not_to(change { Reservation.count }) }

          it do
            doit
            expect(response).to have_http_status(:unprocessable_entity)
          end

          it do
            doit
            expect(json).to include(message: /uture/)
          end
        end
      end
    end

    context "when setting reservation_min_hours_in_advance" do
      let!(:turn) do
        create(:reservation_turn, weekday: Time.zone.now.wday, starts_at: DateTime.parse("12:00"),
                                  ends_at: DateTime.parse("15:00"))
      end
      let(:datetime) { "#{date.to_date} #{time}" }
      let(:date) { Time.zone.now }
      let(:time) { "12:00" }

      before do
        Setting[:reservation_min_hours_in_advance] = 2
      end

      def doit
        travel_to(Time.zone.now.beginning_of_day + 12.hours) do
          req
        end
      end

      context "when trying to create a reservation for same time" do
        let(:time) { "12:00" }

        it { expect { doit }.not_to change(Reservation, :count) }

        it do
          doit
          expect(response).to have_http_status(:unprocessable_entity)
        end

        it do
          doit
          expect(json).to include(message: /atetime/)
        end

        it do
          doit
          expect(json.dig("details", "datetime")).to be_present
        end
      end

      context "when trying to create a reservation for a valid time" do
        let(:time) { "15:00" }

        it { expect { doit }.to change(Reservation, :count).by(1) }

        it do
          doit
          expect(response).to have_http_status(:ok)
        end

        it do
          doit
          expect(json).not_to include(message: String)
        end
      end
    end

    context "when a 'once' Holiday exists" do
      let!(:holiday) do
        create(:holiday, from_timestamp: 10.days.ago.strftime("%Y-%m-%d"),
                         to_timestamp: 10.days.from_now.strftime("%Y-%m-%d")).tap do |h|
          h.update!(message: "Some Message mario!")
        end
      end

      it { expect { req }.not_to change(Reservation, :count) }

      it do
        req
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it do
        req
        expect(json).to include(message: String)
        expect(json[:message]).to include(holiday.message)
      end
    end

    context "when a 'weekly' Holiday exists (whole day closed)" do
      let!(:holiday) do
        create(:holiday,
               from_timestamp: 10.days.ago.strftime("%Y-%m-%d"),
               to_timestamp: nil,
               weekly_from: "00:00",
               weekly_to: "23:59",
               weekday: date.wday).tap do |h|
          h.update!(message: "Whole day closed mario!")
        end
      end

      it { expect { req }.not_to change(Reservation, :count) }

      it do
        req
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it do
        req
        expect(json).to include(message: String)
        expect(json[:message]).to include(holiday.message)
      end
    end

    context "when a 'weekly' Holiday exists (closed only on the morning while the reservation is made for the evening)" do
      let!(:holiday) do
        create(:holiday,
               from_timestamp: 10.days.ago.strftime("%Y-%m-%d"),
               to_timestamp: nil,
               weekly_from: "10:00",
               weekly_to: "15:59",
               weekday: date.wday).tap do |h|
          h.update!(message: "Partially closed mario!")
        end
      end

      it { expect { req }.to change(Reservation, :count) }

      it do
        req
        expect(json).not_to include(message: String)
        expect(response).to have_http_status(:ok)
      end

      [
        "9:59",
        "16:00"
      ].each do |valid_time|
        context "when time is #{valid_time}" do
          let(:datetime) { "#{date.strftime("%Y-%m-%d")} #{valid_time}" }

          it { expect { req }.to change(Reservation, :count) }

          it do
            req
            expect(json).not_to include(message: String)
            expect(response).to have_http_status(:ok)
          end
        end
      end
    end

    context "when a 'weekly' Holiday exists but is for another wday" do
      let!(:holiday) do
        create(:holiday,
               from_timestamp: 10.days.ago.strftime("%Y-%m-%d"),
               to_timestamp: nil,
               weekly_from: "10:00",
               weekly_to: "15:59",
               weekday: (date.wday + 1) % 6).tap do |h|
          h.update!(message: "Whole day closed mario!")
        end
      end

      it { expect { req }.to change(Reservation, :count) }

      it do
        req
        expect(json).not_to include(message: String)
        expect(response).to have_http_status(:ok)
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
      "'Coro",
      "Coro'",
      "Jørgensen"
    ].each do |special_name|
      context "when first_name is #{special_name.inspect}" do
        let(:first_name) { special_name }

        it { expect { req }.to change { Reservation.count }.by(1) }

        it do
          req
          expect(json).not_to include(message: String)
          expect(response).to have_http_status(:ok)
          expect(Reservation.last.fullname).to include(special_name.delete("'"))
        end
      end

      context "when last_name is #{special_name.inspect}" do
        let(:last_name) { special_name }

        it { expect { req }.to change { Reservation.count }.by(1) }

        it do
          req
          expect(json).not_to include(message: String)
          expect(response).to have_http_status(:ok)
          expect(Reservation.last.fullname).to include(special_name.delete("'"))
        end
      end
    end

    [
      "Nicolò",
      "O'Reilly",
      "Mc Donalds",
      "De Santi",
      "Gigi Pippo",
      "Corò",
      "Perché",
      "Èloise"
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

      context "when last_name is #{special_name.inspect}" do
        let(:last_name) { special_name }

        it { expect { req }.to change { Reservation.count }.by(1) }

        it do
          req
          expect(json).not_to include(message: String)
          expect(response).to have_http_status(:ok)
          expect(Reservation.last.fullname).to include(special_name)
        end
      end
    end

    context "when nexi APIs return some kind of error" do
      before do
        stub_request(:post,
                     "#{Config.app.dig!(:nexi_api_url)}/#{Config.app.dig!(:nexi_simple_payment_path)}").to_return do |_request|
          {
            status: 200,
            body: File.read(Rails.root.join("spec", "fixtures", "nexi-error-page.html"))
          }
        end
      end

      context "when a payment is always required for that turn" do
        let(:group) do
          create(:preorder_reservation_group, preorder_type: %i[nexi_payment nexi_authorization].sample).tap do |grp|
            grp.turns = [turn]
          end
        end

        before do
          group
        end

        it do
          allow(ExceptionNotifier).to receive(:notify_exception).and_call_original
          req
          expect(ExceptionNotifier).to have_received(:notify_exception).once
        end

        it { expect { req }.not_to(change { Reservation.count }) }
        it { expect { req }.not_to(change { ReservationPayment.count }) }
        it { expect { req }.to(change { Nexi::HttpRequest.count }.by(1)) }
        it { expect { req }.to(change { Nexi::HttpRequest.where(http_code: 200).count }.by(1)) }

        it do
          req
          expect(json).to include(:message)
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end

    context "when nexi APIs return just a comment" do
      before do
        stub_request(:post,
                     "#{Config.app.dig!(:nexi_api_url)}/#{Config.app.dig!(:nexi_simple_payment_path)}").to_return do |_request|
          {
            status: 200,
            body: "<!-- some useless comment -->"
          }
        end
      end

      context "when a payment is always required for that turn" do
        let(:group) do
          create(:preorder_reservation_group, preorder_type: %i[nexi_payment nexi_authorization].sample).tap do |grp|
            grp.turns = [turn]
          end
        end

        before do
          group
        end

        it do
          allow(ExceptionNotifier).to receive(:notify_exception).and_call_original
          req
          expect(ExceptionNotifier).to have_received(:notify_exception).once
        end

        it { expect { req }.not_to(change { Reservation.count }) }
        it { expect { req }.not_to(change { ReservationPayment.count }) }
        it { expect { req }.to(change { Nexi::HttpRequest.count }.by(1)) }
        it { expect { req }.to(change { Nexi::HttpRequest.where(http_code: 200).count }.by(1)) }

        it do
          req
          expect(json).to include(:message)
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end

    context "when we're not authorized to use nexi APIs" do
      before do
        stub_request(:post,
                     "#{Config.app.dig!(:nexi_api_url)}/#{Config.app.dig!(:nexi_simple_payment_path)}").to_return do |_request|
          {
            body: error_html
          }
        end
      end

      let(:error_html) do
        File.read(Rails.root.join("spec", "fixtures", "nexi-unauthorized-page.html"))
      end

      context "when a payment is always required for that turn" do
        let(:group) do
          create(:preorder_reservation_group, preorder_type: %i[nexi_payment nexi_authorization].sample).tap do |grp|
            grp.turns = [turn]
          end
        end

        before do
          group
        end

        it { expect { req }.not_to(change { Reservation.count }) }
        it { expect { req }.not_to(change { ReservationPayment.count }) }
        it { expect { req }.to(change { Nexi::HttpRequest.count }.by(1)) }

        it do
          allow(ExceptionNotifier).to receive(:notify_exception).and_call_original
          req
          expect(ExceptionNotifier).to have_received(:notify_exception).once
        end

        it do
          req
          expect(json).to include(:message)
        end

        it do
          req
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end

    context "when nexi APIs are working and we're authorized" do
      before do
        stub_request(:post,
                     "#{Config.app.dig!(:nexi_api_url)}/#{Config.app.dig!(:nexi_simple_payment_path)}").to_return do |_request|
          {
            body: html
          }
        end
      end

      let(:html) do
        File.read(Rails.root.join("spec", "fixtures", "nexi-simple-payment-success-page.html"))
      end

      context "when preorder_reservation_group has a min_people" do
        let!(:group) do
          create(:preorder_reservation_group, min_people: 6, preorder_type: :nexi_authorization).tap do |grp|
            grp.turns = [turn]
          end
        end

        context "when adults is less than min_people" do
          let(:adults) { [2,3,4,5].sample }
          let(:children) { 0 }

          it { expect { req }.to(change { Reservation.count }) }
          it { expect { req }.not_to(change { ReservationPayment.count }) }

          it do
            req
            expect(json).not_to include(message: String)
            expect(response).to have_http_status(:ok)
          end
        end

        context "when adults equals or is more than min_people" do
          let(:adults) { [6,7,8].sample }
          let(:children) { 0 }

          it { expect { req }.to(change { Reservation.count }) }
          it { expect { req }.to(change { ReservationPayment.count }) }

          it do
            req
            expect(json).not_to include(message: String)
            expect(response).to have_http_status(:ok)
          end
        end
      end

      context "when preorder_type is :nexi_authorization, http request should include TCONTAB = 'D' option" do
        let(:group) do
          create(:preorder_reservation_group, preorder_type: :nexi_authorization).tap do |grp|
            grp.turns = [turn]
          end
        end

        before { group }

        it { expect { req }.to(change { Reservation.count }.by(1)) }
        it { expect { req }.to(change { ReservationPayment.all.pluck(:value) }.to([group.payment_value * 2])) }
        it { expect { req }.to(change { ReservationPayment.count }.by(1)) }
        it { expect { req }.to(change { Nexi::HttpRequest.count }.by(1)) }

        it do
          req
          expect(Nexi::HttpRequest.last.request_body.dig!("TCONTAB")).to eq("D")
        end
      end

      context "when preorder_type is :nexi_payment, http request should include TCONTAB = 'C' option" do
        let(:group) do
          create(:preorder_reservation_group, preorder_type: :nexi_payment).tap do |grp|
            grp.turns = [turn]
          end
        end

        before { group }

        it { expect { req }.to(change { ReservationPayment.all.pluck(:value) }.to([group.payment_value * 2])) }
        it { expect { req }.to(change { Reservation.count }.by(1)) }
        it { expect { req }.to(change { ReservationPayment.count }.by(1)) }
        it { expect { req }.to(change { Nexi::HttpRequest.count }.by(1)) }

        it do
          req
          expect(Nexi::HttpRequest.last.request_body.dig!("TCONTAB")).to eq("C")
        end
      end

      context "when a payment is always required for that turn" do
        let(:adults) { Random.rand(1..9) }
        let(:group) do
          create(:preorder_reservation_group, preorder_type: %i[nexi_payment nexi_authorization].sample).tap do |grp|
            grp.turns = [turn]
          end
        end

        before do
          group
        end

        it { expect { req }.to(change { ReservationPayment.all.pluck(:value) }.to([group.payment_value * adults])) }
        it { expect { req }.to(change { Reservation.count }.by(1)) }
        it { expect { req }.to(change { ReservationPayment.count }.by(1)) }
        it { expect { req }.to(change { Nexi::HttpRequest.count }.by(1)) }

        it do
          req
          expect(ActionMailer::MailDeliveryJob).to have_been_enqueued.with("ReservationMailer", "payment_required_to_confirm",
                                                                           "deliver_now", params: anything, args: anything).once
        end

        it do
          req
          expect(Nexi::HttpRequest.count).to eq 1
          expect(Nexi::HttpRequest.last.http_code).to eq 200
          expect(Nexi::HttpRequest.last.record_type).to eq("Reservation")
          expect(Nexi::HttpRequest.last.record_id).to eq(Reservation.last.id)
          expect(Nexi::HttpRequest.last.purpose).to eq("reservation_payment")
          expect(Nexi::HttpRequest.last.request_body).to be_present
          expect(Nexi::HttpRequest.last.request_body).to include("email" => Reservation.last.email)
          expect(Nexi::HttpRequest.last.html_response).to be_present
          expect(Nexi::HttpRequest.last.html_response).to eq(html)
          expect(ReservationPayment.last.success_url).to be_present
          expect(ReservationPayment.last.success_url).to include(Reservation.last.secret)
          expect(ReservationPayment.last.failure_url).to be_present
          expect(ReservationPayment.last.failure_url).to include(Reservation.last.secret)
          expect(Nexi::HttpRequest.last.request_body.dig!("url")).to be_present
          expect(Nexi::HttpRequest.last.request_body.dig!("url")).to eq(ReservationPayment.last.success_url)
          expect(Nexi::HttpRequest.last.request_body.dig!("url")).to include("/#{Reservation.last.lang}/#")
          expect(Nexi::HttpRequest.last.request_body.dig!("url_back")).to be_present
          expect(Nexi::HttpRequest.last.request_body.dig!("url_back")).to include("/#{Reservation.last.lang}/#")
          expect(Nexi::HttpRequest.last.request_body.dig!("url_back")).to eq(ReservationPayment.last.failure_url)
          expect(Nexi::HttpRequest.last.request_body.dig!("urlpost")).to start_with("http")
          expect(Nexi::HttpRequest.last.request_body.dig!("urlpost")).to include("/v1/nexi/receive_order_outcome")
          expect(Nexi::HttpRequest.last.request_body.dig!("urlpost")).to eq(Rails.application.routes.url_helpers.nexi_receive_order_outcome_url)
        end

        it do
          req
          expect(json).to include(item: Hash)
          expect(response).to have_http_status(:ok)
        end

        [
          { lang: "it", code: "ITA" },
          { lang: "en", code: "ENG" }
        ].each do |scenario|
          context "when lang is #{scenario[:lang].inspect}" do
            let(:lang) { scenario[:lang] }

            it { expect { req }.to(change { Reservation.count }.by(1)) }
            it { expect { req }.to(change { Reservation.where(lang: scenario[:lang]).count }.by(1)) }

            it { expect { req }.to(change { Nexi::HttpRequest.count }.by(1)) }

            it do
              req
              expect(json).to include(item: Hash)
              expect(response).to have_http_status(:ok)
            end

            it do
              req
              expect(Nexi::HttpRequest.last.request_body.dig!("url_back")).to include("/#{Reservation.last.lang}/#")
              expect(Reservation.last.payment.success_url).to include("/#{Reservation.last.lang}/#")
              expect(Nexi::HttpRequest.last.request_body.dig!("url")).to include("/#{Reservation.last.lang}/#")
              expect(Reservation.last.payment.failure_url).to include("/#{Reservation.last.lang}/#")
            end

            it do
              req
              expect(Nexi::HttpRequest.last.request_body.dig("languageId")).to eq(scenario[:code])
            end
          end
        end

        context "when payment supports table_types" do
          let!(:table_type) do
            create(:table_type, status: :active, default_price: 4)
          end

          let(:table_type_id) { table_type.id }

          before { group.add_table_type(table_type:, people_per_turn: 15, price: 3) }

          context "when user specifies valid table_type_id" do
            def fill_seats(count:, table_type:, datetimes:)
              available_seats = count
              while available_seats > 0
                adults_count = Random.rand(1..available_seats)
                children_count = Random.rand(0..(available_seats - adults_count))
                create(:reservation, datetime: datetimes.sample, table_type:, adults: adults_count,
                                     children: children_count)
                available_seats -= (adults_count + children_count)
              end
            end

            let(:table_type_id) { table_type.id }
            let(:adults) { 2 }
            let(:children) { 1 }

            it do
              req
              expect(json).not_to include(:message)
            end

            it { expect { req }.to(change { Reservation.count }.by(1)) }
            it { expect { req }.to(change { Reservation.all.pluck(:table_type_id) }.to([table_type_id])) }
            it { expect { req }.to(change { ReservationPayment.count }.by(1)) }
            it { expect { req }.to(change { ReservationPayment.all.pluck(:value) }.to([3.0 * (2 + 1)])) }

            context "when there are no seats available for that reservation turn, will notify user about that." do
              before do
                fill_seats(count: 15, table_type:, datetimes: [datetime])
                expect(Reservation.where(table_type:).pluck(:adults, :children).flatten.sum).to eq 15
                expect(Reservation.pluck(:adults, :children).flatten.sum).to eq 15
              end

              it do
                req
                expect(json).to include(message: /able/)
                expect(json).to include(message: /turn/)
                expect(json).to include(message: /type/)
                expect(json).to include(message: /seat/)
              end

              it do
                req
                expect(response).to have_http_status(:unprocessable_entity)
              end

              it { expect { req }.not_to change(Reservation, :count) }
              it { expect { req }.not_to change(ReservationPayment, :count) }
            end

            context "when there NOT seats free." do
              [
                { adults: 1, children: 0 },
                { adults: 1, children: 2 },
                { adults: 2, children: 1 },
                { adults: 3, children: 0 }
              ].each do |scenario|
                context "when have #{scenario[:adults]} adults and #{scenario[:children]} children" do
                  let(:adults) { scenario[:adults] }
                  let(:children) { scenario[:children] }
                  let(:datetime) { "#{date.to_date} 19:00" }
                  let(:datetime_18) { "#{date.to_date} 18:00" }
                  let(:datetime_21) { "#{date.to_date} 21:00" }

                  before do
                    expect do
                      fill_seats(count: 15, table_type:, datetimes: [datetime, datetime_18, datetime_21])
                    end.to change { Reservation.all.pluck(:adults, :children).flatten.sum }.from(0).to(15)
                  end

                  # it { expect(Reservation.all.pluck(:adults, :children).flatten.sum).to eq(12) }

                  it do
                    req
                    expect(json).to include(message: /type/)
                    expect(json).to include(message: /turn/)
                    expect(json).to include(message: /seat/)
                  end

                  it do
                    req
                    expect(response).to have_http_status(:unprocessable_entity)
                  end

                  it { expect { req }.not_to(change(Reservation, :count)) }
                  it { expect { req }.not_to(change(ReservationPayment, :count)) }
                end
              end
            end

            context "when there are still a couple seats free." do
              [
                { adults: 1, children: 2 },
                { adults: 2, children: 1 },
                { adults: 3, children: 0 }
              ].each do |scenario|
                context "when have #{scenario[:adults]} adults and #{scenario[:children]} children" do
                  let(:adults) { scenario[:adults] }
                  let(:children) { scenario[:children] }
                  let(:datetime) { "#{date.to_date} 19:00" }
                  let(:datetime_18) { "#{date.to_date} 18:00" }
                  let(:datetime_1830) { "#{date.to_date} 18:30" }
                  let(:datetime_21) { "#{date.to_date} 21:00" }
                  let(:datetime_2130) { "#{date.to_date} 21:30" }

                  let!(:turn) do
                    create(:reservation_turn, starts_at: DateTime.parse("18:00"), ends_at: DateTime.parse("19:59"),
                                              weekday: date.wday)
                  end

                  let!(:turn2) do
                    create(:reservation_turn, starts_at: DateTime.parse("20:00"), ends_at: DateTime.parse("21:59"),
                                              weekday: date.wday)
                  end

                  let!(:table_type2) do
                    create(:table_type, status: :active, default_price: 4)
                  end

                  before do
                    group.add_table_type(table_type: table_type2, people_per_turn: 15, price: 3)

                    # Creating some reservations that should not be counted
                    # This will be all cancelled or deleted
                    fill_seats(count: 5, table_type:, datetimes: [datetime, datetime_18, datetime_1830])
                    Reservation.all.each { |r| r.update!(status: %w[deleted cancelled].sample) }

                    # These belong to a different table type so won't be counted.
                    fill_seats(count: 5, table_type: table_type2, datetimes: [datetime, datetime_18, datetime_1830])

                    # These don't even have a table type
                    fill_seats(count: 5, table_type: nil, datetimes: [datetime, datetime_18, datetime_1830])

                    # These belong to another reservation turn
                    expect do
                      fill_seats(count: 12, table_type:, datetimes: [datetime_21, datetime_2130])
                    end.to change { Reservation.all.pluck(:adults, :children).flatten.sum }.by(12)

                    expect do
                      fill_seats(count: 12, table_type:, datetimes: [datetime, datetime_18, datetime_1830])
                    end.to change { Reservation.all.pluck(:adults, :children).flatten.sum }.by(12)
                  end

                  include_context "SUCCESSFUL V1::ReservationsController POST #create", payment: { deferred: false }
                end
              end
            end
          end

          context "when base payment requires an authorization, if table_type is specified will create a payment instead" do
            before { group.update!(preorder_type: :nexi_authorization) }

            let(:table_type_id) { table_type.id }
            let(:adults) { 2 }

            include_context "SUCCESSFUL V1::ReservationsController POST #create", payment: { deferred: false }
          end

          context "when base payment requires an authorization, if table_type is not present will create an authorization (as expected)" do
            before { group.update!(preorder_type: :nexi_authorization) }

            let(:table_type_id) { nil }
            let(:adults) { 2 }

            include_context "SUCCESSFUL V1::ReservationsController POST #create", payment: { deferred: true }
          end

          context "when base payment requires a payment, if table_type is specified will create a payment (as expected)" do
            before { group.update!(preorder_type: :nexi_payment) }

            let(:table_type_id) { table_type.id }

            include_context "SUCCESSFUL V1::ReservationsController POST #create", payment: { deferred: false }
          end

          context "when base payment requires a payment, if table_type is not present will create a payment (as expected)" do
            before { group.update!(preorder_type: :nexi_payment) }

            let(:table_type_id) { nil }

            include_context "SUCCESSFUL V1::ReservationsController POST #create", payment: { deferred: false }
          end

          context "when not specifying table type id, will use base payment" do
            let(:table_type_id) { nil }

            include_context "SUCCESSFUL V1::ReservationsController POST #create", payment: true

            it {
              expect { req }.to(change do
                                  ReservationPayment.all.pluck(:value)
                                end.to([group.payment_value.to_f * (adults + children)]))
            }
          end

          context "when not specifying table type id and payment value is zero, won't create reservation payment" do
            let(:table_type_id) { nil }

            before { group.update!(payment_value: 0) }

            it { expect { req }.not_to(change { ReservationPayment.count }) }

            include_context "SUCCESSFUL V1::ReservationsController POST #create", payment: false
          end

          context "when user specifies invalid table_type_id" do
            let(:table_type_id) { 999_999_999 }

            it do
              req
              expect(response).to have_http_status(:unprocessable_entity)
              expect(json).to include(message: /able/)
              expect(json).to include(message: /ype/)
            end

            it { expect { req }.not_to(change { Reservation.count }) }
            it { expect { req }.not_to(change { ReservationPayment.count }) }
          end

          context "when the specified table_type_id is not active" do
            before { table_type.inactive! }

            it do
              req
              expect(response).to have_http_status(:unprocessable_entity)
              expect(json).to include(message: /able/)
              expect(json).to include(message: /ype/)
            end

            it { expect { req }.not_to(change { Reservation.count }) }
            it { expect { req }.not_to(change { ReservationPayment.count }) }
          end

          context "when the specified table_type_id is not associated to that preorder reservation group" do
            before { TableTypeToPreorderReservationGroup.delete_all }

            it do
              req
              expect(response).to have_http_status(:unprocessable_entity)
              expect(json).to include(message: /able/)
              expect(json).to include(message: /ype/)
            end

            it { expect { req }.not_to(change { Reservation.count }) }
            it { expect { req }.not_to(change { ReservationPayment.count }) }
          end
        end
      end

      context "when a payment is required for that turn only for certain dates" do
        let(:group) do
          create(:preorder_reservation_group, preorder_type: %i[nexi_payment nexi_authorization].sample).tap do |grp|
            grp.dates.create(reservation_turn: turn, date: Time.zone.now.beginning_of_week + 7.days)
            grp.dates.create(reservation_turn: turn, date: Time.zone.now.beginning_of_week + 14.days)
            grp.dates.create(reservation_turn: turn, date: Time.zone.now.beginning_of_week + 70.days)
          end
        end

        before do
          (0..6).each do |wday|
            next if ReservationTurn.where(weekday: wday).any?

            create(:reservation_turn, starts_at: DateTime.parse("00:01"), ends_at: DateTime.parse("23:59"),
                                      weekday: wday)
          end

          group
        end

        [
          Time.zone.now.beginning_of_week + 7.days,
          Time.zone.now.beginning_of_week + 14.days,
          Time.zone.now.beginning_of_week + 70.days
        ].each do |date0|
          context "when date is in the list: #{date0.inspect}" do
            let(:date) { date0 }

            include_context "SUCCESSFUL V1::ReservationsController POST #create", payment: true

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
              expect(Nexi::HttpRequest.last.html_response).to be_present
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
          Time.zone.now.beginning_of_week + 8.days,
          Time.zone.now.beginning_of_week + 10.days
        ].each do |date0|
          context "when date is NOT in the list: #{date0.inspect}" do
            let(:date) { date0 }

            include_context "SUCCESSFUL V1::ReservationsController POST #create", payment: false

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
          create(:reservation_turn, starts_at: DateTime.parse("00:01"), ends_at: DateTime.parse("23:59"),
                                    weekday: Time.zone.now.beginning_of_week.wday + 1)
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
end
