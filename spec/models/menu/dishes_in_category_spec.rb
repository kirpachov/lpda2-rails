# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Menu::DishesInCategory, type: :model do
  include_context TESTS_OPTIMIZATIONS_CONTEXT

  context 'should have valid factories' do
    subject { build(:menu_dishes_in_category) }

    it { is_expected.to be_valid }
    it { expect { subject.save! }.not_to raise_error }
  end

  context 'associations' do
    subject { build(:menu_dishes_in_category) }

    before do
      allow(subject).to receive(:assign_defaults).and_return(true)
    end

    it { is_expected.to belong_to(:menu_dish).required }
    it { is_expected.to respond_to(:dish) }
    it { is_expected.to respond_to(:dish=) }

    it { is_expected.to belong_to(:menu_category).required(false) }
    it { is_expected.to respond_to(:category) }
    it { is_expected.to respond_to(:category=) }
  end

  context 'when element is being deleted' do
    subject { dishes_in_category }

    let(:category) { create(:menu_category) }
    let(:dish) { create(:menu_dish) }

    let!(:dishes_in_category) { create(:menu_dishes_in_category, menu_category: category, menu_dish: dish) }

    it { is_expected.to be_valid }
    it { expect(subject.save!).to be true }
    it { expect { subject.save! }.not_to raise_error }

    it 'category.dishes should include dish' do
      expect(category.reload.dishes).to include(dish)
    end

    it 'dish.categories should include category' do
      expect(dish.reload.categories).to include(category)
    end

    it { expect { subject.destroy! }.not_to(change { Menu::Dish.count }) }
    it { expect { subject.destroy! }.not_to(change { Menu::Category.count }) }
  end
end
