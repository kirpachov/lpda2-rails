# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  include_context TESTS_OPTIMIZATIONS_CONTEXT

  def valid_statuses
    %w[active deleted]
  end

  context 'validations' do
    before { allow_any_instance_of(User).to receive(:assign_defaults).and_return(true) }
    before { create(:user) }

    it { should validate_presence_of(:email) }
    it { should have_db_index(:email).unique(true) }
    it { should validate_uniqueness_of(:email).case_insensitive }

    it { should_not validate_presence_of(:fullname) }

    it { should_not validate_presence_of(:username) }
    it { should validate_uniqueness_of(:username).case_insensitive }

    it { should have_secure_password }

    # Should have :root_at column
    it { should have_db_column(:root_at).of_type(:datetime) }
    it { should have_db_column(:locked_at).of_type(:datetime) }
    it { should have_db_column(:status).of_type(:text) }

    it { should validate_presence_of(:status) }
    it { should validate_inclusion_of(:status).in_array(valid_statuses) }
    it { expect(described_class.defined_enums.keys).to include('status') }
  end

  context 'instance methods' do
    let(:instance) { described_class.new }

    context '#temporarily_block!' do
      let(:user) { create(:user) }
      subject { user }

      it { should respond_to(:temporarily_block!) }
      it { should be_valid }
      it { should be_persisted }
      it { expect { user.temporarily_block! }.to change(user, :locked_at) }

      context 'after call' do
        before { user.temporarily_block! }

        it { expect { user.temporarily_block! }.not_to raise_error }
        it { should be_a(User) }
        it { expect(user.locked_at.to_i).to eq user.reload.locked_at.to_i }
        it { expect(subject.changes).to be_empty }
      end
    end

    context '#temporarily_blocked?' do
      context 'when locked_at is nil' do
        subject { build(:user, locked_at: nil) }
        it { should be_valid }
        it { expect(subject.temporarily_blocked?).to be false }
        it { expect(subject).not_to be_temporarily_blocked }
      end

      context 'when locked_at is in the past' do
        subject { build(:user, locked_at: 1.year.ago) }
        it { should be_valid }
        it { expect(subject.temporarily_blocked?).to be false }
        it { expect(subject).not_to be_temporarily_blocked }
      end

      context 'when locked_at is in the future' do
        subject { build(:user, locked_at: 1.year.from_now) }
        it { should be_valid }
        it { expect(subject.temporarily_blocked?).to be true }
        it { expect(subject).to be_temporarily_blocked }
      end

      context 'when locked_at is now' do
        subject { build(:user, locked_at: Time.now) }
        it { should be_valid }
        it { expect(subject.temporarily_blocked?).to be true }
        it { expect(subject).to be_temporarily_blocked }
      end
    end

    context '#generate_refresh_token' do
      it { expect(instance).to respond_to(:generate_refresh_token) }

      context 'on existing user' do
        let(:user) { create(:user) }
        subject { user }

        it { expect { user.generate_refresh_token }.not_to raise_error }
        it { expect { user.generate_refresh_token }.to change(RefreshToken, :count).by(1) }

        context 'when called' do
          subject { user.generate_refresh_token }

          it { should be_a RefreshToken }
          it { should be_persisted }
          it { should be_valid }
        end
      end

      context 'on new user' do
        let(:user) { build(:user) }
        subject { user }

        it { expect { user.generate_refresh_token }.not_to raise_error }
        it { expect { user.generate_refresh_token }.to change(RefreshToken, :count).by(0) }

        context 'when called' do
          before { user.generate_refresh_token }

          it { should_not be_a RefreshToken }

          it { expect(user.errors).not_to be_empty }
        end
      end
    end
  end

  context 'associations' do
    it { should have_many(:preferences).dependent(:destroy) }
    context 'refresh tokens' do
      it { should have_many(:refresh_tokens).dependent(:destroy) }

      context 'should be deleted if user was deleted' do
        let!(:refresh_token) { create(:refresh_token, :with_user) }
        let!(:user) { refresh_token.user }

        it { expect { user.destroy }.to change(described_class, :count).by(-1) }
      end

      context 'when deleting refresh token, user should not be changed' do
        let!(:refresh_token) { create(:refresh_token, :with_user) }
        let!(:user) { refresh_token.user }

        it { expect { refresh_token.destroy }.not_to change(described_class, :count) }
      end
    end
  end

  it 'should be able to create a user with just { email }' do
    user = User.new(email: Faker::Internet.email)
    expect(user).to be_valid
    expect(user.errors).to be_empty
    expect(user.save).to be true
  end

  context 'should be able to create two users with just { email }' do
    def doit
      User.create!(email: Faker::Internet.email)
      User.create!(email: Faker::Internet.email)
    end

    it do
      expect { doit }.to change(User, :count).by(2)
    end

    it do
      expect { doit }.not_to raise_error
    end
  end

  context 'on update, should not call #create_missing_preferences' do
    let(:user) { create(:user) }

    it do
      user.preferences.destroy_all
      allow(user).to receive(:create_missing_preferences).and_call_original.exactly(0).times
      expect { user.update!(email: Faker::Internet.email) }.to change(Preference, :count).by(0)
    end
  end

  context 'should be able to read preference value with #preference_value' do
    let(:user) { create(:user) }

    it { should respond_to(:preference_value) }

    it 'assign timezone value and check if assigned.' do
      value = generate(:timezone)
      user.preference(:timezone).update!(value:)
      expect(user.preference_value(:timezone)).to eq(user.preference(:timezone).value)
      expect(user.preference_value(:timezone)).to eq(value)
    end

    it 'reset timezone value and check if function returns default' do
      user.preference(:timezone).update!(value: nil)
      expect(user.preference_value(:timezone)).to eq(Preference::DEFAULTS[:timezone][:default])
      expect(user.preference(:timezone).value).to eq nil
    end
  end

  context 'should be able to find a preference by key, using #preference(key)' do
    let(:user) { create(:user) }

    it { should respond_to(:preference) }

    it do
      user.preference(:timezone).update!(value: generate(:timezone))
    end

    it do
      user.preference(:language).update!(value: generate(:language))
    end
  end

  context 'if password is set, should not be overwritten by default generated' do
    it do
      user = User.new(email: generate(:user_email), password: 'banana')
      expect(user.save).to be true
      expect(User.find(user.id).authenticate('banana')).to be_truthy
    end
  end

  context 'after a user is created' do
    context 'all preferences should be created for that user' do
      it do
        user = create(:user)
        expect(user.preferences.count).to eq(Preference::DEFAULTS.count)
      end
    end
  end
end
