# frozen_string_literal: true

require "rails_helper"

RSpec.describe Stats::FeedbackCount do
  describe "#execute" do
    subject(:result) { described_class.run!(params: {}) }

    context "when no reservation has been asked or opened feedback yet" do
      it "does not raise and returns zeroed counts" do
        expect { result }.not_to raise_error

        expect(result[:asked_feedback_count][:always]).to eq(0)
        expect(result[:open_feedback_count][:always]).to eq(0)
      end

      it "returns 0 for the ratio instead of NaN/Infinity" do
        expect(result[:open_to_asked_ratio]).to eq(always: 0.0, current_month: 0.0, last_30_days: 0.0)
      end
    end

    context "when some reservations were asked and opened feedback" do
      before do
        create(:reservation, datetime: 1.day.ago, fb_asked_at: 12.hours.ago, fb_open_at: 6.hours.ago)
        create(:reservation, datetime: 1.day.ago, fb_asked_at: 12.hours.ago)
      end

      it "counts asked and opened feedback separately" do
        expect(result[:asked_feedback_count][:always]).to eq(2)
        expect(result[:open_feedback_count][:always]).to eq(1)
      end

      it "computes the open/asked ratio" do
        expect(result[:open_to_asked_ratio][:always]).to eq(0.5)
      end
    end
  end
end
