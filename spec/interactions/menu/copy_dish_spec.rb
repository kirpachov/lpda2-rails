# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Menu::CopyDish, type: :interaction do
  context '#execute' do
    let!(:dish) { create(:menu_dish) }
    let!(:current_user) { create(:user) }
    let(:old) { dish }
    let(:params) { { old:, current_user: } }
    subject { described_class.run(params) }

    context 'basic' do
      it 'creates a new dish' do
        expect { subject }.to change(Menu::Dish, :count).by(1)
      end

      it 'call is valid' do
        expect(subject).to be_valid
      end

      it 'returns dish' do
        expect(subject.result).to be_a(Menu::Dish)
        expect(subject.result).to be_valid
        expect(subject.result).to be_persisted
      end

      it 'enqueue a job to save the changes with current user info' do
        allow(SaveModelChangeJob).to receive(:perform_async).with(include("user_id" => current_user.id))
        subject
      end
    end

    context 'should copy name and description translations' do
      before do
        I18n.available_locales.each do |locale|
          Mobility.with_locale(locale) do
            old.name = "Name in #{locale}"
            old.description = "Description in #{locale}"
          end
        end

        old.save!
      end

      context 'checking mock data' do
        it 'has name and description in all available locales' do
          I18n.available_locales.each do |locale|
            Mobility.with_locale(locale) do
              expect(old.name).to eq("Name in #{locale}")
              expect(old.description).to eq("Description in #{locale}")
            end
          end
        end
      end

      it 'copies name and description translations' do
        expect(subject.result.name).to eq(old.name)
        expect(subject.result.description).to eq(old.description)
        expect(subject.result.name).to be_present
        expect(subject.result.description).to be_present
      end

      it 'name in all available locales' do
        I18n.available_locales.each do |locale|
          Mobility.with_locale(locale) do
            expect(subject.result.name).to eq("Name in #{locale}")
          end
        end
      end

      it 'description in all available locales' do
        I18n.available_locales.each do |locale|
          Mobility.with_locale(locale) do
            expect(subject.result.description).to eq("Description in #{locale}")
          end
        end
      end
    end

    context 'copies status' do
      it 'copies status' do
        expect(subject.result.status).to eq(old.status)
      end
    end

    context 'copies price' do
      before { old.update!(price: 1_001.5) }

      it 'copies price' do
        expect(subject.result.price).to eq(old.price)
        expect(subject.result.reload.price).to eq(1_001.5)
      end
    end

    context 'copies other' do
      before { old.update!(other: { foo: :bar }) }

      it 'copies other' do
        expect(subject.result.reload.other).to eq(old.other)
        expect(subject.result.other).to eq({ 'foo' => 'bar' })
      end
    end

    context 'when dish has images and providing {copy_images: "full"}' do
      let!(:image) { create(:image, :with_attached_image) }
      before { dish.images = [image] }
      let(:params) { { old:, current_user:, copy_images: "full" } }

      it { expect(subject.result.images).not_to be_empty }

      it { expect(subject.errors).to be_empty }

      it { expect { subject }.to change { Image.count }.by(1) }
      it { expect { subject }.to change { ActiveStorage::Blob.count }.by(1) }
      it { expect { subject }.to change { ActiveStorage::Attachment.count }.by(1) }

      it { expect(subject.result.images.first.url).not_to eq dish.images.first.url }

      it 'should have a different image' do
        new = subject.result
        dish.images.first.attached_image.blob.purge
        dish.images.first.attached_image.destroy!
        dish.images.first.destroy!
        dish.destroy!

        expect(new.images.first.url).to be_present
        expect(new.images.first.attached_image.blob).to be_present
      end
    end

    context 'when dish has MANY images and providing {copy_images: "full"}' do
      let!(:images) { create_list(:image, 3, :with_attached_image) }
      before { dish.images = images }
      let(:params) { { old:, current_user:, copy_images: "full" } }

      it { expect(subject.result.images).not_to be_empty }

      it { expect(subject.errors).to be_empty }

      it { expect { subject }.to change { Image.count }.by(3) }
      it { expect { subject }.to change { ActiveStorage::Blob.count }.by(3) }
      it { expect { subject }.to change { ActiveStorage::Attachment.count }.by(3) }

      it { expect(subject.result.images.first.url).not_to eq dish.images.first.url }

      it 'none of the links should equal' do
        subject.result.images.each do |result_image|
          expect(dish.images.map { |img| img.url }).not_to include(result_image.url)
        end
      end

      it { expect(subject.result.images.count).to eq dish.images.count }

      it 'should have a different image' do
        new = subject.result
        dish.images.first.attached_image.blob.purge
        dish.images.first.attached_image.destroy!
        dish.images.first.destroy!
        dish.destroy!

        expect(new.images.first.url).to be_present
        expect(new.images.first.attached_image.blob).to be_present
      end
    end

    context 'when dish has images and providing {copy_images: "link"}' do
      let!(:image) { create(:image, :with_attached_image) }
      before { dish.images = [image] }
      let(:params) { { old:, current_user:, copy_images: "link" } }

      it { expect(subject.result.images).not_to be_empty }

      it { expect(subject.errors).to be_empty }

      it { expect { subject }.not_to change { Image.count } }
      it { expect { subject }.not_to change { ActiveStorage::Blob.count } }
      it { expect { subject }.not_to change { ActiveStorage::Attachment.count } }

      it { expect(subject.result.images.first.url).to eq dish.images.first.url }
      it { expect(subject.result.images.first.id).to eq dish.images.first.id }
    end

    context 'when dish has MANY images and providing {copy_images: "link"}' do
      let!(:images) { create_list(:image, 3, :with_attached_image) }
      before { dish.images = images }
      let(:params) { { old:, current_user:, copy_images: "link" } }

      it { expect(subject.result.images).not_to be_empty }
      it { expect(subject.result.images.count).to eq dish.images.count }

      it { expect(subject.errors).to be_empty }

      it { expect { subject }.not_to change { Image.count } }
      it { expect { subject }.not_to change { ActiveStorage::Blob.count } }
      it { expect { subject }.not_to change { ActiveStorage::Attachment.count } }

      it { expect(subject.result.images.first.url).to eq dish.images.first.url }
      it { expect(subject.result.images.first.id).to eq dish.images.first.id }
      it { expect(subject.result.images.map { |img| img.url }).to eq dish.images.map { |img| img.url } }
    end

    context 'when dish has images and providing {copy_images: "none"}' do
      let!(:image) { create(:image, :with_attached_image) }
      before { dish.images = [image] }
      let(:params) { { old:, current_user:, copy_images: "none" } }

      it { expect(subject.result.images).to be_empty }
      it { expect(subject.result.reload.images).to be_empty }

      it { expect { subject }.not_to change { Image.count } }
      it { expect { subject }.not_to change { ActiveStorage::Blob.count } }
      it { expect { subject }.not_to change { ActiveStorage::Attachment.count } }
    end

    context 'when dish has ingredients' do
      let(:ingredients) { create_list(:menu_ingredient, 3) }
      before { dish.ingredients = ingredients }

      context 'checking mock data' do
        it { expect(dish.ingredients.count).to eq ingredients.count }
        it { expect(dish.ingredients.count).to be_positive }
      end

      context 'when providing {copy_ingredients: "full"}' do
        let(:params) { { old:, current_user:, copy_ingredients: "full" } }

        it { expect { subject }.to change { Menu::Ingredient.count }.by(ingredients.count) }
        it { expect { subject }.to change { Menu::IngredientsInDish.count }.by(ingredients.count) }
        it { expect(subject.result.ingredients.map(&:id)).not_to match_array(ingredients.map(&:id)) }
        it { expect(subject.result.ingredients.map(&:id)).not_to match_array(old.ingredients.map(&:id)) }

        context 'when ingredients have images' do
          let(:ingredients) { create_list(:menu_ingredient, 3, :with_image_with_attachment) }

          it { expect { subject }.to change { Image.count }.by(ingredients.count) }
          it { expect { subject }.to change { ImageToRecord.count }.by(ingredients.count) }
          it { expect { subject }.to change { ActiveStorage::Attachment.count }.by(ingredients.count) }
          it { expect { subject }.to change { ActiveStorage::Blob.count }.by(ingredients.count) }
        end
      end

      context 'when providing {copy_ingredients: "link"}' do
        let(:params) { { old:, current_user:, copy_ingredients: "link" } }

        it { expect(subject.result.ingredients).not_to be_empty }
        it { expect(subject.result.ingredients.map(&:id)).to match_array(ingredients.map(&:id)) }
        it { expect(subject.result.ingredients.map(&:id)).to match_array(old.ingredients.map(&:id)) }
        it { expect { subject }.not_to change { Menu::Ingredient.count } }
        it { expect { subject }.to change { Menu::IngredientsInDish.count }.by(ingredients.count) }

        context 'when ingredients have images' do
          let(:ingredients) { create_list(:menu_ingredient, 3, :with_image_with_attachment) }

          it { expect { subject }.not_to change { Image.count } }
          it { expect { subject }.not_to change { ActiveStorage::Attachment.count } }
          it { expect { subject }.not_to change { ActiveStorage::Blob.count } }
        end
      end

      context 'when providing {copy_ingredients: "none"}' do
        let(:params) { { old:, current_user:, copy_ingredients: "none" } }
        it { expect(subject.result.ingredients).to be_empty }
        it { expect { subject }.not_to change { Menu::Ingredient.count } }
        it { expect { subject }.not_to change { Menu::IngredientsInDish.count } }
      end
    end

    context 'when dish has tags' do
      let(:tags) { create_list(:menu_tag, 3) }
      before { dish.tags = tags }

      context 'checking mock data' do
        it { expect(dish.tags.count).to eq tags.count }
        it { expect(dish.tags.count).to be_positive }
      end

      context 'when providing {copy_tags: "full"}' do
        let(:params) { { old:, current_user:, copy_tags: "full" } }

        it { expect { subject }.to change { Menu::Tag.count }.by(tags.count) }
        it { expect { subject }.to change { Menu::TagsInDish.count }.by(tags.count) }
        it { expect(subject.result.tags.map(&:id)).not_to match_array(tags.map(&:id)) }
        it { expect(subject.result.tags.map(&:id)).not_to match_array(old.tags.map(&:id)) }

        context 'when tags have images' do
          let(:tags) { create_list(:menu_tag, 3, :with_image_with_attachment) }

          it { expect { subject }.to change { Image.count }.by(tags.count) }
          it { expect { subject }.to change { ImageToRecord.count }.by(tags.count) }
          it { expect { subject }.to change { ActiveStorage::Attachment.count }.by(tags.count) }
          it { expect { subject }.to change { ActiveStorage::Blob.count }.by(tags.count) }
        end

        context 'when tags have colors' do
          let(:tags) { 3.times.map { create(:menu_tag, color: Faker::Color.hex_color) } }

          it { expect { subject }.to change { Menu::Tag.count }.by(tags.count) }
          it { expect { subject }.to change { Menu::TagsInDish.count }.by(tags.count) }
          it { expect(subject.result.tags.map(&:color)).to match_array(old.tags.map(&:color)) }
          it { expect(subject.result.tags.map(&:color)).to match_array(tags.map(&:color)) }
        end
      end

      context 'when providing {copy_tags: "link"}' do
        let(:params) { { old:, current_user:, copy_tags: "link" } }

        it { expect(subject.result.tags).not_to be_empty }
        it { expect(subject.result.tags.map(&:id)).to match_array(tags.map(&:id)) }
        it { expect(subject.result.tags.map(&:id)).to match_array(old.tags.map(&:id)) }
        it { expect { subject }.not_to change { Menu::Tag.count } }
        it { expect { subject }.to change { Menu::TagsInDish.count }.by(tags.count) }

        context 'when tags have images' do
          let(:tags) { create_list(:menu_tag, 3, :with_image_with_attachment) }

          it { expect { subject }.not_to change { Image.count } }
          it { expect { subject }.not_to change { ImageToRecord.count } }
          it { expect { subject }.not_to change { ActiveStorage::Attachment.count } }
          it { expect { subject }.not_to change { ActiveStorage::Blob.count } }
        end

        context 'when tags have colors' do
          let(:tags) { 3.times.map { create(:menu_tag, color: Faker::Color.hex_color) } }

          it { expect { subject }.not_to change { Menu::Tag.count } }
          it { expect { subject }.to change { Menu::TagsInDish.count }.by(tags.count) }
          it { expect(subject.result.tags.map(&:color)).to match_array(old.tags.map(&:color)) }
          it { expect(subject.result.tags.map(&:color)).to match_array(tags.map(&:color)) }
        end
      end

      context 'when providing {copy_tags: "none"}' do
        let(:params) { { old:, current_user:, copy_tags: "none" } }
        it { expect(subject.result.tags).to be_empty }
        it { expect { subject }.not_to change { Menu::Tag.count } }
        it { expect { subject }.not_to change { Menu::TagsInDish.count } }
      end
    end

    context 'when dish has allergens' do
      let(:allergens) { create_list(:menu_allergen, 3) }
      before { dish.allergens = allergens }

      context 'checking mock data' do
        it { expect(dish.allergens.count).to eq allergens.count }
        it { expect(dish.allergens.count).to be_positive }
      end

      context 'when providing {copy_allergens: "full"}' do
        let(:params) { { old:, current_user:, copy_allergens: "full" } }

        it { expect { subject }.to change { Menu::Allergen.count }.by(allergens.count) }
        it { expect { subject }.to change { Menu::AllergensInDish.count }.by(allergens.count) }
        it { expect(subject.result.allergens.map(&:id)).not_to match_array(allergens.map(&:id)) }
        it { expect(subject.result.allergens.map(&:id)).not_to match_array(old.allergens.map(&:id)) }

        context 'when allergens have images' do
          let(:allergens) { create_list(:menu_allergen, 3, :with_image_with_attachment) }

          it { expect { subject }.to change { Image.count }.by(allergens.count) }
          it { expect { subject }.to change { ImageToRecord.count }.by(allergens.count) }
          it { expect { subject }.to change { ActiveStorage::Attachment.count }.by(allergens.count) }
          it { expect { subject }.to change { ActiveStorage::Blob.count }.by(allergens.count) }
        end
      end

      context 'when providing {copy_allergens: "link"}' do
        let(:params) { { old:, current_user:, copy_allergens: "link" } }

        it { expect(subject.result.allergens).not_to be_empty }
        it { expect(subject.result.allergens.map(&:id)).to match_array(allergens.map(&:id)) }
        it { expect(subject.result.allergens.map(&:id)).to match_array(old.allergens.map(&:id)) }
        it { expect { subject }.not_to change { Menu::Allergen.count } }
        it { expect { subject }.to change { Menu::AllergensInDish.count }.by(allergens.count) }

        context 'when allergens have images' do
          let(:allergens) { create_list(:menu_allergen, 3, :with_image_with_attachment) }

          it { expect { subject }.not_to change { Image.count } }
          it { expect { subject }.not_to change { ImageToRecord.count } }
          it { expect { subject }.not_to change { ActiveStorage::Attachment.count } }
          it { expect { subject }.not_to change { ActiveStorage::Blob.count } }
        end
      end

      context 'when providing {copy_allergens: "none"}' do
        let(:params) { { old:, current_user:, copy_allergens: "none" } }
        it { expect(subject.result.allergens).to be_empty }
        it { expect { subject }.not_to change { Menu::Allergen.count } }
        it { expect { subject }.not_to change { Menu::AllergensInDish.count } }
      end
    end

    context 'when cannot save' do
      let(:allergen) { create(:menu_allergen) }
      let(:ingredient) { create(:menu_ingredient) }
      let(:tag) { create(:menu_tag) }

      before do
        dish.allergens = [allergen]
        dish.ingredients = [ingredient]
        dish.tags = [tag]
      end

      context 'allergen' do
        before do
          allow_any_instance_of(Menu::Allergen).to receive(:valid?).and_return(false)
        end

        it { expect(dish.allergens.count).to be_positive }

        it { expect { subject }.not_to change { Menu::Allergen.count } }
        it { expect { subject }.not_to change { Menu::Tag.count } }
        it { expect { subject }.not_to change { Menu::Ingredient.count } }
        it { expect { subject }.not_to change { Menu::Dish.count } }
        it { expect(subject.errors).not_to be_empty }
        it { expect(subject.errors.full_messages.join(', ')).to include('Cannot copy allergen:') }
        it { expect(subject).to be_invalid }
      end

      context 'tag' do
        before do
          allow_any_instance_of(Menu::Tag).to receive(:valid?).and_return(false)
        end

        it { expect(dish.tags.count).to be_positive }

        it { expect { subject }.not_to change { Menu::Allergen.count } }
        it { expect { subject }.not_to change { Menu::Tag.count } }
        it { expect { subject }.not_to change { Menu::Ingredient.count } }
        it { expect { subject }.not_to change { Menu::Dish.count } }
        it { expect(subject.errors).not_to be_empty }
        it { expect(subject.errors.full_messages.join(', ')).to include('Cannot copy tag:') }
        it { expect(subject).to be_invalid }
      end

      context 'ingredient' do
        before do
          allow_any_instance_of(Menu::Ingredient).to receive(:valid?).and_return(false)
        end

        it { expect(dish.ingredients.count).to be_positive }

        it { expect { subject }.not_to change { Menu::Allergen.count } }
        it { expect { subject }.not_to change { Menu::Tag.count } }
        it { expect { subject }.not_to change { Menu::Ingredient.count } }
        it { expect { subject }.not_to change { Menu::Dish.count } }
        it { expect(subject.errors).not_to be_empty }
        it { expect(subject.errors.full_messages.join(', ')).to include('Cannot copy ingredient:') }
        it { expect(subject).to be_invalid }
      end

      context 'dish' do
        before do
          allow_any_instance_of(Menu::Dish).to receive(:valid?).and_return(false)
          errors = ActiveModel::Errors.new(Menu::Dish)
          errors.add(:base, "Some error message")
          allow_any_instance_of(Menu::Dish).to receive(:errors).and_return(errors)
        end

        it { expect { subject }.not_to change { Menu::Allergen.count } }
        it { expect { subject }.not_to change { Menu::Tag.count } }
        it { expect { subject }.not_to change { Menu::Ingredient.count } }
        it { expect { subject }.not_to change { Menu::Dish.count } }
        it { expect(subject.errors).not_to be_empty }
        it { expect(subject).to be_invalid }
      end
    end
  end
end
