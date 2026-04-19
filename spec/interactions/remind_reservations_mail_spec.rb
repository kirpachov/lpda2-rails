# frozen_string_literal: true

require "rails_helper"

RSpec.describe RemindReservationsMail do
  let(:elegible) { described_class.new.elegible }

  before { CreateMissingImages.run! }

  context "basic scenario" do
    let!(:reservations) do
      [
        create(:reservation, datetime: 1.hour.from_now),
        create(:reservation, datetime: 1.day.from_now),

        create(:reservation, datetime: 1.hour.ago),
        create(:reservation, datetime: 1.day.ago),
        create(:reservation, datetime: 1.week.ago),

        create(:reservation, datetime: 1.week.from_now),
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
      expect(elegible.length).to eq(2)
      expect(elegible.map(&:id)).to match_array(reservations[0..1].map(&:id))
    end

    context "when actually calling mailer", :perform_enqueued_jobs do
      # around do |example|
      #   ActiveJob::Base.queue_adapter.perform_enqueued_jobs = true
      #   example.run
      #   ActiveJob::Base.queue_adapter.perform_enqueued_jobs = false
      # end

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
        it { expect(described_class.new.elegible).to be_empty }
      end

      context "won't send email even after an hour" do
        before do
          travel_to 59.minutes.from_now do
            described_class.run!
          end
        end

        it { expect { described_class.run! }.not_to have_enqueued_job(ActionMailer::MailDeliveryJob) }
        it { expect { described_class.run! }.not_to(change { Log::DeliveredEmail.count }) }
        it { expect { described_class.run! }.not_to(change { ActionMailer::Base.deliveries.count }) }
        it { expect(described_class.new.elegible).to be_empty }
      end
    end
  end

  %w[
    arrived
    deleted
    noshow
    cancelled
  ].each do |status|
    context "when reservation has status #{status.inspect}, won't send email. only active reservations." do
      before { create(:reservation, status:, datetime: 2.hours.from_now) }

      it do
        expect { described_class.run! }.not_to raise_error
      end

      it do
        expect(elegible).to be_empty
      end
    end
  end

  context "when reservation has required payment not paid: won't send email." do
    let!(:reservation) { create(:reservation, datetime: 1.hour.from_now) }
    let!(:reservation_payment) { create(:reservation_payment, reservation:, status: :todo) }

    it do
      expect { described_class.run! }.not_to raise_error
    end

    it do
      expect { described_class.run! }.not_to(change { ActionMailer::Base.deliveries.count })
    end

    it do
      expect(elegible).to be_empty
    end
  end

  context "when reservation has paid payment: will send email." do
    let!(:reservation) { create(:reservation, datetime: 1.hour.from_now) }
    let!(:reservation_payment) { create(:reservation_payment, reservation:, status: :paid) }

    it do
      expect { described_class.run! }.not_to raise_error
    end

    it do
      expect { described_class.run! }.to change { ActionMailer::Base.deliveries.count }.by(1)
    end

    it do
      expect(elegible.map(&:id)).to contain_exactly(reservation.id)
    end
  end
end
