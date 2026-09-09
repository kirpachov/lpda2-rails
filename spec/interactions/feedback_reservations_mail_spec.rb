# frozen_string_literal: true

require "rails_helper"

RSpec.describe FeedbackReservationsMail do
  let(:eligible) { described_class.new.eligible }

  before { CreateMissingImages.run! }

  context "basic scenario" do
    let!(:reservations) do
      [
        create(:reservation, datetime: 1.day.ago),
        create(:reservation, datetime: 20.hours.ago),

        create(:reservation, datetime: 1.hour.ago),
        create(:reservation, datetime: 2.days.ago),
        create(:reservation, datetime: 1.week.ago),

        create(:reservation, datetime: 1.day.from_now),
        create(:reservation, datetime: 2.days.from_now)
      ]
    end

    it do
      expect { described_class.run! }.not_to raise_error
    end

    it do
      expect { described_class.run! }.to change { ActionMailer::Base.deliveries.count }.by(2)
    end

    it do
      expect(eligible.length).to eq(2)
      expect(eligible.map(&:id)).to match_array(reservations[0..1].map(&:id))
    end

    context "when actually calling mailer", :perform_enqueued_jobs do
      before { CreateMissingImages.run! }

      it { expect { described_class.run! }.to change { ActionMailer::Base.deliveries.count }.by(2) }
      it { expect { described_class.run! }.to change { Log::DeliveredEmail.count }.by(2) }

      [nil, "", " "].each do |blank_email|
        context "when a reservation does not have email (email = #{blank_email.inspect}), won't send email for that reservation." do
          before do
            reservations[0].update!(email: blank_email)
          end

          it { expect { described_class.run! }.to change { ActionMailer::Base.deliveries.count }.by(1) }
          it { expect { described_class.run! }.to change { Log::DeliveredEmail.count }.by(1) }
        end
      end

      context "won't send email if already sent" do
        before { described_class.run! }

        it { expect { described_class.run! }.not_to have_enqueued_job(ActionMailer::MailDeliveryJob) }
        it { expect { described_class.run! }.not_to(change { Log::DeliveredEmail.count }) }
        it { expect { described_class.run! }.not_to(change { ActionMailer::Base.deliveries.count }) }
        it { expect(described_class.new.eligible).to be_empty }
      end
    end
  end

  %w[
    deleted
    noshow
    cancelled
  ].each do |status|
    context "when reservation has status #{status.inspect}, won't send email. only active/arrived reservations." do
      before { create(:reservation, status:, datetime: 1.day.ago) }

      it do
        expect { described_class.run! }.not_to raise_error
      end

      it do
        expect(eligible).to be_empty
      end
    end
  end

  context "when reservation has status arrived, will send email." do
    let!(:reservation) { create(:reservation, status: "arrived", datetime: 1.day.ago) }

    it do
      expect(eligible.map(&:id)).to contain_exactly(reservation.id)
    end
  end

  context "when one reservation fails to be delivered, other reservations are still processed" do
    let!(:reservations) do
      [
        create(:reservation, datetime: 1.day.ago),
        create(:reservation, datetime: 1.day.ago)
      ]
    end

    before do
      allow(ReservationMailer).to receive(:with).and_call_original
      allow(ReservationMailer).to receive(:with)
        .with(reservation_id: reservations[0].id).and_raise(StandardError, "boom")
    end

    it { expect { described_class.run }.not_to raise_error }

    it do
      expect { described_class.run }.to change { ActionMailer::Base.deliveries.count }.by(1)
    end

    it "raises when using #run! since the interaction ends up invalid" do
      expect { described_class.run! }.to raise_error(ActiveInteraction::InvalidInteractionError)
    end

    it "logs the error" do
      expected_error = "Failed to send feedback email for reservation ##{reservations[0].id}"
      expect(Rails.logger).to receive(:error).with(/#{expected_error}/)
      described_class.run
    end
  end
end
