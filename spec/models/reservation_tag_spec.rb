# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ReservationTag, type: :model do
  context 'validations' do
    context 'title should be present' do
      it { should validate_presence_of(:title) }
      it { should_not allow_value(nil).for(:title) }
      it { should allow_value(Time.zone.now).for(:title) }

      context 'when title is nil' do
        subject { build(:reservation_tag, title: nil) }
        before { subject.valid? }

        it { should_not be_valid }
        it { expect { subject.save! }.to raise_error(ActiveRecord::RecordInvalid) }
        it { expect(subject.errors[:title]).not_to be_empty }
      end
    end

    context 'title should be unique' do
      let(:title) { Faker::Lorem.sentence }
      let!(:old) { create(:reservation_tag, title:) }
      let(:new) { build(:reservation_tag, title:) }
      before{ new.validate }
      subject{ new }

      it { should_not be_valid }
      it { expect(subject.errors[:title]).not_to be_empty }
    end

    context 'bg_color should be present' do
      it { should validate_presence_of(:bg_color) }
      it { should_not allow_value(nil).for(:bg_color) }
      it { should allow_value('#000').for(:bg_color) }
      it { should allow_value('#FFFFFF').for(:bg_color) }

      context 'when bg_color is nil' do
        subject { build(:reservation_tag, bg_color: nil) }
        before { subject.valid? }

        it { should_not be_valid }
        it { expect { subject.save! }.to raise_error(ActiveRecord::RecordInvalid) }
        it { expect(subject.errors[:bg_color]).not_to be_empty }
      end
    end

    context 'color should be present' do
      it { should validate_presence_of(:color) }
      it { should_not allow_value(nil).for(:color) }
      it { should allow_value('#000').for(:color) }
      it { should allow_value('#FFFFFF').for(:color) }

      context 'when color is nil' do
        subject { build(:reservation_tag, color: nil) }
        before { subject.valid? }

        it { should_not be_valid }
        it { expect { subject.save! }.to raise_error(ActiveRecord::RecordInvalid) }
        it { expect(subject.errors[:color]).not_to be_empty }
      end
    end
  end
end
