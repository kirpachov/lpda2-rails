# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RefreshToken, type: :model do
  include_context TESTS_OPTIMIZATIONS_CONTEXT

  context 'has valid factories' do
    it { expect { create(:refresh_token, :with_user) }.not_to raise_error }

    context 'create' do
      subject { create(:refresh_token, :with_user) }

      it { is_expected.to be_valid }
      it { is_expected.to be_persisted }
      it { is_expected.to be_a(described_class) }
    end

    context 'build' do
      subject { build(:refresh_token, :with_user) }

      it { is_expected.to be_valid }
      it { is_expected.not_to be_persisted }
      it { is_expected.to be_a(described_class) }
    end
  end

  context 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:user).required }
    it { is_expected.not_to belong_to(:user).optional }
  end

  context 'validations' do
    let!(:refresh_token) { create(:refresh_token, :with_user) }

    before { allow_any_instance_of(RefreshToken).to receive(:assign_defaults).and_return(true) }

    it { is_expected.to validate_presence_of(:secret) }
    it { is_expected.to validate_uniqueness_of(:secret) }
    it { is_expected.to validate_presence_of(:expires_at) }
  end

  context 'instance methods' do
    let(:instance) { described_class.new }

    describe '#refresh_secret_and_expiration!' do
      subject { refresh_token }

      let(:refresh_token) { create(:refresh_token, :with_user) }

      it { is_expected.to respond_to(:refresh_secret_and_expiration!) }
      it { is_expected.to be_valid }
      it { is_expected.to be_persisted }
      it { expect { refresh_token.refresh_secret_and_expiration! }.to change(refresh_token, :secret) }
      it { expect { refresh_token.refresh_secret_and_expiration! }.to change(refresh_token, :expires_at) }

      context 'after call' do
        before { refresh_token.refresh_secret_and_expiration! }

        it { expect { refresh_token.refresh_secret_and_expiration! }.not_to raise_error }
        it { is_expected.to be_a(RefreshToken) }
        it { expect(refresh_token.secret).not_to eq refresh_token.reload.secret }
        it { expect(refresh_token.expires_at).not_to eq RefreshToken.find(refresh_token.id).expires_at }
        it { expect(subject.changes).not_to be_empty }
      end
    end

    describe '#expired!' do
      it { expect(instance).to respond_to(:expire!) }
      it { expect(instance).to respond_to(:expired!) }

      context 'when calling on a new record, should create a record already expired' do
        subject { refresh_token }

        let(:refresh_token) { build(:refresh_token, :with_user, expires_at: 1.year.from_now) }

        it { is_expected.not_to be_persisted }
        it { is_expected.to be_valid }
        it { is_expected.not_to be_expired }
        it { expect { refresh_token.expired! }.not_to raise_error }
        it { expect { refresh_token.expire! }.not_to raise_error }
        it { expect(refresh_token.expired!).to eq true }

        context 'after call' do
          before { refresh_token.expired! }

          it { is_expected.to be_persisted }
          it { is_expected.to be_valid }
          it { is_expected.to be_expired }
        end
      end

      context 'when called on an existing record, should update the record to be expired' do
        subject { refresh_token }

        let(:refresh_token) { create(:refresh_token, :with_user, expires_at: 1.year.from_now) }

        it { is_expected.to be_persisted }
        it { is_expected.to be_valid }
        it { is_expected.not_to be_expired }
        it { expect { refresh_token.expired! }.not_to raise_error }
        it { expect(refresh_token.expired!).to eq true }

        context 'after call' do
          before { refresh_token.expired! }

          it { is_expected.to be_persisted }
          it { is_expected.to be_valid }
          it { is_expected.to be_expired }
        end
      end
    end

    describe '#expired?' do
      subject { refresh_token }

      let(:refresh_token) { build(:refresh_token, :with_user, expires_at: 1.year.from_now) }

      it { expect(instance).to respond_to(:expired?) }
      it { expect(instance).to respond_to(:not_expired?) }

      it { is_expected.not_to be_persisted }
      it { is_expected.to be_valid }
      it { expect(refresh_token.expired?).to eq false }
      it { expect(refresh_token.not_expired?).to eq true }

      context 'when #expired is before now' do
        before { refresh_token.expires_at = 1.year.ago }

        it { expect(refresh_token.expired?).to eq true }

        context 'and object is saved' do
          before { refresh_token.save! }

          it { is_expected.to be_persisted }
          it { is_expected.to be_valid }
          it { expect(refresh_token.expired?).to eq true }
          it { expect(refresh_token).to be_expired }
        end
      end
    end

    describe '#generate_jwt' do
      it { expect(instance).to respond_to(:generate_jwt) }

      context 'on existing refresh token' do
        subject { refresh_token }

        let(:refresh_token) { create(:refresh_token, :with_user) }

        it { is_expected.to be_valid }
        it { is_expected.to be_persisted }
        it { expect { refresh_token.generate_jwt }.not_to raise_error }

        context 'when called' do
          subject { refresh_token.generate_jwt }

          it { is_expected.to be_a String }
          it { is_expected.not_to be_empty }
        end
      end
    end
  end

  context 'class methods' do
    describe '.generate_for' do
      it { expect(described_class).to respond_to(:generate_for) }

      context 'should generate a refresh token' do
        context 'for the given user id' do
          let(:user) { create(:user) }

          def call
            described_class.generate_for(user.id)
          end

          it { expect { call }.not_to raise_error }
          it { expect { call }.to change(described_class, :count).by(1) }
          it { expect(described_class.count).to eq 0 }

          context 'after call' do
            subject { call }

            before { call }

            it { expect(described_class.count).to eq 1 }

            it { is_expected.to be_a(RefreshToken) }
            it { is_expected.to be_valid }
            it { is_expected.to be_persisted }
            it { expect(subject.user.id).to eq user.id }

            context 'call errors' do
              subject { call.errors }

              before { call.validate }

              it { is_expected.to be_empty }
            end
          end
        end

        context 'for the given User instance' do
          let(:user) { create(:user) }

          def call
            described_class.generate_for(user)
          end

          it { expect { call }.not_to raise_error }
          it { expect { call }.to change(described_class, :count).by(1) }
          it { expect(described_class.count).to eq 0 }

          context 'after call' do
            subject { call }

            before { call }

            it { expect(described_class.count).to eq 1 }

            it { is_expected.to be_a(RefreshToken) }
            it { is_expected.to be_valid }
            it { is_expected.to be_persisted }
            it { expect(subject.user.id).to eq user.id }

            context 'call errors' do
              subject { call.errors }

              before { call.validate }

              it { is_expected.to be_empty }
            end
          end
        end
      end
    end

    describe '.expired and not_expired scopes' do
      let(:user) { create(:user) }
      let(:count) { 10 }

      let!(:expired_refresh_tokens) do
        items = build_list(:refresh_token, count, expires_at: 1.year.ago).each do |rt|
          rt.user = user
          rt.assign_defaults
        end

        RefreshToken.import! items, validate: false
      end

      let!(:not_expired_refresh_tokens) do
        items = build_list(:refresh_token, count, expires_at: 1.year.from_now).each do |rt|
          rt.user = user
          rt.assign_defaults
        end

        RefreshToken.import! items, validate: false
      end

      describe '.expired scope' do
        it { expect(described_class).to respond_to(:expired) }

        it { expect(described_class.expired.count).to eq count }

        context 'expired items' do
          subject { described_class.expired }

          it { is_expected.to be_a(ActiveRecord::Relation) }
          it { is_expected.not_to be_empty }
          it { expect(subject.count).to eq count }
          it { expect(subject).to all(be_a(RefreshToken)) }
          it { expect(subject).to all(be_expired) }
          it { expect(subject.pluck(:id)).to match_array(RefreshToken.where('expires_at < NOW()').pluck(:id)) }
        end
      end

      describe '.not_expired scope' do
        it { expect(described_class).to respond_to(:not_expired) }

        it { expect(described_class.not_expired.count).to eq count }

        context 'not expired items' do
          subject { described_class.not_expired }

          it { is_expected.to be_a(ActiveRecord::Relation) }
          it { is_expected.not_to be_empty }
          it { expect(subject.count).to eq count }
          it { expect(subject).to all(be_a(RefreshToken)) }
          it { expect(subject).to all(be_not_expired) }
          it { expect(subject.map(&:expired?)).to all(eq false) }
          it { expect(subject.pluck(:id)).to match_array(RefreshToken.where('expires_at > NOW()').pluck(:id)) }
        end
      end
    end
  end
end
