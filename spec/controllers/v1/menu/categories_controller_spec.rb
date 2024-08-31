# frozen_string_literal: true

require "rails_helper"

RSpec.describe V1::Menu::CategoriesController, type: :controller do
  include_context CONTROLLER_UTILS_CONTEXT
  include_context TESTS_OPTIMIZATIONS_CONTEXT

  let(:instance) { described_class.new }

  def create_menu_categories(count, attrs = {})
    create_list(:menu_category, count, attrs)
  end

  describe "#index" do
    it { expect(instance).to respond_to(:index) }
    it { expect(described_class).to route(:get, "/v1/menu/categories").to(action: :index, format: :json) }

    def req(params = {})
      get :index, params:
    end

    context "basic" do
      subject { response }

      before do
        req
      end

      it { is_expected.to have_http_status(:ok) }

      context "response" do
        subject { parsed_response_body }

        it { is_expected.to be_a(Hash) }
        it { is_expected.to include(items: Array, metadata: Hash) }
      end
    end

    context "should return all categories, paginated" do
      before do
        create_menu_categories(10)
      end

      it { expect(Menu::Category.count).to eq 10 }
      it { expect(Menu::Category.all.pluck(:status)).to all(eq "active") }

      context "without pagination params" do
        subject { parsed_response_body }

        before do
          create_menu_categories(20)
          req
        end

        it { expect(Menu::Category.count).to eq 30 }
        it { expect(Menu::Category.all.pluck(:status)).to all(eq "active") }

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

      context "when calling all pages to get all categories" do
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

    context "returned items should be ordered by :index by default" do
      before { create_menu_categories(2) }

      it { expect(Menu::Category.count).to eq 2 }
      it { expect(Menu::Category.all.pluck(:status)).to all(eq "active") }
      it { expect(Menu::Category.all.pluck(:index).sort!).to eq [0, 1].sort! }

      context "simple case - no params" do
        subject { parsed_response_body[:items] }

        before { req }

        it { expect(subject).to be_a(Array) }
        it { expect(subject.count).to eq 2 }
        it { expect(subject[0][:index]).to eq 0 }
        it { expect(subject[1][:index]).to eq 1 }
      end

      context "by switching indexes" do
        # it { expect(Menu::Category.all.order(:index).pluck(:index)).to eq [1, 3, 4, 10] }

        subject { parsed_response_body[:items] }

        before do
          Menu::Category.all.map do |item|
            item.update!(index: item.index + 2)
          end

          @first = Menu::Category.create!(index: 1)
          @last = Menu::Category.create!(index: 10)
          req
        end

        it { expect(Menu::Category.count).to eq 4 }

        it { expect(subject).to be_a(Array) }
        it { expect(subject.pluck(:id)).to eq Menu::Category.order(:index).pluck(:id) }
      end
    end

    context "can exclude items by id with ?except=<id>" do
      subject { parsed_response_body[:items] }

      before do
        create_menu_categories(2)
        @excluded = Menu::Category.first
        req(except: @excluded.id)
      end

      it { expect(Menu::Category.count).to eq 2 }
      it { expect(Menu::Category.all.pluck(:status)).to all(eq "active") }

      it { expect(subject.count).to eq 1 }
      it { expect(subject.pluck(:id).uniq.count).to eq 1 }
      it { expect(subject.first[:id]).to eq Menu::Category.last.id }
    end

    %w[root root_only without_parent].each do |param_name|
      ["true", "t", "1", true, 1].each do |param_value|
        context "when filtering by { #{param_name.inspect}: #{param_value.inspect} } should return only categories without parent" do
          subject { parsed_response_body[:items] }

          let!(:parent) { create(:menu_category) }
          let!(:children) { create_list(:menu_category, 2, parent:, visibility: nil) }

          before do
            req(param_name => param_value)
          end

          it { expect(Menu::Category.count).to eq 3 }
          it { expect(Menu::Category.where(parent_id: nil).count).to eq 1 }
          it { expect(Menu::Category.where.not(parent_id: nil).count).to eq 2 }

          it { expect(subject.count).to eq 1 }
          it { expect(subject.pluck(:id).uniq).to match_array(Menu::Category.without_parent.pluck(:id)) }
          it { expect(subject.pluck(:parent_id)).to all(be_nil) }
        end
      end
    end

    context "returned items should contain all relevant information" do
      subject { parsed_response_body[:items].first }

      let!(:images) { create_list(:image, 2, :with_attached_image) }

      let!(:category) do
        create(:menu_category).tap do |cat|
          cat.images << images
        end
      end

      before { req }

      context "checking test data" do
        it { expect(Menu::Category.count).to eq 1 }
        it { expect(subject).to be_a(Hash) }
        it { expect(Menu::Category.find(subject[:id])).to be_a(Menu::Category) }
        it { expect(category.visibility).to be_present }
        it { expect(category.images).not_to be_empty }
        it { expect(category.images.count).to be_positive }
      end

      it_behaves_like MENU_CATEGORY_STRUCTURE
      it {
        expect(subject).to include(
          parent_id: NilClass,
          name: NilClass,
          description: NilClass
        )
      }

      it { expect(subject[:images].count).to eq 2 }
    end

    context "when filtering by parent_id" do
      before do
        @parent = create(:menu_category)
        create_list(:menu_category, 2, visibility: nil, parent: @parent)
        create_list(:menu_category, 2)
      end

      context "checking test data" do
        it { expect(Menu::Category.count).to eq 2 + 2 + 1 }
        it { expect(Menu::Category.where(parent_id: nil).count).to eq 2 + 1 }
        it { expect(Menu::Category.where.not(parent_id: nil).count).to eq 2 }
      end

      context "<id>: after request" do
        before { req(parent_id: @parent.id) }

        context "response" do
          subject { parsed_response_body[:items] }

          it { expect(subject.count).to eq 2 }
          it { expect(subject.pluck(:id).uniq.count).to eq 2 }

          it {
            expect(Menu::Category.where(id: subject.pluck(:id).uniq).pluck(:id)).to match_array(Menu::Category.where(parent: @parent).pluck(:id))
          }
        end

        context "metadata" do
          subject { parsed_response_body[:metadata] }

          it { expect(subject[:total_count]).to eq 2 }
          it { expect(subject[:current_page]).to eq 1 }
          it { expect(subject[:per_page]).to eq 10 }
          it { expect(subject[:params]).to be_a(Hash) }
          it { expect(subject[:params]).to include("parent_id" => @parent.id) }
        end
      end

      context "nil: after request" do
        before { req(parent_id: nil) }

        context "response" do
          subject { parsed_response_body[:items] }

          it { expect(subject.count).to eq 3 }
          it { expect(subject.pluck(:id).uniq.count).to eq 3 }

          it {
            expect(Menu::Category.where(id: subject.pluck(:id).uniq).pluck(:id)).to match_array(Menu::Category.where(parent_id: nil).pluck(:id))
          }
        end

        context "metadata" do
          subject { parsed_response_body[:metadata] }

          it { expect(subject[:total_count]).to eq 3 }
          it { expect(subject[:current_page]).to eq 1 }
          it { expect(subject[:per_page]).to eq 10 }
          it { expect(subject[:params]).to be_a(Hash) }
          it { expect(subject[:params]).to include("parent_id" => "") }
        end
      end
    end

    context "when filtering by query" do
      before do
        # visibility = create(:menu_visibility)
        items = 5.times.map do |i|
          create(:menu_category, name: "Category ##{i + 1}!!!", description: "Description for ##{i + 1}!!!")
        end

        # Menu::Category.import! items, validate: false
      end

      context "checking test data" do
        it { expect(Menu::Category.count).to eq 5 }
        it { expect(Menu::Category.all).to all(be_valid) }
        it { expect(Menu::Category.all.map(&:name)).to all(be_present) }
        it { expect(Menu::Category.all.map(&:name)).to all(be_a String) }
        it { expect(Menu::Category.all.map(&:description)).to all(be_present) }
        it { expect(Menu::Category.all.map(&:description)).to all(be_a String) }
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

      context "when querying with {query: 'Category #1'} should return just the first item" do
        subject do
          req(query: "Category #1")
          parsed_response_body[:items]
        end

        it { expect(subject.count).to eq 1 }
        it { expect(subject.pluck(:id).uniq.count).to eq 1 }
        it { expect(subject.first[:name]).to eq "Category #1!!!" }
      end

      context "when querying with {query: 'Description for #1'} should return just the first item" do
        subject do
          req(query: "Description for #1")
          parsed_response_body[:items]
        end

        it { expect(subject.count).to eq 1 }
        it { expect(subject.pluck(:id).uniq.count).to eq 1 }
        it { expect(subject.first[:name]).to eq "Category #1!!!" }
        it { expect(subject.first[:description]).to eq "Description for #1!!!" }
      end

      context "when querying with {query: 'Description for #5'} should return just the first item" do
        subject do
          req(query: "Description for #5")
          parsed_response_body[:items]
        end

        it { expect(subject.count).to eq 1 }
        it { expect(subject.pluck(:id).uniq.count).to eq 1 }
        it { expect(subject.first[:name]).to eq "Category #5!!!" }
        it { expect(subject.first[:description]).to eq "Description for #5!!!" }
      end
    end

    context "when filtering by {fixed_price: true}" do
      before do
        # visibility = create(:menu_visibility)
        items = 5.times.map do |i|
          create(:menu_category, price: (i + 1) * 10)
        end

        create_list(:menu_category, 5, price: nil)

        # Menu::Category.import! items, validate: false
      end

      context "checking test data" do
        subject { Menu::Category.all }

        it do
          expect(subject.map(&:price).uniq).to contain_exactly(nil, 10, 20, 30, 40, 50)
          expect(subject.map(&:price?)).to match_array(([false] * 5) + ([true] * 5))
          expect(subject.count).to eq 10
        end
      end

      context "when querying with {fixed_price: true}" do
        before { req(fixed_price: true) }

        context "items" do
          subject { parsed_response_body[:items] }

          it { expect(subject.count).to eq 5 }
          it { expect(subject.pluck(:id).uniq.count).to eq 5 }
          it { expect(subject.pluck(:price).uniq).to all(be_positive) }
          it { expect(subject.pluck(:price).uniq).to all(be_a(Numeric)) }
        end

        context "metadata" do
          subject { parsed_response_body[:metadata] }

          it { is_expected.to be_a(Hash) }
          it { is_expected.to include(params: { fixed_price: true }) }
        end
      end
    end

    context "when filtering for {fixed_price: false}" do
      before do
        # visibility = create(:menu_visibility)
        items = 5.times.map do |i|
          create(:menu_category, price: (i + 1) * 10)
        end

        create_list(:menu_category, 5, price: nil)

        # Menu::Category.import! items, validate: false
      end

      context "checking test data" do
        subject { Menu::Category.all }

        it do
          expect(subject.map(&:price).uniq).to contain_exactly(nil, 10, 20, 30, 40, 50)
          expect(subject.map(&:price?)).to match_array(([false] * 5) + ([true] * 5))
          expect(subject.count).to eq 10
        end
      end

      context "when querying with {fixed_price: false}" do
        before { req(fixed_price: false) }

        context "items" do
          subject { parsed_response_body[:items] }

          it { expect(subject.count).to eq 5 }
          it { expect(subject.pluck(:id).uniq.count).to eq 5 }
          it { expect(subject.pluck(:price).uniq).to eq [nil] }
        end

        context "metadata" do
          subject { parsed_response_body[:metadata] }

          it { is_expected.to be_a(Hash) }
          it { is_expected.to include(params: { fixed_price: false }) }
        end
      end
    end

    context "should return only non-deleted items" do
      subject do
        req
        parsed_response_body[:items]
      end

      before do
        create(:menu_category, status: :active)
        create(:menu_category, status: :deleted)
      end

      it { expect(Menu::Category.count).to eq 2 }
      it { expect(Menu::Category.visible.count).to eq 1 }
      it { expect(subject).to all(include(status: "active")) }
      it { expect(subject.size).to eq 1 }
    end
  end

  describe "#show" do
    def req(params = {})
      get :show, params:
    end

    let(:category) { create(:menu_category) }

    it { expect(instance).to respond_to(:show) }
    it { expect(described_class).to route(:get, "/v1/menu/categories/2").to(action: :show, format: :json, id: 2) }

    context "basic" do
      subject do
        req(id: category.id)
        parsed_response_body[:item]
      end

      it { expect(category).to be_valid }
      it { expect(category.visibility).to be_persisted }

      it { expect(response).to be_successful }
      it { expect(response).to have_http_status(:ok) }

      it_behaves_like MENU_CATEGORY_STRUCTURE
      it {
        expect(subject).to include(
          parent_id: NilClass,
          name: NilClass,
          description: NilClass
        )
      }

      it { expect(subject[:images].count).to eq 0 }
    end

    context "should include translations" do
      subject { parsed_response_body[:item] }

      before do
        Mobility.with_locale(:en) { category.update(name: "test-en") }
        Mobility.with_locale(:it) { category.update(name: "test-it") }

        req(id: category.id)
      end

      it do
        expect(subject).to include(translations: Hash)
        expect(subject[:translations]).to include(name: Hash)
        expect(subject.dig(:translations, :name)).to include(en: "test-en")
        expect(subject.dig(:translations, :name)).to include(it: "test-it")
      end
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

    context "when category has images" do
      subject do
        req(id: category.id)
        parsed_response_body[:item]
      end

      before { category.images << create_list(:image, 2, :with_attached_image) }

      it { expect(category).to be_valid }
      it { expect(response).to have_http_status(:ok) }

      it_behaves_like MENU_CATEGORY_STRUCTURE
      it {
        expect(subject).to include(
          parent_id: NilClass,
          name: NilClass,
          description: NilClass
        )
      }

      it { expect(subject[:images].count).to eq 2 }
    end

    context "when category has parent" do
      subject do
        req(id: category.id)
        parsed_response_body[:item]
      end

      let(:parent) { create(:menu_category) }
      let(:category) { create(:menu_category, parent:, visibility: nil) }

      it { expect(category).to be_valid }
      it { expect(category.parent).to be_a(Menu::Category) }
      it { expect(response).to have_http_status(:ok) }

      it_behaves_like MENU_CATEGORY_STRUCTURE, skip_visibility: true
      it {
        expect(subject).to include(
          parent_id: Integer,
          name: NilClass,
          description: NilClass,
          parent: Hash
        )
      }
    end

    context "when category has name" do
      subject { parsed_response_body[:item] }

      before do
        category.update!(name: "test")
        category.reload
        req(id: category.id)
      end

      it { expect(category.name).to eq "test" }

      it { expect(category).to be_valid }
      it { expect(response).to have_http_status(:ok) }

      it_behaves_like MENU_CATEGORY_STRUCTURE
      it { is_expected.to include(name: "test") }
    end

    context "when category has description (in another language)" do
      subject { parsed_response_body[:item] }

      before do
        I18n.locale = (I18n.available_locales - [I18n.default_locale]).sample
        category.update!(description: "test-#{I18n.locale}")
        category.reload
        req(id: category.id, locale: I18n.locale)
      end

      after { I18n.locale = I18n.default_locale }

      it { expect(category.description).to eq "test-#{I18n.locale}" }

      it { expect(category).to be_valid }
      it { expect(response).to have_http_status(:ok) }

      it_behaves_like MENU_CATEGORY_STRUCTURE
      it { is_expected.to include(description: "test-#{I18n.locale}") }
    end
  end
end
