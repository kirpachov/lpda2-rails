# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Preference, type: :model do
  include_context TESTS_OPTIMIZATIONS_CONTEXT

  context 'associations' do
    it { should belong_to(:user).inverse_of(:preferences).required }
  end

  let(:user) do
    (u = create(:user)).preferences.destroy_all
    u
  end

  context 'should have valid mocks' do
    10.times do
      it { expect(build(:preference, user: user)).to be_valid }
      it { expect { create(:preference, user: user) }.not_to raise_error }
    end
  end

  context 'validations' do
    before { create(:user) }

    it { should validate_presence_of(:key) }
    it { should_not validate_presence_of(:value) }
    it { should validate_uniqueness_of(:key).scoped_to(:user_id).case_insensitive  }

    context 'checking if key uniqueness is case insensitive' do
      let(:key) { Preference::DEFAULTS.keys.sample }

      before do
        create(:preference, key: key, user: user)
      end

      subject { build(:preference, key: key.upcase, user: user) }

      it { should_not be_valid }
      it { expect { subject.save! }.to raise_error(ActiveRecord::RecordInvalid) }
      it 'should have errors on key' do
        subject.save
        expect(subject).not_to be_persisted
        expect(subject.errors[:key]).not_to be_empty
      end
    end

    context 'when key is invalid' do
      subject { build(:preference, key: :invalid_key, user: user) }

      it { should_not be_valid }
      it { expect { subject.save! }.to raise_error(ActiveRecord::RecordInvalid) }
    end

    context 'when key is valid and value is nil' do
      subject { build(:preference, key: Preference::DEFAULTS.keys.sample, user: user) }

      it { should be_valid }
      it { expect { subject.save! }.not_to raise_error }
    end
  end

  context 'class methods' do
    subject { Preference }

    context '.create_missing_for' do
      it { should respond_to(:create_missing_for) }

      context 'should create missing preferences for user' do
        let(:user) { create(:user) }

        def doit
          described_class.create_missing_for(user)
        end

        context 'when no preferences exist' do
          before { user.preferences.destroy_all }

          it { expect { doit }.to change { described_class.count }.by(Preference::DEFAULTS.count) }
          it { expect { doit }.not_to raise_error }
        end

        context 'when some preferences exist' do
          before do
            user.preferences.where(id: user.preferences.pluck(:id).sample(Preference::DEFAULTS.count - 1)).destroy_all
          end

          context 'checking mock data' do
            it 'should have 1 preference' do
              expect(user.preferences.count).to eq 1
            end
          end

          it { expect { doit }.to change { described_class.count }.by(Preference::DEFAULTS.count - 1) }
          it { expect { doit }.not_to raise_error }
        end
      end
    end

    context '.default' do
      it { should respond_to(:default) }

      context 'should return nil if invalid key is provided' do
        def doit
          described_class.default(:invalid_key_banana1)
        end

        it { expect(doit).to eq nil }
        it { expect { doit }.not_to raise_error }
      end

      context 'should return default value if valid key is provided' do
        def doit
          described_class.default(:language)
        end

        it { expect(doit).not_to be_nil }
        it { expect { doit }.not_to raise_error }
      end
    end
  end
end
