# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Menu::Dish, type: :model do
  def valid_statuses
    Menu::Dish::VALID_STATUSES
  end

  context 'has valid factories' do
    subject { build(:menu_dish) }
    it { should be_valid }
    it { expect(subject.save).to eq true }
    it { expect { subject.save! }.not_to raise_error }
  end

  context 'validations' do
    context 'has price. Price can be nil or 0 but never negative' do
      subject { build(:menu_dish) }
      it { should allow_value(nil).for(:price) }
      it { should allow_value(0).for(:price) }
      it { should allow_value(100).for(:price) }
      it { should_not allow_value(-1).for(:price) }
      it { should_not allow_value(-10).for(:price) }

      context 'when price is -1' do
        subject { build(:menu_dish, price: -1) }

        it { should_not be_valid }
        it { expect(subject.save).to eq false }
        it { expect { subject.save! }.to raise_error ActiveRecord::RecordInvalid }
      end
    end

    context 'has status. status must be in VALID_STATUSES' do
      subject { build(:menu_dish) }
      it { should allow_value('active').for(:status) }
      it { should validate_inclusion_of(:status).in_array(valid_statuses) }
    end
  end

  context 'associations' do
    it { should have_many(:menu_dishes_in_categories) }
    it { should have_many(:menu_categories) }

    context 'when trying to assign categories with "="' do
      subject { create(:menu_dish) }
      let(:category) { create(:menu_category) }
      it { should be_valid }
      it { should be_persisted }
      it { expect(subject.categories.count).to eq 0 }
      it { expect(category.dishes.count).to eq 0 }

      it "should assign category" do
        subject.categories = [category]
        expect(subject.reload.categories.count).to eq 1
        expect(category.reload.dishes.count).to eq 1
      end
    end

    context 'when deleted, should destroy all DishInCategory' do
      let(:dish) { create(:menu_dish) }
      let(:category) { create(:menu_category) }
      let!(:dish_in_category) { create(:menu_dishes_in_category, menu_dish: dish, menu_category: category) }

      subject { dish }

      it { should be_valid }
      it { should be_persisted }
      it { expect(dish.categories).to include(category) }
      it { expect(category.dishes).to include(dish) }
      it { expect(dish.categories.count).to eq 1 }
      it { expect(category.dishes.count).to eq 1 }
      it { expect{ dish.destroy! }.to change{ Menu::DishesInCategory.count }.by(-1) }
      it { expect{ dish.destroy! }.to change{ Menu::Visibility.count }.by(-1) }
      it { expect{ dish.destroy! }.to change{ Menu::Category.count }.by(0) }
    end
  end

  context 'instance methods' do
    subject { build(:menu_dish) }
    it { should respond_to(:menu_dishes_in_categories) }
    it { should respond_to(:menu_dishes_in_categories=) }
    it { should respond_to(:menu_categories=) }
    it { should respond_to(:menu_categories) }
    it { should respond_to(:categories=) }
    it { should respond_to(:categories) }
    it { should respond_to(:price) }
    it { should respond_to(:price=) }
    it { should respond_to(:status) }
    it { should respond_to(:status=) }
  end
end
