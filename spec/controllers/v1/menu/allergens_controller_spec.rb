# frozen_string_literal: true

require "rails_helper"

MENU_ALLERGEN_ITEM_STRUCTURE = "MENU_ALLERGEN_ITEM_STRUCTURE"
RSpec.shared_context MENU_ALLERGEN_ITEM_STRUCTURE do |options = {}|
  it "includes all basic information" do
    expect(subject).to include(
      id: Integer,
      created_at: String,
      updated_at: String
    )
  end

  if options[:has_name] == true
    it "has name" do
      expect(subject).to include(
        name: String
      )
    end
  elsif options[:has_name] == false
    it "does not have name" do
      expect(subject).to include(
        name: nil
      )
    end
  end

  if options[:has_description] == true
    it "has description" do
      expect(subject).to include(
        description: String
      )
    end
  elsif options[:has_description] == false
    it "does not have description" do
      expect(subject).to include(
        description: nil
      )
    end
  end

  if options[:has_image] == true
    it "has image" do
      expect(subject[:image]).to be_a(Hash)
      # TODO: may validate image content
    end
  elsif options[:has_image] == false
    it "does not have image" do
      expect(subject).to include(image: nil)
    end
  end
end

RSpec.describe V1::Menu::AllergensController, type: :controller do
  include_context CONTROLLER_UTILS_CONTEXT
  include_context TESTS_OPTIMIZATIONS_CONTEXT

  let(:instance) { described_class.new }
  let(:user) { create(:user) }

  def create_menu_allergens(count, attrs = {})
    items = count.times.map do |_i|
      build(:menu_allergen, attrs)
    end

    Menu::Allergen.import! items, validate: false
  end

  describe "#index" do
    subject { response }

    before do
      req
    end

    it { expect(instance).to respond_to(:index) }
    it { expect(described_class).to route(:get, "/v1/menu/allergens").to(action: :index, format: :json) }

    def req(params = {})
      get :index, params:
    end

    it { is_expected.to have_http_status(:ok) }

    context "response" do
      subject { parsed_response_body }

      it { is_expected.to be_a(Hash) }
      it { is_expected.to include(items: Array, metadata: Hash) }
    end

    context "should return all allergens, paginated" do
      before do
        create_menu_allergens(10)
      end

      it { expect(Menu::Allergen.count).to eq 10 }
      it { expect(Menu::Allergen.all.pluck(:status)).to all(eq "active") }

      context "without pagination params" do
        subject { parsed_response_body }

        before do
          create_menu_allergens(20)
          req
        end

        it { expect(Menu::Allergen.count).to eq 30 }
        it { expect(Menu::Allergen.all.pluck(:status)).to all(eq "active") }

        it { expect(subject[:items].size).to eq 10 }
        it { expect(subject[:metadata][:total_count]).to eq 30 }
        it { expect(subject[:metadata][:current_page]).to eq 1 }
        it { expect(subject[:metadata][:per_page]).to eq 10 }
      end

      context "page 1" do
        subject { parsed_response_body }

        before { req(page: 1, per_page: 3) }

        it { expect(subject[:items].size).to eq 3 }
        it { expect(subject[:metadata][:total_count]).to eq 10 }
        it { expect(subject[:metadata][:current_page]).to eq 1 }
        it { expect(subject[:metadata][:per_page]).to eq 3 }
      end

      context "page 2" do
        subject { parsed_response_body }

        before { req(page: 2, per_page: 3) }

        it { expect(subject[:items].size).to eq 3 }
        it { expect(subject[:metadata][:total_count]).to eq 10 }
        it { expect(subject[:metadata][:current_page]).to eq 2 }
        it { expect(subject[:metadata][:per_page]).to eq 3 }

        context "should equal to offset 1" do
          before do
            @page1 = parsed_response_body
            req(offset: 1, per_page: 3)
            @offset0 = parsed_response_body
          end

          it { expect(@page1).to eq @offset0 }
        end
      end

      context "page 4" do
        subject { parsed_response_body }

        before { req(page: 4, per_page: 3) }

        it { expect(subject[:items].size).to eq 1 }
        it { expect(subject[:metadata][:total_count]).to eq 10 }
        it { expect(subject[:metadata][:current_page]).to eq 4 }
        it { expect(subject[:metadata][:per_page]).to eq 3 }
      end

      context "page 10" do
        subject { parsed_response_body }

        before { req(page: 10, per_page: 3) }

        it { expect(subject[:items].size).to eq 0 }
        it { expect(subject[:metadata][:total_count]).to eq 10 }
        it { expect(subject[:metadata][:current_page]).to eq 10 }
        it { expect(subject[:metadata][:per_page]).to eq 3 }
      end

      context "when calling all pages to get all allergens" do
        subject do
          req(page: 1, per_page: 5)
          @items = parsed_response_body[:items]
          req(page: 2, per_page: 5)
          @items += parsed_response_body[:items]
          req(page: 3, per_page: 5)
          @items += parsed_response_body[:items]
          @items
        end

        it { expect(subject.length).to eq 10 }
        it { expect(subject).to all(be_a(Hash)) }
        it { expect(subject.pluck(:id).uniq.count).to eq 10 }
      end
    end

    context "returned items should contain all relevant information" do
      subject { parsed_response_body[:items].first }

      let!(:image) { create(:image, :with_attached_image) }

      let!(:allergen) do
        create(:menu_allergen, name: nil, description: nil).tap do |cat|
          cat.image = image
        end
      end

      before { req }

      context "checking test data" do
        it { expect(Menu::Allergen.count).to eq 1 }
        it { expect(subject).to be_a(Hash) }
        it { expect(Menu::Allergen.find(subject[:id])).to be_a(Menu::Allergen) }
        it { expect(allergen.image).not_to be_nil }
      end

      it_behaves_like MENU_ALLERGEN_ITEM_STRUCTURE, has_name: false, has_description: false, has_image: true
    end

    context "when filtering by query" do
      before do
        5.times.each do |i|
          create(:menu_allergen, name: "Allergen ##{i + 1}!!!", description: "Description for ##{i + 1}!!!")
        end
      end

      context "checking test data" do
        it { expect(Menu::Allergen.count).to eq 5 }
        it { expect(Menu::Allergen.all).to all(be_valid) }
        it { expect(Menu::Allergen.all.map(&:name)).to all(be_present) }
        it { expect(Menu::Allergen.all.map(&:name)).to all(be_a String) }
        it { expect(Menu::Allergen.all.map(&:description)).to all(be_present) }
        it { expect(Menu::Allergen.all.map(&:description)).to all(be_a String) }
      end

      context "when querying with {query: ''} should return all items" do
        subject do
          req(query: "")
          parsed_response_body[:items]
        end

        it { expect(subject.count).to eq 5 }
        it { expect(subject.pluck(:id).uniq.count).to eq 5 }
      end

      context "when querying with {query: nil} should return all items" do
        subject do
          req(query: nil)
          parsed_response_body[:items]
        end

        it { expect(subject.count).to eq 5 }
        it { expect(subject.pluck(:id).uniq.count).to eq 5 }
      end

      context "when querying with {query: 'Allergen #1'} should return just the first item" do
        subject do
          req(query: "Allergen #1")
          parsed_response_body[:items]
        end

        it { expect(subject.count).to eq 1 }
        it { expect(subject.pluck(:id).uniq.count).to eq 1 }
        it { expect(subject.first[:name]).to eq "Allergen #1!!!" }
      end

      context "when querying with {query: 'Description for #1'} should return just the first item" do
        subject do
          req(query: "Description for #1")
          parsed_response_body[:items]
        end

        it { expect(subject.count).to eq 1 }
        it { expect(subject.pluck(:id).uniq.count).to eq 1 }
        it { expect(subject.first[:name]).to eq "Allergen #1!!!" }
        it { expect(subject.first[:description]).to eq "Description for #1!!!" }
      end

      context "when querying with {query: 'Description for #5'} should return just the first item" do
        subject do
          req(query: "Description for #5")
          parsed_response_body[:items]
        end

        it { expect(subject.count).to eq 1 }
        it { expect(subject.pluck(:id).uniq.count).to eq 1 }
        it { expect(subject.first[:name]).to eq "Allergen #5!!!" }
        it { expect(subject.first[:description]).to eq "Description for #5!!!" }
      end
    end

    context "should return only non-deleted items" do
      subject do
        req
        parsed_response_body[:items]
      end

      before do
        create(:menu_allergen, status: :active)
        create(:menu_allergen, status: :deleted)
      end

      it { expect(Menu::Allergen.count).to eq 2 }
      it { expect(Menu::Allergen.visible.count).to eq 1 }
      it { expect(subject).to all(include(status: "active")) }
      it { expect(subject.size).to eq 1 }
    end

    context "when providing {avoid_associated_dish_id: <DishId>}" do
      let(:dish) { create(:menu_dish) }

      before do
        create_list(:menu_allergen, 3)
        dish.allergens = [Menu::Allergen.all.sample]
        req(avoid_associated_dish_id: dish.id)
        create(:menu_dish).allergens = Menu::Allergen.all
      end

      it { expect(response).to have_http_status(:ok) }
      it { expect(parsed_response_body).not_to include(message: String) }
      it { expect(parsed_response_body[:items].count).to eq 2 }
    end

    context "when providing {associated_dish_id: <DishId>}" do
      let(:dish) { create(:menu_dish) }

      before do
        create_list(:menu_allergen, 3)
        dish.allergens = [Menu::Allergen.all.sample]
        req(associated_dish_id: dish.id)
        create(:menu_dish).allergens = Menu::Allergen.all
      end

      it { expect(response).to have_http_status(:ok) }
      it { expect(parsed_response_body).not_to include(message: String) }
      it { expect(parsed_response_body[:items].count).to eq 1 }
      it { expect(parsed_response_body.dig(:items, 0, :id)).to eq dish.allergens.first.id }
    end
  end

  describe "#show" do
    def req(params = {})
      get :show, params:
    end

    let(:allergen) { create(:menu_allergen) }

    it { expect(instance).to respond_to(:show) }
    it { expect(described_class).to route(:get, "/v1/menu/allergens/2").to(action: :show, format: :json, id: 2) }

    context "basic" do
      subject do
        req(id: allergen.id)
        parsed_response_body[:item]
      end

      let(:allergen) { create(:menu_allergen, name: nil, description: nil) }

      it { expect(allergen).to be_valid }

      it { expect(response).to be_successful }
      it { expect(response).to have_http_status(:ok) }

      it_behaves_like MENU_ALLERGEN_ITEM_STRUCTURE, has_name: false, has_description: false, has_image: false
    end

    context "when passing a invalid id" do
      subject { response }

      before { req(id: "invalid") }

      it_behaves_like NOT_FOUND
    end

    context "when passing a invalid id" do
      subject { response }

      before { req(id: 999_999) }

      it_behaves_like NOT_FOUND
    end

    context "when allergen has image" do
      subject do
        req(id: allergen.id)
        parsed_response_body[:item]
      end

      let(:allergen) { create(:menu_allergen, name: nil, description: nil) }

      before { allergen.image = create(:image, :with_attached_image) }

      it { expect(allergen).to be_valid }
      it { expect(response).to have_http_status(:ok) }

      it_behaves_like MENU_ALLERGEN_ITEM_STRUCTURE, has_name: false, has_description: false, has_image: true
    end

    context "when allergen has name" do
      subject { parsed_response_body[:item] }

      let(:allergen) { create(:menu_allergen, description: nil, name: nil) }

      before do
        allergen.update!(name: "test")
        allergen.reload
        req(id: allergen.id)
      end

      it { expect(allergen.name).to eq "test" }

      it { expect(allergen).to be_valid }
      it { expect(response).to have_http_status(:ok) }

      it_behaves_like MENU_ALLERGEN_ITEM_STRUCTURE, has_name: true, has_description: false, has_image: false
      it { is_expected.to include(name: "test") }
      it { is_expected.to include(translations: Hash) }
      it { expect(subject[:translations]).to include(name: Hash) }
      it { expect(subject.dig(:translations, :name)).to include(en: "test") }
    end

    context "when allergen has description (in another language)" do
      subject { parsed_response_body[:item] }

      before do
        @initial_lang = I18n.locale
        I18n.locale = (I18n.available_locales - [I18n.default_locale]).sample
        allergen.update!(description: "test-#{I18n.locale}")
        allergen.reload
        req(id: allergen.id, lang: I18n.locale)
      end

      after do
        I18n.locale = @initial_lang
        @initial_lang = nil
      end

      it { expect(allergen.description).to eq "test-#{I18n.locale}" }

      it { expect(allergen).to be_valid }
      it { expect(response).to have_http_status(:ok) }

      it_behaves_like MENU_ALLERGEN_ITEM_STRUCTURE, has_name: true, has_description: true
      it { is_expected.to include(description: "test-#{I18n.locale}") }
    end
  end
end
