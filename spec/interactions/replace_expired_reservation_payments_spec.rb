# frozen_string_literal: true

require "rails_helper"

RSpec.shared_examples "when successful run ReplaceExpiredReservationPayments interaction" do
  it { expect(call).to be_valid }
  # it { expect { call }.to(change(Log::StripeEvent, :count)) }
  it { expect { call }.not_to(change(ReservationPayment, :count)) }
  it { expect { call }.not_to(change(Reservation, :count)) }
end

RSpec.shared_examples "when failed run ReplaceExpiredReservationPayments interaction" do
  it { expect(call).not_to be_valid }
  it { expect(call.errors).not_to be_empty }
  it { expect { call }.not_to(change { ReservationPayment.all.as_json }) }
  it { expect { call }.not_to(change { Reservation.all.as_json }) }
end

RSpec.describe ReplaceExpiredReservationPayments, type: :interaction do
  let(:run) do
    described_class.run(run_params)
  end

  let(:run!) do
    described_class.run!(run_params)
  end

  let(:run_params) { {} }

  before { stub_stripe_backend }

  context "when checking that reservation payment is replaced" do
    let!(:reservation) { create(:reservation, datetime: 1.day.from_now, status: :active) }
    let!(:payment) { create(:reservation_payment, :stripe_authorization, reservation:, status: :expired) }

    it { expect { run! }.not_to(change { ReservationPayment.count }.from(1)) }
    it { expect { run! }.to(change { ReservationPayment.all.pluck(:status) }.from(["expired"]).to(["todo"])) }

    it do
      allow(ReplaceReservationPayment).to receive(:run!).and_call_original

      expect(run).to be_valid
      expect(reservation.payment.reload.status).to eq("todo")

      expect(ReplaceReservationPayment).to have_received(:run!).once
    end
  end

  context "when checking reservations selection" do
    before do
      # active arrived deleted noshow cancelled
      # todo expired authorized paid refunded

      # Should find only: visible, in future, and expired payments.
      create(:reservation, datetime: 1.day.from_now, fullname: "attesa-expired1", status: :active).tap do |j|
        create(:reservation_payment, reservation: j, status: :expired)
      end

      create(:reservation, datetime: 1.month.from_now, fullname: "attesa-expired2", status: :active).tap do |j|
        create(:reservation_payment, reservation: j, status: :expired)
      end

      create(:reservation, datetime: 1.month.from_now, fullname: "arrivato-expired1", status: :arrived).tap do |j|
        create(:reservation_payment, reservation: j, status: :expired)
      end

      create(:reservation, datetime: 1.month.from_now, fullname: "arrivato-expired2", status: :arrived).tap do |j|
        create(:reservation_payment, reservation: j, status: :expired)
      end

      # Noise: Reservation has stauts deleted / noshow / cancelled, with any payment status.
      %i[deleted noshow cancelled].each do |reservation_status|
        %i[todo expired authorized paid refunded].each do |payment_status|
          [1.day.from_now, 1.day.ago, 1.month.from_now, 1.month.ago].each do |datetime|
            create(:reservation, datetime:,
                                 fullname: "invisible-#{reservation_status}-#{payment_status}-#{SecureRandom.hex}", status: reservation_status).tap do |j|
              create(:reservation_payment, reservation: j, status: payment_status)
            end
          end
        end
      end

      # Noise: not in the future
      %i[active arrived deleted noshow cancelled].each do |reservation_status|
        %i[todo expired authorized paid refunded].each do |payment_status|
          [1.day.ago, 1.month.ago, 1.hour.ago].each do |datetime|
            create(:reservation, datetime:, fullname: "invisible-cuz-date-#{datetime.inspect}-#{SecureRandom.hex}",
                                 status: reservation_status).tap do |j|
              create(:reservation_payment, reservation: j, status: payment_status)
            end
          end
        end
      end

      # Noise: not expired
      %i[active arrived deleted noshow cancelled].each do |reservation_status|
        %i[todo authorized paid refunded].each do |payment_status|
          [1.day.from_now, 1.month.from_now, 1.hour.from_now].each do |datetime|
            create(:reservation, datetime:, fullname: "invisible-cuz-not-expired-#{SecureRandom.hex}",
                                 status: reservation_status).tap do |j|
              create(:reservation_payment, reservation: j, status: payment_status)
            end
          end
        end
      end

      # Noise: any status, without payment.
      %i[active arrived deleted noshow cancelled].each do |reservation_status|
        [1.day.from_now, 1.month.from_now, 1.hour.from_now, 1.day.ago, 1.month.ago].each do |datetime|
          create(:reservation, datetime:, fullname: "invisible-cuz-not-expired-#{SecureRandom.hex}",
                               status: reservation_status)
        end
      end
    end

    let(:elegible_reservations) { described_class.new.reservations }

    it do
      expect(elegible_reservations.pluck(:fullname)).to(match_array(%w[attesa-expired1 attesa-expired2
                                                                       arrivato-expired1 arrivato-expired2]))
    end
  end
end
