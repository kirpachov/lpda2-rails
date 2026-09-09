# frozen_string_literal: true

require "rails_helper"

RSpec.describe FeedbackReservationsMailJob, type: :job do
  it "calls FeedbackReservationsMail.run!" do
    allow(FeedbackReservationsMail).to receive(:run!).and_return(true)
    described_class.perform_async
    described_class.perform_one
    expect(FeedbackReservationsMail).to have_received(:run!).once
  end
end
