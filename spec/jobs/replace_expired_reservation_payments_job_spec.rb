# frozen_string_literal: true

require "rails_helper"

RSpec.describe ReplaceExpiredReservationPaymentsJob, type: :job do
  it "calls ReplaceExpiredReservationPayments.run!" do
    allow(ReplaceExpiredReservationPayments).to receive(:run!).and_return(true)
    described_class.perform_async
    described_class.perform_one
    expect(ReplaceExpiredReservationPayments).to have_received(:run!).once
  end
end
