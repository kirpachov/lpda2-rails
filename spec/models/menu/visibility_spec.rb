# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Menu::Visibility, type: :model do
  context 'should have valid factories' do
    context 'basic' do
      subject { build(:menu_visibility) }
      it { should be_valid }
      it { expect { subject.save! }.not_to raise_error }
    end

    context 'when public_visible' do
      subject { build(:menu_visibility, :public_visible) }
      it { should be_valid }
      it { expect { subject.save! }.not_to raise_error }
      it { should be_public }
      it { should_not be_private }
    end
  end

  context 'validations' do
    subject { build(:menu_visibility) }

    it { should be_valid }
    it { should allow_value(true).for(:public_visible) }
    it { should allow_value(false).for(:public_visible) }
    it { should_not allow_value(nil).for(:public_visible) }

    it { should allow_value(true).for(:private_visible) }
    it { should allow_value(false).for(:private_visible) }
    it { should_not allow_value(nil).for(:private_visible) }

    it { should allow_value(nil).for(:public_from) }
    it { should allow_value(nil).for(:public_to) }
    it { should allow_value(nil).for(:private_from) }
    it { should allow_value(nil).for(:private_to) }
  end

  context 'instance methods' do
    context 'public!' do
      it { expect(described_class.new).to respond_to(:public!) }

      context 'when initially is not public' do
        subject { create(:menu_visibility, public_visible: false) }

        it { expect { subject.public! }.not_to raise_error }
        it { expect(subject.public!).to eq true }
      end

      context 'when initially is public' do
        subject { create(:menu_visibility, public_visible: true) }

        it { expect { subject.public! }.not_to raise_error }
        it { expect(subject.public!).to eq true }
      end
    end

    context 'private!' do
      it { expect(described_class.new).to respond_to(:private!) }

      context 'when initially is not private' do
        subject { create(:menu_visibility, private_visible: false) }

        it { expect { subject.private! }.not_to raise_error }
        it { expect(subject.private!).to eq true }
      end

      context 'when initially is private' do
        subject { create(:menu_visibility, private_visible: true) }

        it { expect { subject.private! }.not_to raise_error }
        it { expect(subject.private!).to eq true }
      end
    end

    context '#public?' do
      it { expect(described_class.new).to respond_to(:public?) }

      context 'when is public' do
        subject { build(:menu_visibility, public_visible: true) }

        it { should be_public }
        it { expect(subject.public?).to be true }
        it { expect { subject.public? }.not_to raise_error }
      end

      context 'when is not public' do
        subject { build(:menu_visibility, public_visible: false) }

        it { should_not be_public }
        it { expect(subject.public?).to be false }
        it { expect { subject.public? }.not_to raise_error }
      end
    end

    context '#private?' do
      it { expect(described_class.new).to respond_to(:private?) }

      context 'when is private' do
        subject { build(:menu_visibility, private_visible: true) }

        it { should be_private }
        it { expect(subject.private?).to be true }
        it { expect { subject.private? }.not_to raise_error }
      end

      context 'when is not private' do
        subject { build(:menu_visibility, private_visible: false) }

        it { should_not be_private }
        it { expect(subject.private?).to be false }
        it { expect { subject.private? }.not_to raise_error }
      end
    end
  end
end
