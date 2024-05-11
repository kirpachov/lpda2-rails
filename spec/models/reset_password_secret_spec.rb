# frozen_string_literal: true

require "rails_helper"

RSpec.describe ResetPasswordSecret do
  let(:user) { create(:user) }

  context "when checking validation" do
    before do
      allow_any_instance_of(described_class).to receive(:generate_secret).and_return(true)
    end

    it { expect(subject).not_to allow_value(nil).for(:secret) }
    it { expect(subject).not_to allow_value("").for(:secret) }
    it { expect(subject).not_to allow_value(nil).for(:user) }
  end

  it do
    expect { described_class.create!(user: create(:user), secret: "wassa") }.not_to raise_error
  end

  it do
    expect { described_class.create!(user: create(:user)) }.not_to raise_error
  end

  it do
    expect { described_class.create! }.to raise_error(ActiveRecord::RecordInvalid)
  end

  it do
    r = described_class.create!(user:)
    expect(r.reload.expires_at).to be > (5.minutes.from_now)
  end

  context "when creating a new secret, all the other are deleted" do
    it do
      expect { described_class.create!(user:) }.to(change(described_class, :count).by(1))

      expect { described_class.create!(user:) }.not_to(change(described_class, :count))
      expect { described_class.create!(user:) }.not_to(change(described_class, :count))
      expect { described_class.create!(user:) }.not_to(change(described_class, :count))
    end
  end

  context "when filtering for not expired" do
    before do
      travel_to(1.month.ago) do
        create(:reset_password_secret, user: create(:user))
      end

      create(:reset_password_secret, user: create(:user))
    end

    it { expect(described_class.count).to eq 2 }
    it { expect(described_class.expired.count).to eq 1 }
    it { expect(described_class.not_expired.count).to eq 1 }
  end

  context "when calling .deleted_expired_secrets" do
    before do
      travel_to(1.month.ago) do
        create(:reset_password_secret, user: create(:user))
      end

      create(:reset_password_secret, user: create(:user))
    end

    it { expect { described_class.delete_expired_secrets }.to change { described_class.count }.by(-1) }
  end

  context "when two users have two different secrets but with same :secret field value" do
    let!(:secret0) { create(:reset_password_secret, user: create(:user)) }

    let(:secret) { build(:reset_password_secret, user:, secret: secret0.secret) }

    it { expect(secret0.secret).to eq secret.secret }

    it do
      expect { secret.save! }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it { expect(secret).to be_invalid }

    it do
      secret.validate
      expect(secret.errors[:secret]).to be_present
    end
  end

  context "when checking #expired? and setting #expired!" do
    subject(:secret) { create(:reset_password_secret, user:) }

    it { expect(secret).not_to be_expired }

    it do
      expect { secret.expired! }.to(change { secret.reload.expires_at })
    end

    it do
      expect { secret.expired! }.to(change { secret.reload.updated_at })
    end

    it do
      secret.expired!
      expect(secret).to be_expired
    end
  end
end
