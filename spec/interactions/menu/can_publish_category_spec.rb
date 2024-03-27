# frozen_string_literal: true

CANNOT_PUBLISH_CATEGORY = 'cannot publish category'
RSpec.shared_examples CANNOT_PUBLISH_CATEGORY do |options = nil|
  context 'checking mock data' do
    it 'has a subject of type Menu::CanPublishCategory' do
      expect(subject).to be_a(Menu::CanPublishCategory)
    end

    it 'has a let(:category) of type Menu::Category' do
      expect(category).to eq category
      expect(category).to be_a(Menu::Category)
      expect { category }.not_to(change { Menu::Category.count })
    end
  end

  it { expect(call.result).to eq false }
  it { expect(reasons).not_to be_empty }
  it { expect { subject }.not_to(change { category.reload.visibility&.as_json }) }

  if options && options[:expected_reasons].is_a?(Array)
    options[:expected_reasons].each do |reason|
      it { expect(reasons_codes).to include(reason) }
    end
  end
end

require 'rails_helper'

RSpec.describe Menu::CanPublishCategory, type: :interaction do
  subject { call }

  let(:reasons) { call.reasons }
  let(:reasons_codes) { reasons.map { |er| er.options[:code].to_sym } }
  let(:call) { described_class.run(category:) }

  context 'cannot publish category' do
    context 'when category is not root' do
      let(:category) { create(:menu_category, visibility: nil, parent: create(:menu_category)) }

      include_examples CANNOT_PUBLISH_CATEGORY, expected_reasons: %i[category_not_root]
    end

    context 'when category has 0 dishes' do
      let(:category) { create(:menu_category) }

      it { expect(category.dishes).to be_empty }

      include_examples CANNOT_PUBLISH_CATEGORY, expected_reasons: %i[missing_dishes]
    end

    context 'when category hasnt name' do
      let(:category) { create(:menu_category) }

      it { expect(category.name).to be_nil }

      include_examples CANNOT_PUBLISH_CATEGORY, expected_reasons: %i[missing_name]
    end

    context 'when dish hasnt name' do
      let(:category) { create(:menu_category) }
      let(:dish) { create(:menu_dish) }

      before do
        category.dishes << dish
        category.reload

        Setting[:available_locales].each do |locale|
          Mobility.with_locale(locale) do
            category.name = Faker::Lorem.sentence
          end
        end

        category.save!
      end

      it { expect(category.dishes).to eq [dish] }

      include_examples CANNOT_PUBLISH_CATEGORY, expected_reasons: %i[dish_missing_name]
    end

    context 'when category has only deleted dishes' do
      let(:category) do
        cat = create(:menu_category)
        cat.dishes << create(:menu_dish, status: :deleted)
        cat.dishes << create(:menu_dish, status: :deleted)
        cat.dishes << create(:menu_dish, status: :deleted)
        cat
      end

      it { expect(category.dishes.count).to eq 3 }
      it { expect(category.dishes.visible.count).to eq 0 }
      it { expect(category.dishes.deleted.count).to eq 3 }

      include_examples CANNOT_PUBLISH_CATEGORY, expected_reasons: %i[missing_dishes]
    end

    context 'when category has no images' do
      let(:category) { create(:menu_category) }

      it { expect(category.images).to be_empty }

      include_examples CANNOT_PUBLISH_CATEGORY, expected_reasons: %i[category_has_no_images]
    end

    context 'when category has no price' do
      let(:category) do
        create(:menu_category, price: nil).tap do |cat|
          cat.dishes = create_list(:menu_dish, 3, price: nil)
        end
      end

      it { expect(category.price).to be_nil }

      include_examples CANNOT_PUBLISH_CATEGORY, expected_reasons: %i[missing_price]
    end

    context 'when has dishes without price' do
      let(:category) do
        cat = create(:menu_category, price: nil)
        cat.dishes << create(:menu_dish, price: nil)
        cat
      end
      let(:dish) { category.dishes.first }

      it { expect(dish).to be_a(Menu::Dish) }
      it { expect(category.price).to be_nil }
      it { expect(dish.price).to be_nil }
      it { expect(category.dishes.to_ary).to eq [dish] }

      include_examples CANNOT_PUBLISH_CATEGORY, expected_reasons: %i[missing_price]
    end

    context 'when has one dish and its without image' do
      let(:category) do
        cat = create(:menu_category)
        cat.dishes << create(:menu_dish)
        cat
      end

      let(:dish) { category.dishes.first }

      it { expect(dish).to be_a(Menu::Dish) }
      it { expect(dish.images).to be_empty }

      include_examples CANNOT_PUBLISH_CATEGORY, expected_reasons: %i[dish_has_no_images]
    end

    context 'when has dishes without images' do
      let(:category) do
        cat = create(:menu_category)
        cat.dishes << create(:menu_dish)
        cat.dishes << create(:menu_dish)
        cat.dishes << create(:menu_dish)
        cat
      end

      let(:dish) { category.dishes.first }

      it { expect(dish).to be_a(Menu::Dish) }
      it { expect(dish.images).to be_empty }

      include_examples CANNOT_PUBLISH_CATEGORY, expected_reasons: %i[dish_has_no_images]
    end

    context 'when has dishes without ingredients' do
      let(:category) do
        cat = create(:menu_category)
        cat.dishes << create(:menu_dish)
        cat
      end

      let(:dish) { category.dishes.first }

      it { expect(dish).to be_a(Menu::Dish) }
      it { expect(dish.ingredients).to be_empty }

      include_examples CANNOT_PUBLISH_CATEGORY, expected_reasons: %i[dish_missing_ingredients]
    end

    context 'when has invalid dishes' do
      let(:category) do
        cat = create(:menu_category)
        cat.dishes << create(:menu_dish)
        cat.dishes << create(:menu_dish)
        cat.dishes << create(:menu_dish)
        cat
      end

      before do
        category

        allow_any_instance_of(Menu::Dish).to receive(:validate).and_return(false)
        allow_any_instance_of(Menu::Dish).to receive(:valid?).and_return(false)
      end

      it { expect(category.dishes).to all(be_invalid) }

      include_examples CANNOT_PUBLISH_CATEGORY, expected_reasons: %i[dish_invalid]
    end

    context 'when category is invalid' do
      let(:category) { create(:menu_category) }

      before do
        category

        allow_any_instance_of(Menu::Category).to receive(:validate).and_return(false)
        allow_any_instance_of(Menu::Category).to receive(:valid?).and_return(false)
      end

      it { expect(category).to be_invalid }

      include_examples CANNOT_PUBLISH_CATEGORY, expected_reasons: %i[category_invalid]
    end
  end

  context 'can publish category if category and dishes are valid, have ingredients and images.' do
    let(:category) do
      create(:menu_category, images: [create(:image, :with_attached_image)])
    end

    let(:dish) do
      create(:menu_dish, images: [create(:image, :with_attached_image)], price: 15)
    end

    let(:ingredient) do
      create(:menu_ingredient)
    end

    before do
      dish.ingredients << ingredient
      category.dishes << dish
      category.reload

      Setting[:available_locales].each do |locale|
        Mobility.with_locale(locale) do
          category.name = Faker::Lorem.sentence
          dish.name = Faker::Lorem.sentence
        end
      end

      category.save!
      dish.save!
    end

    context 'checking mock data' do
      it { expect(dish).to be_valid }
      it { expect(dish).to be_persisted }
      it { expect(dish.images).not_to be_empty }

      it { expect(category).to be_valid }
      it { expect(category).to be_persisted }
      it { expect(category.images).not_to be_empty }
      it { expect(category.dishes).to eq [dish] }
      it { expect(category.name).to be_present }
    end

    it { expect(subject.reasons.full_messages).to be_empty }
  end
end
