# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validations' do
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
  end

  context 'associations' do
    it { should have_many(:preferences).dependent(:destroy) }
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

    it "assign timezone value and check if assigned." do
      value = generate(:timezone)
      user.preference(:timezone).update!(value: value)
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
