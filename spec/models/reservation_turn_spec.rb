# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ReservationTurn, type: :model do
  context 'has valid factories' do
    it { expect(build(:reservation_turn)).to be_valid }
    it { expect { create(:reservation_turn) }.to change { ReservationTurn.count }.by(1) }
  end

  context 'validations' do
    before { create(:reservation_turn) }

    context 'starts_at should be present' do
      it { is_expected.to validate_presence_of(:starts_at) }
      it { is_expected.not_to allow_value(nil).for(:starts_at) }
      it { is_expected.to allow_value(Time.zone.now).for(:starts_at) }

      context 'when starts_at is nil' do
        subject { build(:reservation_turn, starts_at: nil) }

        before { subject.valid? }

        it { is_expected.not_to be_valid }
        it { expect { subject.save! }.to raise_error(ActiveRecord::RecordInvalid) }
        it { expect(subject.errors[:starts_at]).not_to be_empty }
      end
    end

    context 'ends_at should be present' do
      it { is_expected.to validate_presence_of(:ends_at) }
      it { is_expected.not_to allow_value(nil).for(:ends_at) }
      it { is_expected.to allow_value(Time.zone.now).for(:ends_at) }

      context 'when ends_at is nil' do
        subject { build(:reservation_turn, ends_at: nil) }

        before { subject.valid? }

        it { is_expected.not_to be_valid }
        it { expect { subject.save! }.to raise_error(ActiveRecord::RecordInvalid) }
        it { expect(subject.errors[:ends_at]).not_to be_empty }
      end
    end

    context 'starts_at should be before ends_at' do
      subject { build(:reservation_turn, starts_at: Time.zone.now, ends_at: Time.zone.now - 1.hour) }

      before { subject.valid? }

      it { is_expected.not_to be_valid }
      it { expect { subject.save! }.to raise_error(ActiveRecord::RecordInvalid) }
      it { expect(subject.errors[:starts_at]).not_to be_empty }
      it { expect(subject.errors[:ends_at]).not_to be_empty }
    end

    context 'should not overlap with other reservation turns' do
      subject { new_turn }

      let!(:turn) { create(:reservation_turn, starts_at: '10:00', ends_at: '12:00') }
      let(:new_turn) { build(:reservation_turn, weekday: turn.weekday, starts_at: '11:00', ends_at: '13:00') }

      before { new_turn.valid? }

      it { is_expected.not_to be_valid }
      it { expect { subject.save! }.to raise_error(ActiveRecord::RecordInvalid) }
      it { expect(subject.errors[:starts_at]).not_to be_empty }
    end

    context 'a turn cannot start exactly when another one ends' do
      subject { new_turn }

      let!(:turn) { create(:reservation_turn, starts_at: '10:00', ends_at: '11:00') }
      let(:new_turn) { build(:reservation_turn, weekday: turn.weekday, starts_at: '11:00', ends_at: '12:00') }

      before { new_turn.valid? }

      it { is_expected.not_to be_valid }
      it { expect { subject.save! }.to raise_error(ActiveRecord::RecordInvalid) }
      it { expect(subject.errors[:starts_at]).not_to be_empty }
    end

    context 'a turn cannot end exactly when another one starts' do
      subject { new_turn }

      let!(:turn) { create(:reservation_turn, starts_at: '10:00', ends_at: '11:00') }
      let(:new_turn) { build(:reservation_turn, weekday: turn.weekday, starts_at: '9:00', ends_at: '10:00') }

      before { new_turn.valid? }

      it { is_expected.not_to be_valid }
      it { expect { subject.save! }.to raise_error(ActiveRecord::RecordInvalid) }
      it { expect(subject.errors[:ends_at]).not_to be_empty }
    end

    context 'a turn can start one minute after one ends' do
      subject { new_turn }

      let!(:turn) { create(:reservation_turn, starts_at: '10:00', ends_at: '11:00') }
      let(:new_turn) { build(:reservation_turn, starts_at: '11:01', ends_at: '12:01') }

      before { new_turn.valid? }

      it { is_expected.to be_valid }
      it { expect { subject.save! }.not_to raise_error }
    end

    context 'can have multiple turns on same day if they do not overlap' do
      subject { new_turn }

      let(:turn) { create(:reservation_turn) }
      let(:new_turn) { build(:reservation_turn, starts_at: turn.ends_at + 1.hour, ends_at: turn.ends_at + 2.hours) }

      before { new_turn.valid? }

      it { is_expected.to be_valid }
      it { expect { subject.save! }.not_to raise_error }
    end

    context 'can have multiple turns on different days' do
      subject { new_turn }

      let!(:turn) { create(:reservation_turn, weekday: 0, starts_at: '10:00', ends_at: '11:00') }
      let(:new_turn) { build(:reservation_turn, starts_at: turn.starts_at, ends_at: turn.ends_at, weekday: 1) }

      before { new_turn.valid? }

      it { is_expected.to be_valid }
      it { expect { subject.save! }.not_to raise_error }
    end

    context 'cannot have a turn with same name on same day' do
      subject { new_turn }

      let!(:turn) { create(:reservation_turn, weekday: 0, name: 'Bratan', starts_at: '10:00', ends_at: '11:00') }
      let(:new_turn) { build(:reservation_turn, weekday: 0, name: 'Bratan', starts_at: '12:00', ends_at: '13:00') }

      before { new_turn.valid? }

      it { expect(new_turn.name).to eq turn.name }
      it { expect(new_turn.weekday).to eq turn.weekday }

      it { is_expected.not_to be_valid }
      it { expect { subject.save! }.to raise_error(ActiveRecord::RecordInvalid) }
    end

    context 'cannot have a turn with same name on same day, case insensitive' do
      subject { new_turn }

      let!(:turn) { create(:reservation_turn, weekday: 0, name: 'BratAn', starts_at: '10:00', ends_at: '11:00') }
      let(:new_turn) { build(:reservation_turn, weekday: 0, name: 'Bratan', starts_at: '12:00', ends_at: '13:00') }

      before { new_turn.valid? }

      it { expect(new_turn.name.downcase).to eq turn.name.downcase }
      it { expect(new_turn.weekday).to eq turn.weekday }

      it { is_expected.not_to be_valid }
      it { expect { subject.save! }.to raise_error(ActiveRecord::RecordInvalid) }
    end
  end
end
