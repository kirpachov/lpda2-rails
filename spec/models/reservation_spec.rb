# frozen_string_literal: true

require "rails_helper"

RSpec.describe Reservation, type: :model do
  context "validations" do
    context "datetime should be present" do
      it { is_expected.to validate_presence_of(:datetime) }
      it { is_expected.not_to allow_value(nil).for(:datetime) }
      it { is_expected.to allow_value(Time.zone.now).for(:datetime) }

      context "when datetime is nil" do
        subject { build(:reservation, datetime: nil) }

        before { subject.valid? }

        it { is_expected.not_to be_valid }
        it { expect { subject.save! }.to raise_error(ActiveRecord::RecordInvalid) }
        it { expect(subject.errors[:datetime]).not_to be_empty }
      end
    end

    context "fullname should be present" do
      it { is_expected.to validate_presence_of(:fullname) }
      it { is_expected.not_to allow_value(nil).for(:fullname) }
      it { is_expected.to allow_value(Time.zone.now).for(:fullname) }

      context "when fullname is nil" do
        subject { build(:reservation, fullname: nil) }

        before { subject.valid? }

        it { is_expected.not_to be_valid }
        it { expect { subject.save! }.to raise_error(ActiveRecord::RecordInvalid) }
        it { expect(subject.errors[:fullname]).not_to be_empty }
      end
    end

    context "secret should be present" do
      before { allow(GenToken).to receive(:for!).and_return(nil) }

      it { is_expected.to validate_presence_of(:secret) }
      it { is_expected.not_to allow_value(nil).for(:secret) }
      it { is_expected.to allow_value(Time.zone.now).for(:secret) }

      context "when secret is nil" do
        subject { build(:reservation, secret: nil) }

        before { subject.valid? }

        it { is_expected.not_to be_valid }
        it { expect { subject.save! }.to raise_error(ActiveRecord::RecordInvalid) }
        it { expect(subject.errors[:secret]).not_to be_empty }
      end
    end

    context "secret should be unique" do
      before { create(:reservation, secret: "123wassa") }

      it { is_expected.to validate_uniqueness_of(:secret).case_insensitive }
      it { is_expected.not_to allow_value("123wassa").for(:secret) }
      it { is_expected.not_to allow_value("123Wassa").for(:secret) }
    end

    context "adults should be present" do
      it { is_expected.to validate_presence_of(:adults) }
      it { is_expected.not_to allow_value(nil).for(:adults) }
      it { is_expected.to allow_value(1).for(:adults) }
      it { is_expected.not_to allow_value(-1).for(:adults) }
      it { is_expected.not_to allow_value(1.5).for(:adults) }

      context "when adults and children is nil" do
        subject { build(:reservation, adults: nil, children: nil) }

        before { subject.valid? }

        it { is_expected.not_to be_valid }
        it { expect { subject.save! }.to raise_error(ActiveRecord::RecordInvalid) }
        it { expect(subject.errors[:adults]).not_to be_empty }
        it { expect(subject.errors[:children]).not_to be_empty }
      end
    end

    context "email can be blank" do
      it { is_expected.to allow_value(nil).for(:email) }
      it { is_expected.to allow_value("").for(:email) }
      it { is_expected.to allow_value("sasha@email").for(:email) }
      it { is_expected.not_to allow_value("sasha@").for(:email) }
      it { is_expected.not_to allow_value("sasha").for(:email) }
      it { is_expected.not_to allow_value("wassa").for(:email) }
    end

    context "status should be present" do
      it { is_expected.to validate_presence_of(:status) }
      it { is_expected.not_to allow_value(nil).for(:status) }
      it { is_expected.to allow_value("active").for(:status) }
      it { is_expected.to allow_value("deleted").for(:status) }
      it { is_expected.to allow_value("cancelled").for(:status) }
      it { is_expected.to allow_value("noshow").for(:status) }

      context "when status is nil" do
        subject { build(:reservation, status: nil) }

        before { subject.valid? }

        it { is_expected.not_to be_valid }
        it { expect { subject.save! }.to raise_error(ActiveRecord::RecordInvalid) }
        it { expect(subject.errors[:status]).not_to be_empty }
      end
    end
  end

  context "associations" do
    context "can add reservation tags" do
      it do
        expect { create(:reservation).reservation_tags << create(:reservation_tag) }.not_to raise_error
      end

      context "when initially has 3 tags" do
        subject { reservation.reload }

        let!(:reservation) { create(:reservation) }
        let!(:tags) { create_list(:reservation_tag, 3) }

        before { reservation.tags = tags }

        it {
          expect { subject.reservation_tags = [create(:reservation_tag)] }.to change {
                                                                                subject.reload.tags.count
                                                                              }.from(3).to(1)
        }

        it { expect { subject.destroy! }.to change { Reservation.count }.by(-1) }
        it { expect { subject.destroy! }.to change { TagInReservation.count }.by(-3) }
        it { expect { subject.destroy! }.not_to(change { ReservationTag.count }) }

        it { expect { subject.tags = [] }.not_to(change { Reservation.count }) }
        it { expect { subject.tags = [] }.not_to(change { ReservationTag.count }) }
        it { expect { subject.tags = [] }.to change { TagInReservation.count }.by(-3) }
      end
    end
  end

  context "instance methods" do
    describe "#confirmation_email" do
      context "basic" do
        subject { reservation.confirmation_email }

        before { CreateMissingImages.run! }

        let!(:reservation) { create(:reservation) }

        it { expect { subject }.not_to raise_error }
        it { expect { subject }.not_to(change { ActionMailer::Base.deliveries.count }) }
        it { expect { subject }.to change { Log::ImagePixel.count }.by(1) }
        it { expect(subject.body.encoded).to include(Log::ImagePixel.last.url) }
      end

      context "if image does not exist" do
        subject { reservation.confirmation_email }

        before { Image.delete_all }

        let!(:reservation) { create(:reservation) }

        context "checking mock data" do
          it { expect(Image.count).to eq 0 }
        end

        it { expect { subject }.not_to raise_error }
        it { expect { subject }.not_to(change { ActionMailer::Base.deliveries.count }) }
        it { expect { subject }.not_to(change { Log::ImagePixel.count }) }
      end
    end
  end
end
