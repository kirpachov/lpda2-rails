# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Reservation, type: :model do
  context 'validations' do
    context 'datetime should be present' do
      it { should validate_presence_of(:datetime) }
      it { should_not allow_value(nil).for(:datetime) }
      it { should allow_value(Time.zone.now).for(:datetime) }

      context 'when datetime is nil' do
        subject { build(:reservation, datetime: nil) }
        before { subject.valid? }

        it { should_not be_valid }
        it { expect { subject.save! }.to raise_error(ActiveRecord::RecordInvalid) }
        it { expect(subject.errors[:datetime]).not_to be_empty }
      end
    end

    context 'fullname should be present' do
      it { should validate_presence_of(:fullname) }
      it { should_not allow_value(nil).for(:fullname) }
      it { should allow_value(Time.zone.now).for(:fullname) }

      context 'when fullname is nil' do
        subject { build(:reservation, fullname: nil) }
        before { subject.valid? }

        it { should_not be_valid }
        it { expect { subject.save! }.to raise_error(ActiveRecord::RecordInvalid) }
        it { expect(subject.errors[:fullname]).not_to be_empty }
      end
    end

    context 'secret should be present' do
      before { allow(GenToken).to receive(:for!).and_return(nil) }

      it { should validate_presence_of(:secret) }
      it { should_not allow_value(nil).for(:secret) }
      it { should allow_value(Time.zone.now).for(:secret) }

      context 'when secret is nil' do
        subject { build(:reservation, secret: nil) }
        before { subject.valid? }

        it { should_not be_valid }
        it { expect { subject.save! }.to raise_error(ActiveRecord::RecordInvalid) }
        it { expect(subject.errors[:secret]).not_to be_empty }
      end
    end

    context 'secret should be unique' do
      before { create(:reservation, secret: '123wassa') }

      it { should validate_uniqueness_of(:secret).case_insensitive }
      it { should_not allow_value('123wassa').for(:secret) }
      it { should_not allow_value('123Wassa').for(:secret) }
    end

    context 'people should be present' do
      it { should validate_presence_of(:people) }
      it { should_not allow_value(nil).for(:people) }
      it { should allow_value(1).for(:people) }
      it { should_not allow_value(0).for(:people) }
      it { should_not allow_value(-1).for(:people) }
      it { should_not allow_value(1.5).for(:people) }

      context 'when people is nil' do
        subject { build(:reservation, people: nil) }
        before { subject.valid? }

        it { should_not be_valid }
        it { expect { subject.save! }.to raise_error(ActiveRecord::RecordInvalid) }
        it { expect(subject.errors[:people]).not_to be_empty }
      end
    end

    context 'email can be blank' do
      it { should allow_value(nil).for(:email) }
      it { should allow_value('').for(:email) }
      it { should allow_value('sasha@email').for(:email) }
      it { should_not allow_value('sasha@').for(:email) }
      it { should_not allow_value('sasha').for(:email) }
      it { should_not allow_value('wassa').for(:email) }
    end

    context 'status should be present' do
      it { should validate_presence_of(:status) }
      it { should_not allow_value(nil).for(:status) }
      it { should allow_value('active').for(:status) }
      it { should allow_value('deleted').for(:status) }
      it { should allow_value('cancelled').for(:status) }
      it { should allow_value('noshow').for(:status) }

      context 'when status is nil' do
        subject { build(:reservation, status: nil) }
        before { subject.valid? }

        it { should_not be_valid }
        it { expect { subject.save! }.to raise_error(ActiveRecord::RecordInvalid) }
        it { expect(subject.errors[:status]).not_to be_empty }
      end
    end
  end
end
