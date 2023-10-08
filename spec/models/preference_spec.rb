# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Preference, type: :model do
  context 'associations' do
    it { should belong_to(:user).inverse_of(:preferences).required }
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
