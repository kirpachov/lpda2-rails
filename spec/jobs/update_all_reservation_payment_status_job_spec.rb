# frozen_string_literal: true

require "rails_helper"

RSpec.describe UpdateAllReservationPaymentStatusJob, type: :job do
  describe "#perform" do
    def doit
      described_class.new.perform
    end

    before do
      allow(FetchReservationPaymentStatusJob).to receive(:perform_async)
    end

    context "when there is a reservation payment for a next, public visible reservation" do
      let(:reservation) { create(:reservation, datetime: 1.day.from_now) }
      let!(:reservation_payment) { create(:reservation_payment, reservation:) }

      it "enqueues a FetchReservationPaymentStatusJob for the payment" do
        doit
        expect(FetchReservationPaymentStatusJob).to have_received(:perform_async).with(
          "reservation_payment_id" => reservation_payment.id
        ).once
      end
    end

    context "when the reservation is in the past" do
      let(:reservation) { create(:reservation, datetime: 1.day.ago) }
      let!(:reservation_payment) { create(:reservation_payment, reservation:) }

      it "does not enqueue any job" do
        doit
        expect(FetchReservationPaymentStatusJob).not_to have_received(:perform_async)
      end
    end

    context "when the reservation is cancelled" do
      let(:reservation) { create(:reservation, datetime: 1.day.from_now, status: "cancelled") }
      let!(:reservation_payment) { create(:reservation_payment, reservation:) }

      it "does not enqueue any job" do
        doit
        expect(FetchReservationPaymentStatusJob).not_to have_received(:perform_async)
      end
    end

    context "when the reservation is deleted" do
      let(:reservation) { create(:reservation, datetime: 1.day.from_now, status: "deleted") }
      let!(:reservation_payment) { create(:reservation_payment, reservation:) }

      it "does not enqueue any job" do
        doit
        expect(FetchReservationPaymentStatusJob).not_to have_received(:perform_async)
      end
    end

    context "when there are no reservation payments at all" do
      it "does not raise" do
        expect { doit }.not_to raise_error
      end

      it "does not enqueue any job" do
        doit
        expect(FetchReservationPaymentStatusJob).not_to have_received(:perform_async)
      end
    end

    context "when there are multiple qualifying payments" do
      let(:reservation1) { create(:reservation, datetime: 1.day.from_now) }
      let(:reservation2) { create(:reservation, datetime: 2.days.from_now) }
      let!(:payment1) { create(:reservation_payment, reservation: reservation1) }
      let!(:payment2) { create(:reservation_payment, reservation: reservation2) }

      it "enqueues a job for each payment" do
        doit
        expect(FetchReservationPaymentStatusJob).to have_received(:perform_async).twice
        expect(FetchReservationPaymentStatusJob).to have_received(:perform_async).with("reservation_payment_id" => payment1.id)
        expect(FetchReservationPaymentStatusJob).to have_received(:perform_async).with("reservation_payment_id" => payment2.id)
      end
    end
  end
end
