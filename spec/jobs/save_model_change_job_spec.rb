# frozen_string_literal: true

require "rails_helper"

RSpec.describe SaveModelChangeJob, type: :job do
  describe "#perform" do
    let(:user) { create(:user) }

    def doit
      described_class.new.perform(data)
    end

    context "when data is valid" do
      let(:data) do
        {
          "record_type" => "User",
          "record_id" => user.id,
          "change_type" => "create",
          "record_changes" => { "email" => [nil, user.email] },
          "changed_fields" => ["email"]
        }
      end

      it "creates a Log::ModelChange record" do
        expect { doit }.to change(Log::ModelChange, :count).by(1)
      end

      it "does not raise" do
        expect { doit }.not_to raise_error
      end
    end

    context "when data is invalid" do
      let(:data) do
        {
          "record_type" => "User",
          "record_id" => user.id,
          "change_type" => "create",
          "record_changes" => {},
          "changed_fields" => []
        }
      end

      it "does not raise" do
        expect { doit }.not_to raise_error
      end

      it "does not create a Log::ModelChange record" do
        expect { doit }.not_to change(Log::ModelChange, :count)
      end

      it "logs the error" do
        allow(Rails.logger).to receive(:error)
        doit
        expect(Rails.logger).to have_received(:error).with(/Error saving model change/)
      end
    end
  end
end
