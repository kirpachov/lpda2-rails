# frozen_string_literal: true

require "rails_helper"

RSpec.describe V1::ReservationsController, type: :controller do
  let(:instance) { described_class.new }

  include_context CONTROLLER_UTILS_CONTEXT
  include_context TESTS_OPTIMIZATIONS_CONTEXT

  context "PATCH #cancel" do
    let(:lang) { I18n.default_locale }
    let(:params) { { secret: reservation.secret, lang: } }
    let!(:reservation) { create(:reservation) }

    let(:nexi_response) do
      {
        esito: "OK",
        idOperazione: reservation.payment.external_id,
        timeStamp: Time.zone.now.to_i * 1000,
        mac: SecureRandom.hex
      }
    end

    it { expect(instance).to respond_to(:cancel) }

    it {
      expect(subject).to route(:patch, "/v1/reservations/cancel").to(format: :json, action: :cancel,
                                                                     controller: "v1/reservations")
    }

    def stub_nexi_server
      stub_request(:post,
                   "#{Config.app.dig!(:nexi_api_url)}/#{Config.app.dig!(:nexi_refund_payment_path)}").to_return do |_request|
        {
          status: 200,
          headers: { "Content-Type" => "application/json" },
          body: nexi_response.to_json
        }
      end
    end

    def req(data = params)
      stub_nexi_server
      patch :cancel, params: data
    end

    context "will send email to customer", :perform_enqueued_jobs do
      before do
        CreateMissingImages.run!
      end

      it { expect { req }.to change { ActionMailer::Base.deliveries.count }.by(1) }
      it { expect { req }.to change { Log::DeliveredEmail.count }.by(1) }

      %w[
        paid
        todo
        refunded
      ].each do |payment_status|
        context "when reservation has a payment in status #{payment_status.inspect}" do
          let!(:payment) { create(:reservation_payment, status: payment_status, reservation:) }

          it  { expect { req }.not_to(change { ReservationPayment.count }) }
          it  { expect { req }.not_to(change { Reservation.count }) }
          it { expect { req }.to change { ActionMailer::Base.deliveries.count }.by(1) }
          it { expect { req }.to change { Log::DeliveredEmail.count }.by(1) }

          it do
            req
            expect(response).to have_http_status(:ok)
          end

          it do
            expect { req }.to change { reservation.reload.status }.to("cancelled")
          end
        end
      end
    end

    context "when setting nexi_auto_refund_cancelled_reservations is true" do
      let!(:payment) { create(:reservation_payment, status: :paid, reservation:) }

      before do
        Setting[:nexi_auto_refund_cancelled_reservations] = "true"
      end

      context "when reservation payment is paid" do
        before { payment.paid! }

        it  { expect { req }.not_to(change { ReservationPayment.count }) }
        it  { expect { req }.not_to(change { Reservation.count }) }

        it do
          req
          expect(response).to have_http_status(:ok)
        end

        it { expect { req }.to change { reservation.reload.status }.to("cancelled") }
        it { expect { req }.to change { reservation.payment.reload.status }.to("refunded") }
      end

      %w[
        todo
        refunded
      ].each do |payment_status|
        context "when reservation payment is paid" do
          before { payment.update!(status: payment_status) }

          it  { expect { req }.not_to(change { ReservationPayment.count }) }
          it  { expect { req }.not_to(change { Reservation.count }) }

          it do
            req
            expect(response).to have_http_status(:ok)
          end

          it { expect { req }.to change { reservation.reload.status }.to("cancelled") }
          it { expect { req }.not_to(change { reservation.payment.reload.status }) }
        end
      end

      context "when reservation has no payment" do
        before { reservation.payment.destroy }

        it  { expect { req }.not_to(change { ReservationPayment.count }) }
        it  { expect { req }.not_to(change { Reservation.count }) }

        it do
          req
          expect(response).to have_http_status(:ok)
        end

        it { expect { req }.to change { reservation.reload.status }.to("cancelled") }
      end
    end

    %w[it en].each do |lang|
      context "when lang is #{lang} if reservation_min_hours_advance_cancel is set and reservation is too close" do
        let(:lang) { lang }
        let(:reservation) { create(:reservation, datetime:) }

        # #################################
        # Case when not allowed
        # #################################
        [
          ["2024-11-24 18:00", "2024-11-24 17:00", 1],
          ["2024-11-24 18:00", "2024-11-24 17:30", 1],
          ["2024-11-24 18:00", "2024-11-24 17:01", 1],
          ["2024-11-24 18:00", "2024-11-24 17:59", 1],
          ["2024-11-24 18:00", "2024-11-24 10:01", 10],
          ["2024-11-24 18:00", "2024-11-24 18:01", 24]
        ].each do |scenario|
          context "when scenario #{scenario.inspect} should not be allowed" do
            let(:datetime) { DateTime.parse(scenario[0]) }
            let(:now_datetime) { DateTime.parse(scenario[1]) }
            let(:config_value) { scenario[2] }

            before do
              Setting[:reservation_min_hours_advance_cancel] = config_value
            end

            def req(data = params)
              travel_to(now_datetime) { super(data) }
            end

            it do
              req
              expect(response).to have_http_status(:unprocessable_entity)
            end

            it { expect { req }.not_to(change { reservation.reload.status }) }
          end
        end

        # #################################
        # Allowed
        # #################################
        [
          ["2024-11-24 18:00", "2024-11-24 14:00", 1],
          ["2024-11-24 18:00", "2024-11-24 11:30", 1],
          ["2024-11-24 18:00", "2024-11-24 10:01", 1],
          ["2024-11-24 18:00", "2024-11-20 17:59", 1]
        ].each do |scenario|
          context "when scenario #{scenario.inspect} should be allowed" do
            let(:datetime) { DateTime.parse(scenario[0]) }
            let(:now_datetime) { DateTime.parse(scenario[0]) }
            let(:config_value) { scenario[1] }

            before do
              Setting[:reservation_min_hours_advance_cancel] = config_value
            end

            def req(data = params)
              travel_to(now_datetime) { super(data) }
            end

            it do
              req
              expect(response).to have_http_status(:unprocessable_entity)
            end

            it { expect { req }.not_to(change { reservation.reload.status }) }
          end
        end
      end
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

    %w[cancelled deleted].each do |invalid_status|
      context "when reservation is in status #{invalid_status.inspect}" do
        let(:reservation) { create(:reservation, status: :active, datetime: 1.week.from_now) }

        before do
          reservation.update!(status: invalid_status)
          req
        end

        it { expect(response).to have_http_status(:not_found) }
        it { expect(json).not_to include(:item) }
        it { expect(json).to include(message: String) }
      end
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
              "created_at" => String
            )
          }
        end

        context "when payment has a payment associated" do
          before do
            create(:reservation_payment, reservation:)
            req
          end

          it { expect(json[:item]).to include("payment" => Hash) }
          it { expect(json[:item]["payment"]).to include("status" => reservation.reload.payment.status) }
          it { expect(json[:item]["payment"]).to include("value" => reservation.reload.payment.value) }
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
