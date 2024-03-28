# frozen_string_literal: true

require "rails_helper"

RSpec.describe Menu::AllergensInDish, type: :model do
  include_context TESTS_OPTIMIZATIONS_CONTEXT

  context "has valid factory" do
    subject { build(:menu_allergens_in_dish) }

    it { is_expected.to be_valid }
    it { expect { subject.save! }.not_to raise_error }
    it { expect(subject.save).to eq true }

    context "when saved" do
      subject { create(:menu_allergens_in_dish) }

      it { is_expected.to be_valid }
      it { is_expected.to be_persisted }
    end
  end
end
