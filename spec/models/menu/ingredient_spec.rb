# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Menu::Ingredient, type: :model do
  def valid_statuses
    %w[active deleted]
  end

  context 'can be translated' do
    subject { create(:menu_ingredient) }

    include_examples MODEL_MOBILITY_EXAMPLES, field: :name
    include_examples MODEL_MOBILITY_EXAMPLES, field: :description
  end

  context 'has image' do
    subject { create(:menu_ingredient) }

    include_examples HAS_IMAGE_HELPER
  end

  context 'has valid factory' do
    subject { build(:menu_ingredient) }
    it { should be_valid }
    it { expect { subject.save! }.not_to raise_error }
    it { expect(subject.save).to eq true }

    context 'when saved' do
      subject { create(:menu_ingredient) }
      it { should be_valid }
      it { should be_persisted }
    end
  end

  context 'validations' do
    before { allow_any_instance_of(described_class).to receive(:assign_defaults).and_return(true) }
    it { should validate_presence_of(:status) }
    it { should allow_value('active').for(:status) }
    it { should_not allow_value('some_invalid_status').for(:status) }
    it { expect(subject.defined_enums.keys).to include('status') }
    it { should validate_inclusion_of(:status).in_array(valid_statuses) }

    it { should allow_value({foo: :bar}).for(:other) }
    it { should allow_value({}).for(:other) }
    it { should_not allow_value(nil).for(:other) }
  end

  context 'associations' do
    it { should have_many(:menu_ingredients_in_dishes) }
    it { should have_many(:menu_dishes).through(:menu_ingredients_in_dishes) }

    context 'can assign menu_dishes with "dishes="' do
      subject { create(:menu_ingredient) }
      it { should be_valid }
      it { should be_persisted }
      it { expect { subject.dishes = [create(:menu_dish)] }.not_to raise_error }

      context 'when assigned' do
        before { subject.dishes = [create(:menu_dish)] }
        it { should be_valid }
        it { should be_persisted }
        it { expect(subject.dishes.count).to eq 1 }
        it { expect(subject.dishes).to all(be_a Menu::Dish) }
      end
    end

    context 'can assign menu_dishes with "menu_dishes="' do
      subject { create(:menu_ingredient) }
      it { should be_valid }
      it { should be_persisted }
      it { expect { subject.menu_dishes = [create(:menu_dish)] }.not_to raise_error }

      context 'when assigned' do
        before { subject.menu_dishes = [create(:menu_dish)] }
        it { should be_valid }
        it { should be_persisted }
        it { expect(subject.dishes.count).to eq 1 }
        it { expect(subject.dishes).to all(be_a Menu::Dish) }
      end
    end

    context 'when deleted, should not delete associated dishes, but should delete association to dish itself' do
      let(:menu_ingredient) { create(:menu_ingredient) }
      before { menu_ingredient.dishes = [create(:menu_dish)] }

      it { expect { menu_ingredient.destroy }.not_to change(Menu::Dish, :count) }
      it { expect { menu_ingredient.destroy }.to change(Menu::Ingredient, :count).by(-1) }
      it { expect { menu_ingredient.destroy }.to change(Menu::IngredientsInDish, :count).by(-1) }
    end
  end
end
