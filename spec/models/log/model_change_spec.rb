# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Log::ModelChange, type: :model do
  context 'has valid factory' do
    it { expect(build(:model_change)).to be_valid }
    it { expect(create(:model_change)).to be_valid }
  end

  context 'associations' do
    it { should belong_to(:record) }
    it { should belong_to(:user).optional }
  end

  context 'validations' do
    before do
      create(:model_change)
      allow_any_instance_of(described_class).to receive(:assign_defaults).and_return(true)
    end

    it { should validate_presence_of(:change_type) }
    it { should validate_presence_of(:version) }
    it { should validate_uniqueness_of(:version).scoped_to(:record_id, :record_type) }
    it { should validate_numericality_of(:version).only_integer.is_greater_than(0) }
    it { should validate_inclusion_of(:change_type).in_array(%w[create update delete]) }
  end
end
