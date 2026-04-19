# frozen_string_literal: true

require "rails_helper"

RSpec.describe RemindReservationPayments, type: :interaction do
  include_context TESTS_OPTIMIZATIONS_CONTEXT

  before do
    CreateMissingImages.run!
  end

  let(:inputs) { {} }

  let(:run) { Sidekiq::Testing.inline! { described_class.run(inputs) } }
  let(:run!) { Sidekiq::Testing.inline! { described_class.run!(inputs) } }

  let(:reservations) do
    travel_to 1.month.ago do
      create(:reservation, :with_fullname, status: :active)
      create(:reservation, :with_fullname, status: :cancelled)
      create(:reservation, :with_fullname, status: :arrived)
      create(:reservation, :with_fullname, status: :deleted)
      create(:reservation, :with_fullname, status: :noshow)
    end

    travel_to 1.week.ago do
      create(:reservation, :with_fullname, status: :active)
      create(:reservation, :with_fullname, status: :cancelled)
      create(:reservation, :with_fullname, status: :arrived)
      create(:reservation, :with_fullname, status: :deleted)
      create(:reservation, :with_fullname, status: :noshow)
    end

    travel_to 2.days.ago do
      create(:reservation, :with_fullname, status: :active)
      create(:reservation, :with_fullname, status: :cancelled)
      create(:reservation, :with_fullname, status: :arrived)
      create(:reservation, :with_fullname, status: :deleted)
      create(:reservation, :with_fullname, status: :noshow)
    end

    Reservation.all
  end

  let(:payments) do
    reservations
    travel_to 2.days.ago do
      reservations.sample(3).each do |reservation|
        create(:reservation_payment, reservation:)
      end

      Reservation.active.where.not(id: ReservationPayment.pluck(:reservation_id)).sample(2).each do |reservation|
        create(:reservation_payment, reservation:)
      end
    end

    ReservationPayment.all
  end

  context "when there are no reservations, does nothing." do
    it { expect { run! }.not_to raise_error }
    it { expect { run! }.not_to(change { ActionMailer::Base.deliveries.count }) }
    it { expect { run! }.not_to(have_enqueued_job(ActionMailer::MailDeliveryJob)) }
  end

  context "when there are reservations but not ReservationPayment associated: does nothing." do
    before { reservations }

    it { expect(Reservation.count).to be_positive }
    it { expect(Reservation.visible.count).to be_positive }
    it { expect(Reservation.active.count).to be_positive }

    it { expect { run! }.not_to raise_error }
    it { expect { run! }.not_to(change { ActionMailer::Base.deliveries.count }) }
    it { expect { run! }.not_to(have_enqueued_job(ActionMailer::MailDeliveryJob)) }
  end

  context "when there are reservations but some are not active, other are already paid: should do nothing." do
    before do
      reservations
      payments

      travel_to 1.day.ago do
        payments.each(&:paid!)
        create(:reservation_payment, reservation: create(:reservation, :with_fullname, status: :deleted))
        create(:reservation_payment, reservation: create(:reservation, :with_fullname, status: :cancelled))
      end

      # Not eligible because too soon.
      create(:reservation_payment, reservation: create(:reservation, :with_fullname, status: :active))
    end

    it { expect(Reservation.count).to be_positive }
    it { expect(Reservation.visible.count).to be_positive }
    it { expect(Reservation.active.count).to be_positive }
    it { expect(Reservation.deleted.count).to be_positive }

    it { expect(ReservationPayment.count).to be_positive }
    it { expect(ReservationPayment.todo.count).to eq(3) }
    it { expect(ReservationPayment.paid.count).to be_positive }

    it { expect { run! }.not_to raise_error }
    it { expect { run! }.not_to(change { ActionMailer::Base.deliveries.count }) }
    it { expect { run! }.not_to(have_enqueued_job(ActionMailer::MailDeliveryJob)) }
    it { expect { run! }.not_to(change { ActionMailer::Base.deliveries.count }) }
    it { expect { run! }.not_to(change { ReservationPayment.all.order(:id).as_json }) }
    it { expect { run! }.not_to(change { Reservation.all.order(:id).as_json }) }
  end

  context "when there are reservations and some are active but not paid: should send reminder." do
    before do
      reservations
      payments
    end

    it { expect(Reservation.count).to be_positive }
    it { expect(Reservation.visible.count).to be_positive }
    it { expect(Reservation.active.count).to be_positive }

    it { expect(ReservationPayment.count).to be_positive }
    it { expect(ReservationPayment.todo.count).to be_positive }

    it { expect { run! }.not_to raise_error }
    # it { expect { run! }.to have_enqueued_job(ActionMailer::MailDeliveryJob).at_least(1).times }
    it { expect { run! }.to change { ActionMailer::Base.deliveries.count }.by_at_least(1) }
  end

  context "when created a payment a week ago, should not send reminder." do
    let(:reservations) do
      travel_to 1.week.ago do
        create(:reservation, :with_fullname, status: :active)
      end

      Reservation.all
    end

    let(:payments) do
      travel_to 1.week.ago do
        create(:reservation_payment, reservation: reservations.first)
      end

      ReservationPayment.all
    end

    before do
      reservations
      payments
    end

    it { expect(Reservation.count).to be_positive }
    it { expect(Reservation.visible.count).to be_positive }

    it { expect(ReservationPayment.count).to be_positive }

    it { expect { run! }.not_to raise_error }
    it { expect { run! }.not_to(change { ActionMailer::Base.deliveries.count }) }
    it { expect { run! }.not_to(have_enqueued_job(ActionMailer::MailDeliveryJob)) }
  end

  context "when created a payment 2 days ago but email is blank, should NOT send reminder." do
    before do
      travel_to 2.days.ago do
        create(:reservation_payment, reservation: create(:reservation, :with_fullname, status: :active, email: nil))
      end
    end

    it { expect { run! }.not_to raise_error }
    it { expect { run! }.not_to(have_enqueued_job(ActionMailer::MailDeliveryJob)) }
  end

  context "when created a payment 2 days ago, should send reminder." do
    let(:reservations) do
      travel_to 2.days.ago do
        create(:reservation, :with_fullname, status: :active)
      end

      Reservation.all
    end

    let(:payments) do
      travel_to 2.days.ago do
        create(:reservation_payment, reservation: reservations.first)
      end

      ReservationPayment.all
    end

    before do
      reservations
      payments
    end

    it { expect { run! }.not_to raise_error }
    it { expect { run! }.to(change { ActionMailer::Base.deliveries.count }.by(1)) }
  end

  context "when some reservatio is for 12 november 2024 H13:00 and now it's 14 november 2024 H11:00" do
    before do
      # reservations
      travel_to DateTime.parse("2024-11-12 10:00") do
        create(:reservation, status: :active, email: Faker::Internet.email,
                             datetime: DateTime.parse("2024-11-12 13:00")).tap do |res|
          create(:reservation_payment, reservation: res)
        end
      end
    end

    it { expect(Reservation.count).to eq 1 }
    it { expect(Reservation.active.count).to eq 1 }
    it { expect(ReservationPayment.count).to eq 1 }
    it { expect(ReservationPayment.todo.count).to eq 1 }

    it do
      travel_to DateTime.parse("2024-11-14 11:00") do
        expect { run! }.not_to(have_enqueued_job(ActionMailer::MailDeliveryJob))
      end
    end

    it do
      travel_to DateTime.parse("2024-11-14 11:00") do
        expect { run! }.not_to(change { ActionMailer::Base.deliveries.count })
      end
    end
  end
end
