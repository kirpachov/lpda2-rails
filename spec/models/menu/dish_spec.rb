# frozen_string_literal: true

require "rails_helper"

RSpec.describe Menu::Dish, type: :model do
  include_context TESTS_OPTIMIZATIONS_CONTEXT

  context "should track changes with ModelChange" do
    let(:record) { create(:menu_dish) }

    include_examples TEST_MODEL_CHANGE_INCLUSION
  end

  context "can be translated" do
    subject { create(:menu_dish) }

    include_examples MODEL_MOBILITY_EXAMPLES, field: :name
    include_examples MODEL_MOBILITY_EXAMPLES, field: :description
  end

  context "has image" do
    subject { create(:menu_dish) }

    include_examples HAS_IMAGES_HELPER
  end

  def valid_statuses
    Menu::Dish::VALID_STATUSES
  end

  context "has valid factories" do
    subject { build(:menu_dish) }

    it { is_expected.to be_valid }
    it { expect(subject.save).to eq true }
    it { expect { subject.save! }.not_to raise_error }
  end

  context "validations" do
    context "has price. Price can be nil or 0 but never negative" do
      subject { build(:menu_dish) }

      it { is_expected.to allow_value(nil).for(:price) }
      it { is_expected.to allow_value(0).for(:price) }
      it { is_expected.to allow_value(100).for(:price) }
      it { is_expected.not_to allow_value(-1).for(:price) }
      it { is_expected.not_to allow_value(-10).for(:price) }

      context "when price is -1" do
        subject { build(:menu_dish, price: -1) }

        it { is_expected.not_to be_valid }
        it { expect(subject.save).to eq false }
        it { expect { subject.save! }.to raise_error ActiveRecord::RecordInvalid }
      end
    end

    context "has status. status must be in VALID_STATUSES" do
      subject { build(:menu_dish) }

      it { is_expected.to allow_value("active").for(:status) }
      it { is_expected.to validate_inclusion_of(:status).in_array(valid_statuses) }
    end
  end

  context "associations" do
    it { is_expected.to have_many(:menu_dishes_in_categories) }
    it { is_expected.to have_many(:menu_categories) }
    it { expect(described_class.new).to respond_to(:categories) }

    context "has many suggestions" do
      let!(:dish) { create(:menu_dish) }
      let!(:dishes) { create_list(:menu_dish, 3) }

      it do
        s = dishes.first
        expect { dish.suggestions << s }.to change { dish.suggestions.count }.by(1)
        expect { dish.suggestions.delete(s) }.to change { dish.suggestions.count }.by(-1)
        expect { dish.suggestions.delete(s) }.not_to(change { dish.suggestions.count })
      end

      it do
        expect(dish.suggestions).to be_empty
        expect { dish.suggestions = dishes }.to change { dish.suggestions.count }.by(3)
      end
    end

    context 'when trying to assign categories with "="' do
      subject { create(:menu_dish) }

      let(:category) { create(:menu_category) }

      it { is_expected.to be_valid }
      it { is_expected.to be_persisted }
      it { expect(subject.categories.count).to eq 0 }
      it { expect(category.dishes.count).to eq 0 }

      it "assigns category" do
        subject.categories = [category]
        expect(subject.reload.categories.count).to eq 1
        expect(category.reload.dishes.count).to eq 1
      end
    end

    context "when deleted, should destroy all DishInCategory" do
      subject { dish }

      let(:dish) { create(:menu_dish) }
      let(:category) { create(:menu_category) }
      let!(:dish_in_category) { create(:menu_dishes_in_category, menu_dish: dish, menu_category: category) }

      it { is_expected.to be_valid }
      it { is_expected.to be_persisted }
      it { expect(dish.categories).to include(category) }
      it { expect(category.dishes).to include(dish) }
      it { expect(dish.categories.count).to eq 1 }
      it { expect(category.dishes.count).to eq 1 }
      it { expect { dish.destroy! }.to change { Menu::DishesInCategory.count }.by(-1) }
      it { expect { dish.destroy! }.not_to(change { Menu::Visibility.count }) }
      it { expect { dish.destroy! }.not_to(change { Menu::Category.count }) }
    end

    context "has many ingredients" do
      it { is_expected.to have_many(:menu_ingredients_in_dishes) }
      it { is_expected.to have_many(:menu_ingredients).through(:menu_ingredients_in_dishes) }

      it { expect(described_class.new).to respond_to(:ingredients) }

      context 'when trying to assign ingredients with "="' do
        subject { create(:menu_dish) }

        let(:ingredient) { create(:menu_ingredient) }

        it { is_expected.to be_valid }
        it { is_expected.to be_persisted }
        it { expect(subject.ingredients.count).to eq 0 }
        it { expect(ingredient.dishes.count).to eq 0 }

        it "assigns ingredient" do
          subject.ingredients = [ingredient]
          expect(subject.reload.ingredients.count).to eq 1
          expect(ingredient.reload.dishes.count).to eq 1
        end
      end
    end

    context "has many allergens" do
      it { is_expected.to have_many(:menu_allergens_in_dishes) }
      it { is_expected.to have_many(:menu_allergens).through(:menu_allergens_in_dishes) }

      it { expect(described_class.new).to respond_to(:allergens) }

      context 'when trying to assign allergens with "="' do
        subject { create(:menu_dish) }

        let(:allergen) { create(:menu_allergen) }

        it { is_expected.to be_valid }
        it { is_expected.to be_persisted }
        it { expect(subject.allergens.count).to eq 0 }
        it { expect(allergen.dishes.count).to eq 0 }

        it "assigns allergen" do
          subject.allergens = [allergen]
          expect(subject.reload.allergens.count).to eq 1
          expect(allergen.reload.dishes.count).to eq 1
        end
      end
    end

    context "has many tags" do
      it { is_expected.to have_many(:menu_tags_in_dishes) }
      it { is_expected.to have_many(:menu_tags).through(:menu_tags_in_dishes) }

      it { expect(described_class.new).to respond_to(:tags) }

      context 'when trying to assign tags with "="' do
        subject { create(:menu_dish) }

        let(:tag) { create(:menu_tag) }

        it { is_expected.to be_valid }
        it { is_expected.to be_persisted }
        it { expect(subject.tags.count).to eq 0 }
        it { expect(tag.dishes.count).to eq 0 }

        it "assigns tag" do
          subject.tags = [tag]
          expect(subject.reload.tags.count).to eq 1
          expect(tag.reload.dishes.count).to eq 1
        end
      end
    end
  end

  context "instance methods" do
    subject { build(:menu_dish) }

    it { is_expected.to respond_to(:menu_dishes_in_categories) }
    it { is_expected.to respond_to(:menu_dishes_in_categories=) }
    it { is_expected.to respond_to(:menu_categories=) }
    it { is_expected.to respond_to(:menu_categories) }
    it { is_expected.to respond_to(:categories=) }
    it { is_expected.to respond_to(:categories) }
    it { is_expected.to respond_to(:price) }
    it { is_expected.to respond_to(:price=) }
    it { is_expected.to respond_to(:status) }
    it { is_expected.to respond_to(:status=) }
  end
end
