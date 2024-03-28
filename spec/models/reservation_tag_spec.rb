# frozen_string_literal: true

require "rails_helper"

RSpec.describe ReservationTag, type: :model do
  context "validations" do
    context "title should be present" do
      it { is_expected.to validate_presence_of(:title) }
      it { is_expected.not_to allow_value(nil).for(:title) }
      it { is_expected.to allow_value(Time.zone.now).for(:title) }

      context "when title is nil" do
        subject { build(:reservation_tag, title: nil) }

        before { subject.valid? }

        it { is_expected.not_to be_valid }
        it { expect { subject.save! }.to raise_error(ActiveRecord::RecordInvalid) }
        it { expect(subject.errors[:title]).not_to be_empty }
      end
    end

    context "title should be unique" do
      subject { new }

      let(:title) { Faker::Lorem.sentence }
      let!(:old) { create(:reservation_tag, title:) }
      let(:new) { build(:reservation_tag, title:) }

      before { new.validate }

      it { is_expected.not_to be_valid }
      it { expect(subject.errors[:title]).not_to be_empty }
    end

    context "bg_color should be present" do
      it { is_expected.to validate_presence_of(:bg_color) }
      it { is_expected.not_to allow_value(nil).for(:bg_color) }
      it { is_expected.to allow_value("#000").for(:bg_color) }
      it { is_expected.to allow_value("#FFFFFF").for(:bg_color) }

      context "when bg_color is nil" do
        subject { build(:reservation_tag, bg_color: nil) }

        before { subject.valid? }

        it { is_expected.not_to be_valid }
        it { expect { subject.save! }.to raise_error(ActiveRecord::RecordInvalid) }
        it { expect(subject.errors[:bg_color]).not_to be_empty }
      end
    end

    context "color should be present" do
      it { is_expected.to validate_presence_of(:color) }
      it { is_expected.not_to allow_value(nil).for(:color) }
      it { is_expected.to allow_value("#000").for(:color) }
      it { is_expected.to allow_value("#FFFFFF").for(:color) }

      context "when color is nil" do
        subject { build(:reservation_tag, color: nil) }

        before { subject.valid? }

        it { is_expected.not_to be_valid }
        it { expect { subject.save! }.to raise_error(ActiveRecord::RecordInvalid) }
        it { expect(subject.errors[:color]).not_to be_empty }
      end
    end
  end

  context "may have reservations" do
    subject { tag }

    let!(:tag) { create(:reservation_tag) }
    let!(:reservations) { create_list(:reservation, 3) }

    it { expect { tag.reservations << reservations.sample }.not_to raise_error }
    it { expect { tag.reservations << reservations.sample }.not_to(change { ReservationTag.count }) }
    it { expect { tag.reservations << reservations.sample }.to change { TagInReservation.count }.by(1) }
    it { expect { tag.reservations << reservations.sample }.to change { tag.reload.reservations.count }.from(0).to(1) }

    context "when tag has 3 reservations" do
      before { tag.reservations = reservations }

      it { expect { tag.destroy! }.not_to(change { Reservation.count }) }
      it { expect { tag.destroy! }.to change { ReservationTag.count }.by(-1) }
      it { expect { tag.destroy! }.to change { TagInReservation.count }.by(-3) }

      it { expect { tag.reservations.sample.destroy! }.to change { TagInReservation.count }.by(-1) }
      it { expect { tag.reservations.sample.destroy! }.not_to(change { ReservationTag.count }) }
      it { expect { tag.reservations.sample.destroy! }.to change { Reservation.count }.by(-1) }
    end
  end
end
