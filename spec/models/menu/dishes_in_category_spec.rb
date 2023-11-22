# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Menu::DishesInCategory, type: :model do
  context 'should have valid factories' do
    subject { build(:menu_dishes_in_category) }
    it { should be_valid }
    it { expect { subject.save! }.not_to raise_error }
  end

  context 'associations' do
    subject { build(:menu_dishes_in_category) }

    before do
      allow(subject).to receive(:assign_defaults).and_return(true)
    end

    it { should belong_to(:menu_dish).required }
    it { should respond_to(:dish) }
    it { should respond_to(:dish=) }

    it { should belong_to(:menu_category).required }
    it { should respond_to(:category) }
    it { should respond_to(:category=) }

    it { should belong_to(:menu_visibility).required }
    it { should respond_to(:visibility) }
    it { should respond_to(:visibility=) }
  end

  context 'should create menu visibility before validation' do
    subject { build(:menu_dishes_in_category, menu_visibility: nil) }

    it { should be_valid }
    it { expect(subject.save!).to be true }
    it { expect { subject.save! }.not_to raise_error }
    it "should have menu visibility after save" do
      subject.save!

      expect(subject.reload.visibility).to be_a(Menu::Visibility)
    end
  end

  context 'when element is being deleted' do
    let(:category) { create(:menu_category) }
    let(:dish) { create(:menu_dish) }

    let!(:dishes_in_category) { create(:menu_dishes_in_category, menu_category: category, menu_dish: dish) }

    subject { dishes_in_category }

    it { should be_valid }
    it { expect(subject.save!).to be true }
    it { expect { subject.save! }.not_to raise_error }

    it "category.dishes should include dish" do
      expect(category.reload.dishes).to include(dish)
    end

    it "dish.categories should include category" do
      expect(dish.reload.categories).to include(category)
    end

    it { expect { subject.destroy! }.not_to change { Menu::Dish.count } }
    it { expect { subject.destroy! }.not_to change { Menu::Category.count } }
  end
end
