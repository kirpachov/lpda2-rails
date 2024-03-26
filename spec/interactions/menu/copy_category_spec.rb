# frozen_string_literal: true

require 'rails_helper'

RSpec.shared_examples 'fail to copy category' do
  it 'should not create any record' do
    models = [
      Menu::Category, Menu::DishesInCategory,
      Menu::Dish, Menu::AllergensInDish,
      Menu::Allergen, Menu::Tag,
      Menu::Ingredient, Menu::IngredientsInDish,
      Menu::TagsInDish, Image, ImageToRecord,
    ]

    records_count_before = models.map(&:count)
    subject
    records_coune_after = models.map(&:count)
    expect(records_coune_after).to eq(records_count_before)
  end

  it 'does not copy dishes' do
    expect { subject }.not_to change { Menu::Dish.count }
    expect(subject.result.dishes.count).to eq 0
    expect(subject.result).not_to be_persisted
    expect(subject.errors.full_messages).not_to be_empty
    is_expected.to be_invalid
  end
end

RSpec.describe Menu::CopyCategory, type: :interaction do
  context '#execute' do
    let!(:category) { create(:menu_category) }
    let!(:current_user) { create(:user) }
    let(:old) { category }
    let(:params) { { old:, current_user: } }
    subject { described_class.run(params: params) }

    context 'basic' do
      before do
        old.images << create(:image, :with_attached_image)
        # old.parent = create(:menu_category)
        old.price = 10.0
        old.secret_desc = 'secret_desc'
        old.other = { foo: 'bar' }

        I18n.available_locales.each do |locale|
          Mobility.with_locale(locale) do
            old.name = "Category-#{locale}"
            old.description = "Description-#{locale}"
          end
        end

        old.save!
      end

      it 'creates a new category' do
        expect { subject }.to change(Menu::Category, :count).by(1)
      end

      it 'copies name in all languages' do
        I18n.available_locales.each do |locale|
          Mobility.with_locale(locale) do
            expect(subject.result.name).to eq "Category-#{locale}"
          end
        end
      end

      it 'copies description in all languages' do
        I18n.available_locales.each do |locale|
          Mobility.with_locale(locale) do
            expect(subject.result.description).to eq "Description-#{locale}"
          end
        end
      end

      it 'copies images' do
        expect { subject }.to change(Image, :count).by(1)
        expect(subject.result.images.count).to eq 1
        expect(subject.result.images.first.url).not_to eq old.images.first.url
      end

      it { expect { subject }.to change(Image, :count).by(1) }

      it 'does not copy index' do
        expect(subject.result.index).to be_present
        expect(subject.result.index).not_to eq old.index
      end

      it 'does not copy visibility_id' do
        expect(subject.result.visibility_id).to be_present
        expect(old.visibility_id).to be_present
        expect(subject.result.visibility_id).not_to eq old.visibility_id
      end

      it 'does not copy secret' do
        expect(subject.result.secret).to be_present
        expect(old.secret).to be_present
        expect(subject.result.secret).not_to eq old.secret
      end

      it 'does not copy id' do
        expect(subject.result.id).to be_present
        expect(subject.result.id).not_to eq old.id
      end

      it 'does not copy created_at' do
        expect(subject.result.created_at).to be_present
        expect(subject.result.created_at).not_to eq old.created_at
      end

      it 'does not copy updated_at' do
        expect(subject.result.updated_at).to be_present
        expect(subject.result.updated_at).not_to eq old.updated_at
      end

      it 'does not copy secret_desc' do
        expect(old.secret_desc).to be_present
        expect(subject.result.secret_desc).to be_nil
      end

      it 'does copy status' do
        expect(subject.result.status).to eq old.status
      end

      it 'does copy other but adding information of original category.' do
        expect(subject.result.other).to eq old.other.merge('copied_from' => old.id)
      end

      it 'does copy price' do
        expect(subject.result.price.to_i).to be_positive
        expect(subject.result.price).to eq old.price
      end

      it 'call is valid' do
        expect(subject).to be_valid
      end

      it 'returns category' do
        expect(subject.result).to be_a(Menu::Category)
        expect(subject.result).to be_valid
        expect(subject.result).to be_persisted
      end

      context 'does copy all children' do
        before do
          create_list(:menu_category, 3, visibility: nil, parent: old)
        end

        context "checking mock data" do
          it { expect(old.children.count).to be_positive }
        end

        it { expect { subject }.to change { Menu::Category.count }.by(old.children.count + 1) }

        it "is successful" do
          subject.validate
          expect(subject.errors.full_messages).to be_empty
          expect(subject).to be_valid
        end

        it 'copies children' do
          expect(subject.result.children.reload.count).to eq old.children.reload.count

          I18n.available_locales.each do |locale|
            Mobility.with_locale(locale) do
              expect(subject.result.children.map(&:name)).to match_array(old.children.map(&:name))
            end
          end
        end
      end

      context "when providing {copy_children: 'none'}, should not copy children." do
        let(:params) { { old:, current_user:, copy_children: 'none' } }

        before do
          create_list(:menu_category, 3, visibility: nil, parent: old)
        end

        context "checking mock data" do
          it { expect(old.children.count).to be_positive }
        end

        it do
          expect { subject }.to change { Menu::Category.count }.by(1)
          expect(subject.result.children.count).to eq 0
        end
      end

      it 'enqueue a job to save the changes with current user info' do
        allow(SaveModelChangeJob).to receive(:perform_async).with(include("user_id" => current_user.id))
        subject
      end
    end

    context 'if category is not root, does copy parent_id' do
      let(:category) { create(:menu_category, visibility: nil, parent: create(:menu_category)) }

      it 'does copy parent_id' do
        expect(subject.result.parent_id).to be_present
        expect(subject.result.parent_id).to eq old.parent_id
      end
    end

    context 'copying dishes with {copy_dishes: "full"}' do
      let!(:dish) { create(:menu_dish) }
      before { category.dishes = [dish] }
      let(:params) { { old:, current_user:, copy_dishes: 'full' } }

      it { expect { subject }.to change { Menu::DishesInCategory.count }.by(1) }

      it 'copies dishes' do
        expect { subject }.to change { Menu::Dish.count }.by(1)
        expect(subject.result.dishes.count).to eq 1
        expect(subject.result.dishes.first.name).to eq old.dishes.first.name
      end
    end

    context 'copying dishes with {copy_dishes: "link"}' do
      let!(:dish) { create(:menu_dish) }
      before { category.dishes = [dish] }
      let(:params) { { old:, current_user:, copy_dishes: 'link' } }

      it { expect { subject }.to change { Menu::DishesInCategory.count }.by(1) }

      it 'copies dishes' do
        expect { subject }.to change { Menu::Dish.count }.by(0)
        expect(subject.result.dishes.count).to eq 1
        expect(subject.result.dishes.first.name).to eq old.dishes.first.name
      end
    end

    context 'NOT copying dishes with {copy_dishes: "none"}' do
      let!(:dish) { create(:menu_dish) }
      before { category.dishes = [dish] }
      let(:params) { { old:, current_user:, copy_dishes: 'none' } }

      it { expect { subject }.not_to change { Menu::DishesInCategory.count } }

      it 'does not copy dishes' do
        expect { subject }.not_to change { Menu::Dish.count }
        expect(subject.result.dishes.count).to eq 0
      end
    end

    context 'when cannot save' do
      let!(:dish) { create(:menu_dish) }
      let!(:ingredient) { create(:menu_ingredient) }
      let!(:tag) { create(:menu_tag) }
      let!(:allergen) { create(:menu_allergen) }
      let!(:image) { create(:image, :with_attached_image) }

      let(:params) { { old:, current_user: } }

      before do
        dish.ingredients = [ingredient]
        dish.tags = [tag]
        dish.allergens = [allergen]
        category.dishes = [dish]
        category.images = [image]
      end

      it 'check mock data' do
        expect(dish).to be_valid
        expect(ingredient).to be_valid
        expect(tag).to be_valid
        expect(allergen).to be_valid
        expect(category).to be_valid
        expect(image).to be_valid
        expect(category.dishes.count).to eq 1
        expect(category.images.count).to eq 1
        expect(dish.allergens.count).to eq 1
        expect(dish.tags.count).to eq 1
        expect(dish.ingredients.count).to eq 1
      end

      def prevent_save(model)
        allow_any_instance_of(model).to receive(:valid?).and_return(false)
        errors = ActiveModel::Errors.new(model)
        errors.add(:base, "Some error message")
        allow_any_instance_of(model).to receive(:errors).and_return(errors)
      end

      context 'dish' do
        before { prevent_save(Menu::Dish) }

        it_behaves_like 'fail to copy category'
      end

      context 'allergen' do
        before { prevent_save(Menu::Allergen) }

        it_behaves_like 'fail to copy category'
      end

      context 'tag' do
        before { prevent_save(Menu::Tag) }

        it_behaves_like 'fail to copy category'
      end

      context 'ingredient' do
        before { prevent_save(Menu::Ingredient) }

        it_behaves_like 'fail to copy category'
      end

      context 'image' do
        before { prevent_save(Image) }

        it_behaves_like 'fail to copy category'
      end
    end
  end
end
