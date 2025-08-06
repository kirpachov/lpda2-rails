# frozen_string_literal: true

require "rails_helper"

RSpec.describe DeliverFirstConfirmationEmail, type: :interaction do
  subject { described_class.run(reservation:) }

  let(:reservation) { create(:reservation, status: :active) }

  context "when email already delivered" do
    it "skips execution" do
      allow(reservation).to receive(:delivered_emails).and_return([double])
      allow(reservation).to receive(:active?).and_return(true)
      allow(Reservation).to receive_message_chain(:public_visible, :next, :exists?).and_return(true)
      result = described_class.run(reservation:)
      expect(result).to be_valid
      expect(result.result).to eq("email already delivered")
    end
  end

  context "when reservation is not active" do
    it "skips execution" do
      allow(reservation).to receive(:delivered_emails).and_return([])
      allow(reservation).to receive(:active?).and_return(false)
      allow(reservation).to receive(:status).and_return("cancelled")
      allow(Reservation).to receive_message_chain(:public_visible, :next, :exists?).and_return(true)
      result = described_class.run(reservation:)
      expect(result).to be_valid
      expect(result.result).to eq("reservation status <> active: cancelled")
    end
  end

  context "when reservation is not among visible and next" do
    it "skips execution" do
      allow(reservation).to receive(:delivered_emails).and_return([])
      allow(reservation).to receive(:active?).and_return(true)
      allow(Reservation).to receive_message_chain(:public_visible, :next, :exists?).and_return(false)
      result = described_class.run(reservation:)
      expect(result).to be_valid
      expect(result.result).to eq("reservation could not be found between visible and next reservations")
    end
  end

  context "when reservation is confirmed and not delivered" do
    it "delivers confirmation email" do
      allow(reservation).to receive(:delivered_emails).and_return([])
      allow(reservation).to receive(:active?).and_return(true)
      allow(Reservation).to receive_message_chain(:public_visible, :next, :exists?).and_return(true)
      allow(reservation).to receive(:confirmed?).and_return(true)
      expect(reservation).to receive(:deliver_confirmation_email)
      result = described_class.run(reservation:)
      expect(result).to be_valid
      expect(result.result).to be_nil
    end
  end

  context "when reservation is not confirmed and not delivered" do
    it "delivers payment required email" do
      allow(reservation).to receive(:delivered_emails).and_return([])
      allow(reservation).to receive(:active?).and_return(true)
      allow(Reservation).to receive_message_chain(:public_visible, :next, :exists?).and_return(true)
      allow(reservation).to receive(:confirmed?).and_return(false)
      expect(reservation).to receive(:deliver_payment_required_email)
      result = described_class.run(reservation:)
      expect(result).to be_valid
      expect(result.result).to be_nil
    end
  end

  context "when reservation is missing" do
    it "is invalid" do
      result = described_class.run(reservation: nil)
      expect(result).not_to be_valid
      expect(result.errors[:reservation]).to be_present
    end
  end
end
