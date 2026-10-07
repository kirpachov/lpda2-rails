# frozen_string_literal: true

require "rails_helper"

RSpec.describe FetchReservationPaymentStatusJob, type: :job do
  describe "#perform" do
    let(:reservation_payment) { create(:reservation_payment, reservation: create(:reservation)) }

    it "calls FetchReservationPaymentStatus.run! with the found reservation_payment" do
      allow(FetchReservationPaymentStatus).to receive(:run!).and_return(true)
      described_class.perform_async("reservation_payment_id" => reservation_payment.id)
      described_class.perform_one
      expect(FetchReservationPaymentStatus).to have_received(:run!).with(reservation_payment:).once
    end

    context "when reservation_payment_id does not match any record" do
      it "raises ActiveRecord::RecordNotFound" do
        described_class.perform_async("reservation_payment_id" => 0)
        expect { described_class.perform_one }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
