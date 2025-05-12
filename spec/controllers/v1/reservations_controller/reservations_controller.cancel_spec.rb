# frozen_string_literal: true

require "rails_helper"

RSpec.shared_examples "SUCCESSFUL V1::ReservationsController PATCH #cancel" do |_options = {}|
  it do
    allow(ReservationsChannel).to receive(:notify_cancellation).and_call_original
    req
    expect(ReservationsChannel).to have_received(:notify_cancellation).once
  end

  it do
    req
    expect(json).not_to include(:message)
  end

  it do
    req
    expect(response).to have_http_status(:ok)
  end

  it { expect { req }.not_to(change(Reservation, :count)) }
  it { expect { req }.to(change { Reservation.cancelled.count }.by(1)) }
end

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

          it_behaves_like "SUCCESSFUL V1::ReservationsController PATCH #cancel"

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

        it_behaves_like "SUCCESSFUL V1::ReservationsController PATCH #cancel"

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

          it_behaves_like "SUCCESSFUL V1::ReservationsController PATCH #cancel"

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

        it_behaves_like "SUCCESSFUL V1::ReservationsController PATCH #cancel"

        it  { expect { req }.not_to(change { ReservationPayment.count }) }
        it  { expect { req }.not_to(change { Reservation.count }) }

        it do
          req
          expect(response).to have_http_status(:ok)
        end

        it { expect { req }.to change { reservation.reload.status }.to("cancelled") }
      end
    end

    context "when reservation has no payment or it's not paid, will allow cancellation" do
      let(:datetime) { DateTime.parse("2024-11-24 18:00") }
      let(:now_datetime) { DateTime.parse("2024-11-24 17:00") }

      let(:reservation) do
        create(:reservation, datetime:).tap do |r|
          create(:reservation_payment, status: %w[todo refunded].sample, reservation: r)
        end
      end

      before do
        reservation.payment.destroy if Random.rand > 0.5
        Setting[:reservation_min_hours_advance_cancel] = 10
      end

      def doit
        travel_to(now_datetime) do
          req
        end
      end

      it { expect { doit }.to change { reservation.reload.status }.to("cancelled") }

      it do
        doit
        expect(json).not_to include(:message)
        expect(response).to have_http_status(:ok)
      end
    end

    %w[it en].each do |lang|
      context "when lang is #{lang} if reservation_min_hours_advance_cancel is set and reservation is too close, and reservation has payment" do
        let(:lang) { lang }
        let(:reservation) do
          create(:reservation, datetime:).tap do |r|
            create(:reservation_payment, status: %w[authorized paid].sample, reservation: r)
          end
        end

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
              expect(json).not_to include(:message)
              expect(response).to have_http_status(:ok)
            end

            it { expect { req }.to(change { reservation.reload.status }.to("cancelled")) }

            context "when reservation has no payment, should update status to cancelled" do
              before { reservation.payment.destroy }

              it do
                req
                expect(json).not_to include(:message)
                expect(response).to have_http_status(:ok)
              end

              it { expect { req }.to(change { reservation.reload.status }.to("cancelled")) }
            end

            %w[paid todo refunded authorized].each do |pstatus|
              context "when reservation has payment with status '#{pstatus}', should update status to cancelled" do
                before { reservation.payment.update!(status: pstatus) }

                it do
                  req
                  expect(json).not_to include(:message)
                  expect(response).to have_http_status(:ok)
                end

                it { expect { req }.to(change { reservation.reload.status }.to("cancelled")) }
              end
            end
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
end
