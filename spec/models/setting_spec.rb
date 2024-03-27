# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Setting, type: :model do
  include_context TESTS_OPTIMIZATIONS_CONTEXT

  context 'associations' do
    it { is_expected.not_to belong_to(:user) }
  end

  context 'should have valid mocks' do
    10.times do
      it { expect(build(:setting)).to be_valid }
      it { expect { create(:setting) }.not_to raise_error }
    end
  end

  context 'validations' do
    context 'basic' do
      before { create(:setting) }

      it { is_expected.to validate_presence_of(:key) }
      it { is_expected.not_to validate_presence_of(:value) }
      it { is_expected.to validate_uniqueness_of(:key).case_insensitive }
    end

    context 'checking if key uniqueness is case insensitive' do
      subject { build(:setting, key: key.upcase) }

      let(:key) { Setting::DEFAULTS.keys.sample }

      before do
        create(:setting, key:)
      end

      it { is_expected.not_to be_valid }
      it { expect { subject.save! }.to raise_error(ActiveRecord::RecordInvalid) }

      it 'has errors on key' do
        subject.save
        expect(subject).not_to be_persisted
        expect(subject.errors[:key]).not_to be_empty
      end
    end

    context 'when key is invalid' do
      subject { build(:setting, key: :invalid_key) }

      it { is_expected.not_to be_valid }
      it { expect { subject.save! }.to raise_error(ActiveRecord::RecordInvalid) }
    end

    context 'when key is valid and value is nil' do
      subject { build(:setting, key: Setting::DEFAULTS.keys.sample) }

      it { is_expected.to be_valid }
      it { expect { subject.save! }.not_to raise_error }
    end
  end

  context 'class methods' do
    subject { Setting }

    describe '.default' do
      it { is_expected.to respond_to(:default) }

      context 'should return nil if invalid key is provided' do
        def doit
          described_class.default(:invalid_key_banana1)
        end

        it { expect(doit).to eq nil }
        it { expect { doit }.not_to raise_error }
      end

      context 'should return default value if valid key is provided' do
        def doit
          described_class.default(:default_language)
        end

        it { expect(doit).not_to be_nil }
        it { expect { doit }.not_to raise_error }
      end
    end

    describe '.all_hash' do
      before do
        Setting.destroy_all
        Setting.create(key: :default_language)
      end

      let(:all_hash) { described_class.all_hash }

      it { is_expected.to respond_to(:all_hash) }
      it { expect(all_hash).to be_a(Hash) }
      it { expect(all_hash).to be_a(HashWithIndifferentAccess) }
      it { expect(all_hash[:default_language].to_s).to eq I18n.default_locale.to_s }

      context 'when no settings exist' do
        before { Setting.destroy_all }

        it { expect(all_hash).to be_a(Hash) }
        it { expect(all_hash).to be_a(HashWithIndifferentAccess) }
        it { expect(all_hash).not_to be_empty }
      end

      context 'with specific values' do
        let(:locale_but_not_the_default_one) { (I18n.available_locales - [I18n.default_locale]).sample }

        before do
          Setting.destroy_all
          Setting.create(key: :default_language, value: locale_but_not_the_default_one)
        end

        it { expect(all_hash).to be_a(Hash) }
        it { expect(all_hash).to be_a(HashWithIndifferentAccess) }
        it { expect(all_hash[:default_language]).to eq locale_but_not_the_default_one.to_s }
      end
    end

    describe '.create_missing' do
      before do
        Setting.destroy_all
      end

      def doit
        described_class.create_missing
      end

      it { is_expected.to respond_to(:create_missing) }
      it { expect { doit }.to change { described_class.count }.by(Setting::DEFAULTS.count) }
      it { expect { doit }.not_to raise_error }

      it 'does nothing the second time its called' do
        doit
        expect { doit }.not_to(change { described_class.count })
      end
    end
  end
end
