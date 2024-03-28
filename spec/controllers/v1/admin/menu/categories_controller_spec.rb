# frozen_string_literal: true

require "rails_helper"

RSpec.describe V1::Admin::Menu::CategoriesController, type: :controller do
  include_context CONTROLLER_UTILS_CONTEXT
  include_context CONTROLLER_AUTHENTICATION_CONTEXT
  include_context TESTS_OPTIMIZATIONS_CONTEXT

  let(:instance) { described_class.new }

  def create_menu_categories(count, attrs = {})
    create_list(:menu_category, count, attrs)
    # attrs[:menu_visibility] ||= create(:menu_visibility)
    #
    # items = count.times.map do |i|
    #   build(:menu_category, attrs.merge(index: i))
    # end
    #
    # Menu::Category.import! items, validate: false
  end

  describe "#index" do
    it { expect(instance).to respond_to(:index) }
    it { expect(described_class).to route(:get, "/v1/admin/menu/categories").to(action: :index, format: :json) }

    def req(params = {})
      get :index, params:
    end

    context "when user is not authenticated" do
      before { req }

      it_behaves_like UNAUTHORIZED
    end

    context "when user is authenticated" do
      subject { response }

      before do
        authenticate_request
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
        authenticate_request
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
        it { expect(subject.map { |j| j[:id] }.uniq.count).to eq 10 }
      end
    end

    context "(authenticated)" do
      before { authenticate_request }

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
          it { expect(subject.map { |j| j[:id] }).to eq Menu::Category.order(:index).pluck(:id) }
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
        it { expect(subject.map { |j| j[:id] }.uniq.count).to eq 1 }
        it { expect(subject.first[:id]).to eq Menu::Category.last.id }
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

        it_behaves_like ADMIN_MENU_CATEGORY
        it {
          expect(subject).to include(
            parent_id: NilClass,
            name: NilClass,
            description: NilClass,
            secret_desc: NilClass
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
            it { expect(subject.map { |j| j[:id] }.uniq.count).to eq 2 }

            it {
              expect(Menu::Category.where(id: subject.map do |j|
                                                j[:id]
                                              end.uniq).pluck(:id)).to match_array(Menu::Category.where(parent: @parent).pluck(:id))
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
            it { expect(subject.map { |j| j[:id] }.uniq.count).to eq 3 }

            it {
              expect(Menu::Category.where(id: subject.map do |j|
                                                j[:id]
                                              end.uniq).pluck(:id)).to match_array(Menu::Category.where(parent_id: nil).pluck(:id))
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
          it { expect(subject.map { |j| j[:id] }.uniq.count).to eq 5 }
        end

        context "when querying with {query: nil} should return all items" do
          subject do
            req(query: nil)
            parsed_response_body[:items]
          end

          it { expect(subject.count).to eq 5 }
          it { expect(subject.map { |j| j[:id] }.uniq.count).to eq 5 }
        end

        context "when querying with {query: 'Category #1'} should return just the first item" do
          subject do
            req(query: "Category #1")
            parsed_response_body[:items]
          end

          it { expect(subject.count).to eq 1 }
          it { expect(subject.map { |j| j[:id] }.uniq.count).to eq 1 }
          it { expect(subject.first[:name]).to eq "Category #1!!!" }
        end

        context "when querying with {query: 'Description for #1'} should return just the first item" do
          subject do
            req(query: "Description for #1")
            parsed_response_body[:items]
          end

          it { expect(subject.count).to eq 1 }
          it { expect(subject.map { |j| j[:id] }.uniq.count).to eq 1 }
          it { expect(subject.first[:name]).to eq "Category #1!!!" }
          it { expect(subject.first[:description]).to eq "Description for #1!!!" }
        end

        context "when querying with {query: 'Description for #5'} should return just the first item" do
          subject do
            req(query: "Description for #5")
            parsed_response_body[:items]
          end

          it { expect(subject.count).to eq 1 }
          it { expect(subject.map { |j| j[:id] }.uniq.count).to eq 1 }
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
            it { expect(subject.map { |j| j[:id] }.uniq.count).to eq 5 }
            it { expect(subject.map { |j| j[:price] }.uniq).to all(be_positive) }
            it { expect(subject.map { |j| j[:price] }.uniq).to all(be_a(Numeric)) }
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
            it { expect(subject.map { |j| j[:id] }.uniq.count).to eq 5 }
            it { expect(subject.map { |j| j[:price] }.uniq).to eq [nil] }
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
  end

  describe "#show" do
    def req(params = {})
      get :show, params:
    end

    let(:category) { create(:menu_category) }

    it { expect(instance).to respond_to(:show) }
    it { expect(described_class).to route(:get, "/v1/admin/menu/categories/2").to(action: :show, format: :json, id: 2) }

    context "if user is unauthorized" do
      before { req(id: category.id) }

      it_behaves_like UNAUTHORIZED
    end

    context "(authenticated)" do
      before { authenticate_request }

      context "basic" do
        subject do
          req(id: category.id)
          parsed_response_body[:item]
        end

        it { expect(category).to be_valid }
        it { expect(category.visibility).to be_persisted }

        it { expect(response).to be_successful }
        it { expect(response).to have_http_status(:ok) }

        it_behaves_like ADMIN_MENU_CATEGORY
        it {
          expect(subject).to include(
            parent_id: NilClass,
            name: NilClass,
            description: NilClass,
            secret_desc: NilClass
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

        it_behaves_like ADMIN_MENU_CATEGORY
        it {
          expect(subject).to include(
            parent_id: NilClass,
            name: NilClass,
            description: NilClass,
            secret_desc: NilClass
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

        it_behaves_like ADMIN_MENU_CATEGORY, skip_visibility: true
        it {
          expect(subject).to include(
            parent_id: Integer,
            name: NilClass,
            description: NilClass,
            secret_desc: NilClass,
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

        it_behaves_like ADMIN_MENU_CATEGORY
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

        it_behaves_like ADMIN_MENU_CATEGORY
        it { is_expected.to include(description: "test-#{I18n.locale}") }
      end
    end
  end

  describe "#dashboard_data" do
    let(:category) { create(:menu_category) }

    let(:params) { { id: menu_category.id } }

    def req(req_params = params)
      get :dashboard_data, params: req_params
    end

    it { expect(instance).to respond_to(:dashboard_data) }

    it {
      expect(described_class).to route(:get, "/v1/admin/menu/categories/2/dashboard_data").to(action: :dashboard_data,
                                                                                              format: :json, id: 2)
    }

    it {
      expect(described_class).to route(:get, "/v1/admin/menu/categories/100/dashboard_data").to(action: :dashboard_data,
                                                                                                format: :json, id: 100)
    }

    context "if user is unauthorized" do
      before { req(id: category.id) }

      it_behaves_like UNAUTHORIZED
    end

    context "(authenticated)" do
      before { authenticate_request }

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

      context "when has parents, should return breadcrumbs" do
        subject { parsed_response_body }

        before do
          @grandparent = create(:menu_category)
          create_list(:menu_category, 2, visibility: nil, parent: @grandparent)

          @parent = create(:menu_category, visibility: nil, parent: @grandparent)
          create_list(:menu_category, 2, visibility: nil, parent: @parent)

          @child = create(:menu_category, visibility: nil, parent: @parent)
          create_list(:menu_category, 2, visibility: nil, parent: @child)
          req(id: @child.id)
        end

        it { expect(response).to have_http_status(:ok) }
        it { expect(subject).not_to include(message: String) }

        it do
          expect(subject).to include(breadcrumbs: Array)
          expect(subject[:breadcrumbs]).not_to be_empty
          expect(subject[:breadcrumbs].count).to eq 3
          expect(subject[:breadcrumbs].first).to be_a(Hash)
          expect(subject[:breadcrumbs].last).to include(id: @child.id)
          expect(subject[:breadcrumbs].second).to include(id: @parent.id)
          expect(subject[:breadcrumbs].first).to include(id: @grandparent.id)
        end
      end
    end
  end

  describe "#create" do
    it { expect(instance).to respond_to(:create) }
    it { expect(described_class).to route(:post, "/v1/admin/menu/categories").to(action: :create, format: :json) }

    def req(params = {})
      post :create, params:
    end

    context "when user is not authenticated" do
      before { req }

      it_behaves_like UNAUTHORIZED
    end

    context "(authenticated)" do
      before { authenticate_request }

      it { expect { req }.to change(Menu::Category, :count).by(1) }

      context "basic" do
        subject do
          req
          parsed_response_body[:item]
        end

        it { expect(response).to have_http_status(:ok) }
        it { expect(response).to be_successful }

        it_behaves_like ADMIN_MENU_CATEGORY
        it {
          expect(subject).to include(
            parent_id: NilClass,
            name: NilClass,
            description: NilClass,
            secret_desc: NilClass
          )
        }

        it { expect(subject[:images].count).to eq 0 }
      end

      context "passing {parent_id: <id>}" do
        subject do
          req(parent_id: parent.id)
          response
        end

        let!(:parent) { create(:menu_category) }

        it "request should create a category child" do
          expect { subject }.to change(Menu::Category, :count).by(1)
          expect(Menu::Category.count).to eq 2
          expect(Menu::Category.with_parent.last.parent).to eq parent
          expect(Menu::Category.with_parent.count).to eq 1
          expect(Menu::Category.without_parent.count).to eq 1
        end

        it { is_expected.to have_http_status(:ok) }
        it { is_expected.to be_successful }

        context "response[:item]" do
          subject do
            req(parent_id: parent.id)
            parsed_response_body[:item]
          end

          it_behaves_like ADMIN_MENU_CATEGORY, skip_visibility: true

          it {
            expect(subject).to include(
              parent_id: Integer,
              name: NilClass,
              description: NilClass,
              secret_desc: NilClass
            )
          }

          it { expect(subject[:images].count).to eq 0 }
        end
      end

      context "passing {} (empty hash)" do
        subject do
          req
          response
        end

        it "request should create a category" do
          expect { subject }.to change(Menu::Category, :count).by(1)
          expect(Menu::Category.count).to eq 1
          expect(Menu::Category.with_parent.count).to eq 0
          expect(Menu::Category.without_parent.count).to eq 1
        end

        it { is_expected.to have_http_status(:ok) }
        it { is_expected.to be_successful }

        context "response[:item]" do
          subject do
            req
            parsed_response_body[:item]
          end

          it_behaves_like ADMIN_MENU_CATEGORY

          it {
            expect(subject).to include(
              parent_id: NilClass,
              name: NilClass,
              description: NilClass,
              secret_desc: NilClass
            )
          }

          it { expect(subject[:images].count).to eq 0 }
        end
      end

      context "passing {name: <String>}" do
        subject do
          req(name: "test")
          response
        end

        it "request should create a category" do
          expect { subject }.to change(Menu::Category, :count).by(1)
          expect(Menu::Category.count).to eq 1
          expect(Menu::Category.with_parent.count).to eq 0
          expect(Menu::Category.without_parent.count).to eq 1
        end

        it { is_expected.to have_http_status(:ok) }
        it { is_expected.to be_successful }

        context "response[:item]" do
          subject do
            req(name: "test")
            parsed_response_body[:item]
          end

          it_behaves_like ADMIN_MENU_CATEGORY

          it {
            expect(subject).to include(
              parent_id: NilClass,
              name: "test",
              description: NilClass,
              secret_desc: NilClass
            )
          }

          it { expect(subject[:images].count).to eq 0 }
        end
      end

      context "passing {description: <String>}" do
        subject do
          req(description: "test")
          response
        end

        it "request should create a category" do
          expect { subject }.to change(Menu::Category, :count).by(1)
          expect(Menu::Category.count).to eq 1
          expect(Menu::Category.with_parent.count).to eq 0
          expect(Menu::Category.without_parent.count).to eq 1
        end

        it { is_expected.to have_http_status(:ok) }
        it { is_expected.to be_successful }

        context "response[:item]" do
          subject do
            req(description: "test")
            parsed_response_body[:item]
          end

          it_behaves_like ADMIN_MENU_CATEGORY

          it {
            expect(subject).to include(
              parent_id: NilClass,
              name: NilClass,
              description: "test",
              secret_desc: NilClass
            )
          }

          it { expect(subject[:images].count).to eq 0 }
        end
      end

      context "passing {name: <String>, description: <String>, parent_id: <id>}" do
        subject do
          req(name: "test", description: "test", parent_id: parent.id)
          response
        end

        let!(:parent) { create(:menu_category) }

        it "request should create a category" do
          expect { subject }.to change(Menu::Category, :count).by(1)
          expect(Menu::Category.count).to eq 2
          expect(Menu::Category.with_parent.count).to eq 1
          expect(Menu::Category.without_parent.count).to eq 1
        end

        it { is_expected.to have_http_status(:ok) }
        it { is_expected.to be_successful }

        context "response[:item]" do
          subject do
            req(name: "test", description: "test", parent_id: parent.id)
            parsed_response_body[:item]
          end

          it_behaves_like ADMIN_MENU_CATEGORY, skip_visibility: true

          it {
            expect(subject).to include(
              parent_id: Integer,
              name: "test",
              description: "test",
              secret_desc: NilClass
            )
          }

          it { expect(subject[:images].count).to eq 0 }
        end
      end

      context "passing {name: {it: <String>, en: <String>}}" do
        subject do
          req(name: { it: "test-it", en: "test-en" })
          response
        end

        it "request should create a category" do
          expect { subject }.to change(Menu::Category, :count).by(1)
          expect(Menu::Category.count).to eq 1
          expect(Menu::Category.with_parent.count).to eq 0
          expect(Menu::Category.without_parent.count).to eq 1
        end

        it { is_expected.to have_http_status(:ok) }
        it { is_expected.to be_successful }

        context "response[:item]" do
          subject do
            req(name: { it: "test-it", en: "test-en" })
            parsed_response_body[:item]
          end

          it_behaves_like ADMIN_MENU_CATEGORY

          it {
            expect(subject).to include(
              parent_id: NilClass,
              name: "test-#{I18n.locale}",
              description: NilClass,
              secret_desc: NilClass
            )
          }

          it { expect(subject[:images].count).to eq 0 }
        end
      end

      context "passing {description: {it: <String>, en: <String>}}" do
        subject do
          req(description: { it: "test-it", en: "test-en" })
          response
        end

        it "request should create a category" do
          expect { subject }.to change(Menu::Category, :count).by(1)
          expect(Menu::Category.count).to eq 1
          expect(Menu::Category.with_parent.count).to eq 0
          expect(Menu::Category.without_parent.count).to eq 1
        end

        it { is_expected.to have_http_status(:ok) }
        it { is_expected.to be_successful }

        context "response[:item]" do
          subject do
            req(description: { it: "test-it", en: "test-en" })
            parsed_response_body[:item]
          end

          it_behaves_like ADMIN_MENU_CATEGORY

          it {
            expect(subject).to include(
              parent_id: NilClass,
              name: NilClass,
              description: "test-#{I18n.locale}",
              secret_desc: NilClass
            )
          }

          it { expect(subject[:images].count).to eq 0 }
        end
      end

      context "passing {name: {it: <String>, invalid_locale: <String>}}" do
        subject do
          req(name: { it: "test-it", invalid_locale: "test-invalid" })
          response
        end

        it do
          expect { subject }.not_to change(Menu::Category, :count)
          expect(Menu::Category.count).to eq 0
        end

        it { is_expected.to have_http_status(:unprocessable_entity) }
        it { is_expected.not_to be_successful }

        context "response[:item]" do
          subject do
            req(name: { it: "test-it", invalid_locale: "test-invalid" })
            parsed_response_body[:item]
          end

          it { is_expected.to be_nil }
        end

        context "response[:message]" do
          subject do
            req(name: { it: "test-it", invalid_locale: "test-invalid" })
            parsed_response_body[:message]
          end

          it { is_expected.to be_a(String) }
          it { is_expected.to include(I18n.t("errors.messages.invalid_locale", lang: :invalid_locale)) }
        end

        context "response[:details]" do
          subject do
            req(name: { it: "test-it", invalid_locale: "test-invalid" })
            parsed_response_body[:details]
          end

          it { is_expected.to be_a(Hash) }
          it { is_expected.to include(:name) }
          it { is_expected.to include(name: Array) }
        end

        context "response[:details][:name]" do
          subject do
            req(name: { it: "test-it", invalid_locale: "test-invalid" })
            parsed_response_body[:details][:name]
          end

          it { is_expected.to be_a(Array) }
          it { is_expected.not_to be_empty }
          it { is_expected.to all(be_a(Hash)) }
          it { is_expected.to all(include(:attribute, :raw_type, :type, :options, :message)) }
        end
      end
    end
  end

  describe "#update" do
    it { expect(instance).to respond_to(:update) }

    it {
      expect(described_class).to route(:patch, "/v1/admin/menu/categories/22").to(action: :update, format: :json,
                                                                                  id: 22)
    }

    def req(params = {})
      patch :update, params:
    end

    context "when user is not authenticated" do
      before { req(id: 22) }

      it_behaves_like UNAUTHORIZED
    end

    context "(authenticated)" do
      before { authenticate_request }

      context "basic" do
        subject do
          req(id: category.id)
          parsed_response_body[:item]
        end

        let!(:category) { create(:menu_category) }

        it { expect(response).to have_http_status(:ok) }
        it { expect(response).to be_successful }

        it_behaves_like ADMIN_MENU_CATEGORY
        it {
          expect(subject).to include(
            parent_id: NilClass,
            name: NilClass,
            description: NilClass,
            secret_desc: NilClass,
            images: []
          )
        }
      end

      context "if cannot find category by id" do
        subject { response }

        before { req(id: "invalid") }

        it_behaves_like NOT_FOUND
      end

      context 'with {name: "Hello"}' do
        subject do
          req(id: category.id, name: "Hello")
          parsed_response_body[:item]
        end

        let!(:category) { create(:menu_category) }

        it { expect(response).to have_http_status(:ok) }
        it { expect(response).to be_successful }

        it_behaves_like ADMIN_MENU_CATEGORY
        it {
          expect(subject).to include(
            parent_id: NilClass,
            name: "Hello",
            description: NilClass,
            secret_desc: NilClass,
            images: []
          )
        }
      end

      context 'with {description: "Hello"}' do
        subject do
          req(id: category.id, description: "Hello")
          parsed_response_body[:item]
        end

        let!(:category) { create(:menu_category) }

        it { expect(response).to have_http_status(:ok) }
        it { expect(response).to be_successful }

        it_behaves_like ADMIN_MENU_CATEGORY
        it {
          expect(subject).to include(
            parent_id: NilClass,
            name: NilClass,
            description: "Hello",
            secret_desc: NilClass,
            images: []
          )
        }
      end

      context 'with {secret_desc: "Hello"}' do
        subject do
          req(id: category.id, secret_desc: "Hello")
          parsed_response_body[:item]
        end

        let!(:category) { create(:menu_category) }

        it { expect(response).to have_http_status(:ok) }
        it { expect(response).to be_successful }

        it_behaves_like ADMIN_MENU_CATEGORY
        it {
          expect(subject).to include(
            parent_id: NilClass,
            name: NilClass,
            description: NilClass,
            secret_desc: "Hello",
            images: []
          )
        }
      end

      context 'with {name: "Hello", description: "Hello", secret_desc: "Hello"}' do
        subject do
          req(id: category.id, name: "HelloName", description: "HelloDesc", secret_desc: "HelloSecret")
          parsed_response_body[:item]
        end

        let!(:category) { create(:menu_category) }

        it { expect(response).to have_http_status(:ok) }
        it { expect(response).to be_successful }

        it_behaves_like ADMIN_MENU_CATEGORY
        it {
          expect(subject).to include(
            parent_id: NilClass,
            name: "HelloName",
            description: "HelloDesc",
            secret_desc: "HelloSecret",
            images: []
          )
        }
      end

      context 'with {name: {it: "Hello", en: "Hello"}}' do
        subject do
          req(id: category.id, name: { it: "Ciao", en: "Hello" })
          parsed_response_body[:item]
        end

        let!(:category) { create(:menu_category) }

        it { expect(response).to have_http_status(:ok) }
        it { expect(response).to be_successful }

        it_behaves_like ADMIN_MENU_CATEGORY
        it {
          expect(subject).to include(
            parent_id: NilClass,
            name: "Hello",
            description: NilClass,
            secret_desc: NilClass,
            images: []
          )
        }

        context "after request" do
          subject { category.reload }

          before { req(id: category.id, name: { it: "Ciao", en: "Hello" }) }

          it { expect(subject.name).to eq "Hello" }
          it { expect(subject.name_it).to eq "Ciao" }
          it { expect(subject.name_en).to eq "Hello" }
        end
      end

      context 'with {description: {it: "Hello", en: "Hello"}}' do
        subject do
          req(id: category.id, description: { it: "Ciao", en: "Hello" })
          parsed_response_body[:item]
        end

        let!(:category) { create(:menu_category) }

        it { expect(response).to have_http_status(:ok) }
        it { expect(response).to be_successful }

        it_behaves_like ADMIN_MENU_CATEGORY
        it {
          expect(subject).to include(
            parent_id: NilClass,
            name: NilClass,
            description: "Hello",
            secret_desc: NilClass,
            images: []
          )
        }

        context "after request" do
          subject { category.reload }

          before { req(id: category.id, description: { it: "Ciao", en: "Hello" }) }

          it { expect(subject.description).to eq "Hello" }
          it { expect(subject.description_it).to eq "Ciao" }
          it { expect(subject.description_en).to eq "Hello" }
        end
      end

      context "with {parent_id: <id>}" do
        subject do
          req(id: category.id, parent_id: parent.id)
          response
        end

        let!(:parent) { create(:menu_category) }
        let!(:category) { create(:menu_category) }

        it { expect { subject }.not_to change(Menu::Category, :count) }
        it { expect { subject }.to change { category.reload.parent }.from(nil).to(parent) }
        it { expect { subject }.to change { category.reload.visibility_id }.from(category.visibility_id).to(nil) }
        it { is_expected.to have_http_status(:ok) }
        it { is_expected.to be_successful }

        context "response[:item]" do
          subject do
            req(id: category.id, parent_id: parent.id)
            parsed_response_body[:item]
          end

          it_behaves_like ADMIN_MENU_CATEGORY, skip_visibility: true

          it {
            expect(subject).to include(
              parent_id: Integer,
              name: NilClass,
              description: NilClass,
              secret_desc: NilClass,
              images: []
            )
          }
        end

        context "after request" do
          subject { category.reload }

          before { req(id: category.id, parent_id: parent.id) }

          it { expect(subject.parent).to eq parent }
        end
      end

      context "with {parent_id: nil}" do
        subject do
          req(id: category.id, parent_id: nil)
          response
        end

        let!(:parent) { create(:menu_category) }
        let!(:category) { create(:menu_category, visibility: nil, parent:) }

        it { expect { subject }.not_to change(Menu::Category, :count) }
        it { expect { subject }.to change { category.reload.parent }.from(parent).to(nil) }
        it { is_expected.to have_http_status(:ok) }
        it { is_expected.to be_successful }

        it "does not have a message" do
          subject
          expect(parsed_response_body["message"]).to be_nil
        end

        context "response[:item]" do
          subject do
            req(id: category.id, parent_id: nil)
            parsed_response_body[:item]
          end

          it_behaves_like ADMIN_MENU_CATEGORY, skip_visibility: true

          it {
            expect(subject).to include(
              parent_id: NilClass,
              name: NilClass,
              description: NilClass,
              secret_desc: NilClass,
              images: []
            )
          }
        end

        context "after request" do
          subject { category.reload }

          before { req(id: category.id, parent_id: nil) }

          it { expect(subject.parent).to eq nil }
        end
      end

      context "passing {name: {it: <String>, invalid_locale: <String>}}" do
        subject do
          req params
          response
        end

        let!(:category) { create(:menu_category) }
        let(:params) { { id: category.id, name: { it: "test-it", invalid_locale: "test-invalid" } } }

        it do
          expect { subject }.not_to change(Menu::Category, :count)
          expect(Menu::Category.count).to eq 1
        end

        it { is_expected.to have_http_status(:unprocessable_entity) }
        it { is_expected.not_to be_successful }

        context "response[:item]" do
          subject do
            req params
            parsed_response_body[:item]
          end

          it { is_expected.to be_nil }
        end

        context "response[:message]" do
          subject do
            req params
            parsed_response_body[:message]
          end

          it { is_expected.to be_a(String) }
          it { is_expected.to include(I18n.t("errors.messages.invalid_locale", lang: :invalid_locale)) }
        end

        context "response[:details]" do
          subject do
            req params
            parsed_response_body[:details]
          end

          it { is_expected.to be_a(Hash) }
          it { is_expected.to include(:name) }
          it { is_expected.to include(name: Array) }
        end

        context "response[:details][:name]" do
          subject do
            req params
            parsed_response_body[:details][:name]
          end

          it { is_expected.to be_a(Array) }
          it { is_expected.not_to be_empty }
          it { is_expected.to all(be_a(Hash)) }
          it { is_expected.to all(include(:attribute, :raw_type, :type, :options, :message)) }
        end
      end

      context 'passing {secret_desc: "ciaobanana", description: {it: <String>, invalid_locale: <String>}}' do
        subject do
          req params
          response
        end

        let!(:parent) { create(:menu_category) }
        let!(:category) { create(:menu_category, parent:, visibility: nil) }
        let(:params) do
          { id: category.id, secret_desc: "ciaobanana", description: { it: "test-it", invalid_locale: "test-invalid" } }
        end

        it "does not update parent" do
          expect { req params }.not_to(change { category.reload.secret_desc })
        end

        it "checking mock data" do
          expect(category.secret_desc).to eq nil
          expect(category.description).to eq nil
        end

        it { is_expected.to have_http_status(:unprocessable_entity) }
        it { is_expected.not_to be_successful }

        context "response[:details][:description]" do
          subject do
            req params
            parsed_response_body[:details][:description]
          end

          it { is_expected.to be_a(Array) }
          it { is_expected.not_to be_empty }
          it { is_expected.to all(be_a(Hash)) }
          it { is_expected.to all(include(:attribute, :raw_type, :type, :options, :message)) }
        end
      end

      context "passing {parent_id: nil, name: {it: <String>, invalid_locale: <String>}}" do
        let!(:parent) { create(:menu_category) }
        let!(:category) { create(:menu_category, parent:, visibility: nil) }
        let(:params) { { id: category.id, parent_id: nil, name: { it: "test-it", invalid_locale: "test-invalid" } } }

        it "does not update parent" do
          expect { req params }.not_to(change { category.reload.parent })
        end

        context "response[:item]" do
          subject do
            req params
            parsed_response_body[:item]
          end

          it { is_expected.to be_nil }
        end

        context "response[:message]" do
          subject do
            req params
            parsed_response_body[:message]
          end

          it { is_expected.to be_a(String) }
          it { is_expected.to include(I18n.t("errors.messages.invalid_locale", lang: :invalid_locale)) }
        end

        context "response[:details]" do
          subject do
            req params
            parsed_response_body[:details]
          end

          it { is_expected.to be_a(Hash) }
          it { is_expected.to include(:name) }
          it { is_expected.to include(name: Array) }
        end

        context "response[:details][:name]" do
          subject do
            req params
            parsed_response_body[:details][:name]
          end

          it { is_expected.to be_a(Array) }
          it { is_expected.not_to be_empty }
          it { is_expected.to all(be_a(Hash)) }
          it { is_expected.to all(include(:attribute, :raw_type, :type, :options, :message)) }
        end
      end

      context "passing {name: nil} to a category with name" do
        subject do
          req(id: category.id, name: nil)
          parsed_response_body[:item]
        end

        let!(:category) do
          mc = create(:menu_category)
          Mobility.with_locale(:it) { mc.update!(name: "test-it") }
          Mobility.with_locale(:en) { mc.update!(name: "test-en") }
          mc.reload
          mc
        end

        context "checking mock data" do
          it { expect(category.name).to eq "test-en" }
          it { expect(category.name_en).to eq "test-en" }
          it { expect(category.name_it).to eq "test-it" }
        end

        it { expect(response).to have_http_status(:ok) }
        it { expect(response).to be_successful }
        it { expect(subject[:name]).to eq nil }

        context "after request" do
          subject { category.reload }

          before { req(id: category.id, name: nil) }

          it { expect(subject.name).to eq nil }
          it { expect(subject.name_en).to eq nil }
          it { expect(subject.name_it).to eq "test-it" }
        end
      end

      context "when setting name to nil with {name: nil}" do
        subject do
          req(id: category.id, name: nil)
          parsed_response_body[:item]
        end

        let!(:category) { create(:menu_category, name: "Category name") }

        it { is_expected.to include(name: nil) }
      end

      context "when setting name to nil with {name: {<locale>: nil}}" do
        subject do
          req(id: category.id, name: { en: nil })
          parsed_response_body[:item]
        end

        let!(:category) { create(:menu_category, name: "Category name") }

        it { is_expected.to include(name: nil) }
      end
    end
  end

  describe "#destroy" do
    it { expect(instance).to respond_to(:destroy) }

    it {
      expect(described_class).to route(:DELETE, "/v1/admin/menu/categories/22").to(action: :destroy, format: :json,
                                                                                   id: 22)
    }

    def req(params = {})
      delete :destroy, params:
    end

    context "when user is not authenticated" do
      before { req(id: 22) }

      it_behaves_like UNAUTHORIZED
    end

    context "(authenticated)" do
      before { authenticate_request }

      context "basic" do
        subject do
          req(id: category.id)
          response
        end

        let!(:category) { create(:menu_category) }

        it { expect { subject }.to change { Menu::Category.visible.count }.by(-1) }
        it { is_expected.to have_http_status(:no_content) }
        it { is_expected.to be_successful }
      end

      context "when cannot delete record" do
        subject do
          req(id: category.id)
          response
        end

        let!(:category) { create(:menu_category) }

        before { allow_any_instance_of(Menu::Category).to receive(:deleted!).and_return(false) }

        it { expect { subject }.not_to(change { Menu::Category.visible.count }) }
        it { is_expected.to have_http_status(:unprocessable_entity) }
        it { is_expected.not_to be_successful }
      end

      context "when record deletion raises error" do
        subject do
          req(id: category.id)
          response
        end

        let!(:category) { create(:menu_category) }

        before { allow_any_instance_of(Menu::Category).to receive(:deleted!).and_raise(ActiveRecord::RecordInvalid) }

        it { expect { subject }.not_to(change { Menu::Category.visible.count }) }
        it { is_expected.to have_http_status(:unprocessable_entity) }
        it { is_expected.not_to be_successful }
      end

      context "if cannot find category by id" do
        subject { response }

        before { req(id: 22) }

        it_behaves_like NOT_FOUND
      end
    end
  end

  describe "#visibility" do
    it { expect(instance).to respond_to(:visibility) }

    it {
      expect(described_class).to route(:patch, "/v1/admin/menu/categories/22/visibility").to(action: :visibility,
                                                                                             format: :json, id: 22)
    }

    def req(id, params = {})
      patch :visibility, params: params.merge(id:)
    end

    context "when user is not authenticated" do
      before { req(id: 22) }

      it_behaves_like UNAUTHORIZED
    end

    context "(authenticated)" do
      before { authenticate_request }

      let(:visibility) do
        create(:menu_visibility, public_visible: false, private_visible: false, public_from: nil, public_to: nil,
                                 private_from: nil, private_to: nil)
      end
      let(:category) { create(:menu_category, visibility:) }

      context "checking mock data" do
        it { expect(category.visibility).to be_present }
        it { expect(category.visibility.id).to eq visibility.id }
        it { expect(category).not_to be_public_visible }
        it { expect(category).not_to be_private_visible }
        it { expect(category.visibility.public_visible).to eq false }
        it { expect(category.visibility.private_visible).to eq false }
        it { expect(category.dishes.count).to eq 0 }
      end

      context "should allow to update daily_from and daily_to values" do
        subject do
          req(category.id, daily_from: "12:00", daily_to: "15:00")
          response
        end

        before { category.visibility.update!(daily_from: nil, daily_to: nil) }

        it { expect { subject }.to(change { category.reload.visibility.daily_from }) }
        it { expect { subject }.to(change { category.reload.visibility.daily_to }) }

        context "response should contain new daily_from and daily_to values" do
          before { subject }

          it { expect(parsed_response_body.dig(:item, :visibility)).to include("daily_to" => String) }
          it { expect(parsed_response_body.dig(:item, :visibility)).to include("daily_from" => String) }
          it { expect(parsed_response_body.dig(:item, :visibility, :daily_from)).to include "12:00" }
          it { expect(parsed_response_body.dig(:item, :visibility, :daily_to)).to include "15:00" }
        end

        #   TODO test
        #   it { expect { subject }.to change { category.reload.visibility.daily_to }.to(????) }
      end

      context "should allow to update just daily_from without setting daily_to" do
        subject do
          req(category.id, daily_from: "12:00")
          response
        end

        before { category.visibility.update!(daily_from: nil, daily_to: nil) }

        it { expect { subject }.to(change { category.reload.visibility.daily_from }) }
        it { expect { subject }.not_to(change { category.reload.visibility.daily_to }) }
      end

      context "should allow to update just daily_to without setting daily_from" do
        subject do
          req(category.id, daily_to: "21:00")
          response
        end

        before { category.visibility.update!(daily_from: nil, daily_to: nil) }

        it { expect { subject }.not_to(change { category.reload.visibility.daily_from }) }
        it { expect { subject }.to(change { category.reload.visibility.daily_to }) }
      end

      context "when category was already public should not stop from updating any other field: should check if can publish only if publishing right now." do
        subject do
          req(category.id, public_from: "2023-10-10")
          response
        end

        before { category.visibility.update!(public_visible: true) }

        it { expect { subject }.not_to(change { category.reload.visibility.public_visible }) }

        it {
          expect { subject }.to change {
                                  category.reload.visibility.public_from
                                }.from(nil).to(DateTime.parse("2023-10-10"))
        }

        it "updates public_from and return 200" do
          expect(subject).to have_http_status(:ok)
          expect(subject).to be_successful
        end
      end

      context "when category hasnt any dish, should not be able to update public_visible to true" do
        subject do
          req(category.id, public_visible: true)
          response
        end

        it "does not update public_visible to true" do
          expect { subject }.not_to(change { category.reload.visibility.public_visible })
          expect(subject).to have_http_status(:unprocessable_entity)
          expect(subject).not_to be_successful
        end

        it do
          subject
          expect(parsed_response_body).to include(message: String, details: Hash)
          expect(parsed_response_body[:details]).to include(error_code: "cannot_publish")
        end
      end

      context "when category hasnt any dish but providing {force: true}" do
        subject do
          req(category.id, public_visible: true, force: true)
          response
        end

        it "is able to update public_visible to true" do
          expect { subject }.to change { category.reload.visibility.public_visible }.from(false).to(true)
          expect(subject).to have_http_status(:ok)
          expect(subject).to be_successful
        end
      end

      context 'when category hasnt any dish but providing {force: "true"}' do
        subject do
          req(category.id, public_visible: true, force: "true")
          response
        end

        it "is able to update public_visible to true" do
          expect { subject }.to change { category.reload.visibility.public_visible }.from(false).to(true)
          expect(subject).to have_http_status(:ok)
          expect(subject).to be_successful
        end
      end

      context 'when category hasnt any dish but providing {force: "false"}' do
        subject do
          req(category.id, public_visible: true, force: "false")
          response
        end

        it "does not update public_visible to true" do
          expect { subject }.not_to(change { category.reload.visibility.public_visible })
          expect(subject).to have_http_status(:unprocessable_entity)
          expect(subject).not_to be_successful
        end
      end

      context "when category hasnt any dish but providing {force: false}" do
        subject do
          req(category.id, public_visible: true, force: false)
          response
        end

        it "does not update public_visible to true" do
          expect { subject }.not_to(change { category.reload.visibility.public_visible })
          expect(subject).to have_http_status(:unprocessable_entity)
          expect(subject).not_to be_successful
        end
      end

      context "when category hasnt any dish" do
        subject do
          req(category.id, private_visible: true)
          response
        end

        it "updates private_visible to true" do
          expect { subject }.to change { category.reload.visibility.private_visible }.from(false).to(true)
          expect(subject).to have_http_status(:ok)
          expect(subject).to be_successful
        end
      end

      context "when category hasnt any dish" do
        subject do
          req(category.id, private_visible: true, public_visible: true)
          response
        end

        it "is not able to update private_visible or public_visible to true" do
          expect { subject }.not_to(change { category.reload.visibility.private_visible })
          expect(subject).to have_http_status(:unprocessable_entity)
          expect(subject).not_to be_successful
        end
      end

      context "when providing public_from after public_to {public_from: '2022-10-8', private_to: '2021-1-1'}" do
        subject do
          req(category.id, public_from: "2022-10-8", private_to: "2021-1-1")
          response
        end

        it {
          expect { subject }.to change {
                                  category.reload.visibility.public_from
                                }.from(nil).to(DateTime.parse("2022-10-8"))
        }

        it {
          expect { subject }.to change {
                                  category.reload.visibility.private_to
                                }.from(nil).to(DateTime.parse("2021-1-1"))
        }

        it "is able to update public_from or private_to and return 200" do
          expect(subject).to have_http_status(:ok)
          expect(subject).to be_successful
        end

        context "after req" do
          before { subject }

          it { expect(parsed_response_body).not_to include(message: String, details: Hash) }
        end
      end

      context "when providing public_from == public_to {public_from: '2022-10-8', public_to: '2022-10-8'}" do
        subject do
          req(category.id, public_from: "2022-10-8", public_to: "2022-10-8")
          response
        end

        it { expect { subject }.not_to(change { category.reload.visibility.public_from }) }

        it { expect { subject }.not_to(change { category.reload.visibility.public_to }) }

        it "is not able to update public_from or public_to and return 422" do
          expect(subject).to have_http_status(:unprocessable_entity)
          expect(subject).not_to be_successful
        end

        context "after req" do
          before { subject }

          it { expect(parsed_response_body).to include(message: String, details: Hash) }
        end
      end

      context "when providing public_from == public_to {private_from: '2022-10-8', private_to: '2022-10-8'}" do
        subject do
          req(category.id, private_from: "2022-10-8", private_to: "2022-10-8")
          response
        end

        it { expect { subject }.not_to(change { category.reload.visibility.private_from }) }

        it { expect { subject }.not_to(change { category.reload.visibility.private_to }) }

        it "is not able to update private_from or private_to and return 422" do
          expect(subject).to have_http_status(:unprocessable_entity)
          expect(subject).not_to be_successful
        end

        context "after req" do
          before { subject }

          it { expect(parsed_response_body).to include(message: String, details: Hash) }
        end
      end

      context "when providing public_from after public_to {public_from: '2022-10-8', public_to: '2021-1-1'}" do
        subject do
          req(category.id, public_from: "2022-10-8", public_to: "2021-1-1")
          response
        end

        it { expect { subject }.not_to(change { category.reload.visibility.public_from }) }

        it { expect { subject }.not_to(change { category.reload.visibility.public_to }) }

        it "is not able to update public_from or public_to and return 422" do
          expect(subject).to have_http_status(:unprocessable_entity)
          expect(subject).not_to be_successful
        end

        context "after req" do
          before { subject }

          it { expect(parsed_response_body).to include(message: String, details: Hash) }
        end
      end

      context "when providing private_from after private_to {private_from: '2022-10-8', private_to: '2021-1-1'}" do
        subject do
          req(category.id, private_from: "2022-10-8", private_to: "2021-1-1")
          response
        end

        it { expect { subject }.not_to(change { category.reload.visibility.private_from }) }

        it { expect { subject }.not_to(change { category.reload.visibility.private_to }) }

        it "is not able to update private_from or public_to and return 422" do
          expect(subject).to have_http_status(:unprocessable_entity)
          expect(subject).not_to be_successful
        end

        context "after req" do
          before { subject }

          it { expect(parsed_response_body).to include(message: String, details: Hash) }
        end
      end

      %w[2023-10-13 13-10-2023 13.10.2023 13/10/2023].each do |date|
        context "when providing {public_from: #{date}}" do
          subject do
            req(category.id, public_from: date)
            response
          end

          it "updates public_from correctly" do
            expect { subject }.to change {
                                    category.reload.visibility.public_from
                                  }.from(nil).to(DateTime.parse("2023-10-13"))
            expect(subject).to have_http_status(:ok)
            expect(subject).to be_successful
          end
        end

        context "when providing {public_to: #{date}}" do
          subject do
            req(category.id, public_to: date)
            response
          end

          it "updates public_to correctly" do
            expect { subject }.to change {
                                    category.reload.visibility.public_to
                                  }.from(nil).to(DateTime.parse("2023-10-13"))
            expect(subject).to have_http_status(:ok)
            expect(subject).to be_successful
          end
        end

        context "when providing {private_from: #{date}}" do
          subject do
            req(category.id, private_from: date)
            response
          end

          it "updates private_from correctly" do
            expect { subject }.to change {
                                    category.reload.visibility.private_from
                                  }.from(nil).to(DateTime.parse("2023-10-13"))
            expect(subject).to have_http_status(:ok)
            expect(subject).to be_successful
          end
        end

        context "when providing {private_to: #{date}}" do
          subject do
            req(category.id, private_to: date)
            response
          end

          it "updates private_to correctly" do
            expect { subject }.to change {
                                    category.reload.visibility.private_to
                                  }.from(nil).to(DateTime.parse("2023-10-13"))
            expect(subject).to have_http_status(:ok)
            expect(subject).to be_successful
          end
        end
      end
    end
  end

  describe "#add_dish" do
    subject { req }

    let!(:dish) { create(:menu_dish) }
    let!(:category) { create(:menu_category) }

    it { expect(instance).to respond_to(:add_dish) }

    it {
      expect(subject).to route(:post, "/v1/admin/menu/categories/22/dishes/55").to(format: :json, action: :add_dish,
                                                                                   controller: "v1/admin/menu/categories", id: 22, dish_id: 55)
    }

    def req(category_id = category.id, dish_id = dish.id, params = {})
      post :add_dish, params: params.merge(id: category_id, dish_id:)
    end

    context "when user is not authenticated" do
      before { req }

      it_behaves_like UNAUTHORIZED
    end

    context "[user is authenticated]" do
      before do
        authenticate_request(user: create(:user))
      end

      it { is_expected.to be_successful }
      it { expect { subject }.to change { category.reload.dishes.count }.by(1) }
      it { expect { subject }.to change { Menu::DishesInCategory.count }.by(1) }
      it { expect { subject }.not_to(change { Menu::Dish.count }) }
      it { expect { subject }.not_to(change { Menu::Category.count }) }

      context "when adding twice same dish" do
        before { req }

        it { expect { req }.not_to(change { category.reload.dishes.count }) }
        it { expect { req }.not_to(change { Menu::DishesInCategory.count }) }

        context "[after second request]" do
          before { req }

          it { is_expected.to have_http_status(:unprocessable_entity) }
          it { expect(parsed_response_body).to include(message: String) }
        end
      end

      context "when adding dish to non-existing dish" do
        subject { response }

        before { req(999_999_999) }

        it_behaves_like NOT_FOUND
      end

      context "when adding non-existing dish to dish" do
        subject { response }

        before { req(category.id, 999_999_999) }

        it_behaves_like NOT_FOUND
      end

      context "when adding deleted dish to category" do
        subject { response }

        before do
          dish.deleted!
          req
        end

        it_behaves_like NOT_FOUND
      end

      context "when providing {copy: true}, should attach a copy of the dish" do
        subject do
          req(category.id, dish.id, copy: true)
          response
        end

        it { expect { subject }.to change { category.reload.dishes.count }.by(1) }
        it { expect { subject }.to change { Menu::DishesInCategory.count }.by(1) }
        it { expect { subject }.to change { Menu::Dish.count }.by(1) }
        it { expect { subject }.not_to(change { Menu::Category.count }) }

        context "[after request]" do
          before { subject }

          it { expect(parsed_response_body).not_to include(message: String) }
          it { expect(parsed_response_body).to include(item: Hash) }
          it { expect(category.reload.dishes.count).to eq 1 }
          it { expect(category.reload.dishes.first.id).not_to eq dish.id }
        end

        context "when addition fails, should return 422 and not create any new record" do
          before do
            allow_any_instance_of(Menu::DishesInCategory).to receive(:valid?).and_return(false)
            req(category.id, dish.id, copy: true)
          end

          it { is_expected.to have_http_status(:unprocessable_entity) }
          it { expect(parsed_response_body).to include(message: String) }
          it { expect { subject }.not_to(change { category.reload.dishes.count }) }
          it { expect { subject }.not_to(change { Menu::DishesInCategory.count }) }
          it { expect { subject }.not_to(change { Menu::Dish.count }) }
        end
      end
    end
  end

  describe "#remove_dish" do
    subject { req }

    before { category.dishes << dish }

    let!(:dish) { create(:menu_dish) }
    let!(:category) { create(:menu_category) }

    it { expect(instance).to respond_to(:remove_dish) }

    it {
      expect(subject).to route(:delete, "/v1/admin/menu/categories/22/dishes/55").to(format: :json, action: :remove_dish,
                                                                                     controller: "v1/admin/menu/categories", id: 22, dish_id: 55)
    }

    def req(category_id = category.id, dish_id = dish.id, params = {})
      post :remove_dish, params: params.merge(id: category_id, dish_id:)
    end

    it { expect(category.dishes.count).to be_positive }

    context "when user is not authenticated" do
      before { req }

      it_behaves_like UNAUTHORIZED
    end

    context "[user is authenticated]" do
      before do
        authenticate_request(user: create(:user))
      end

      it { is_expected.to be_successful }
      it { is_expected.to have_http_status(:ok) }

      it {
        req
        expect(parsed_response_body[:message]).to be_blank
      }

      it { expect { subject }.to change { category.reload.dishes.count }.by(-1) }
      it { expect { subject }.to change { Menu::DishesInCategory.count }.by(-1) }

      context "if removing non-existing dish" do
        subject { response }

        before { req(category.id, 999_999_999) }

        it_behaves_like NOT_FOUND
      end

      context "if removing dish from non-existing dish" do
        subject { response }

        before { req(999_999_999) }

        it_behaves_like NOT_FOUND
      end
    end
  end

  describe "#add_category" do
    subject { req }

    let!(:category_child) { create(:menu_category) }
    let!(:category) { create(:menu_category) }

    it { expect(instance).to respond_to(:add_category) }

    it {
      expect(subject).to route(:post, "/v1/admin/menu/categories/22/add_category/55").to(format: :json, action: :add_category,
                                                                                         controller: "v1/admin/menu/categories", id: 22, category_child_id: 55)
    }

    def req(category_id = category.id, category_child_id = category_child.id, params = {})
      post :add_category, params: params.merge(id: category_id, category_child_id:)
    end

    context "when user is not authenticated" do
      before { req }

      it_behaves_like UNAUTHORIZED
    end

    context "[user is authenticated]" do
      before do
        authenticate_request(user: create(:user))
      end

      it { is_expected.to be_successful }
      it { expect { subject }.to change { category.reload.children.count }.by(1) }
      it { expect { subject }.to change { Menu::Category.count }.by(1) }

      context "when adding dish to non-existing dish" do
        subject { response }

        before { req(999_999_999) }

        it_behaves_like NOT_FOUND
      end

      context "when adding non-existing dish to dish" do
        subject { response }

        before { req(category.id, 999_999_999) }

        it_behaves_like NOT_FOUND
      end

      context "when adding deleted dish to category" do
        subject { response }

        before do
          category_child.deleted!
          req
        end

        it_behaves_like NOT_FOUND
      end
    end
  end

  context "POST #copy" do
    subject { req }

    let(:params) { { id: category.id, copy_dishes:, copy_children:, copy_images:, parent_id: } }
    let(:parent_id) { nil }
    let(:copy_children) { nil }
    let(:copy_images) { nil }
    let(:copy_dishes) { nil }
    let!(:category) { create(:menu_category) }

    it { expect(instance).to respond_to(:copy) }

    it {
      expect(subject).to route(:post, "/v1/admin/menu/categories/22/copy").to(format: :json, action: :copy,
                                                                              controller: "v1/admin/menu/categories", id: 22)
    }

    def req(req_params = params)
      post :copy, params: req_params
    end

    context "when user is not authenticated" do
      before { req }

      it_behaves_like UNAUTHORIZED
    end

    context "[user is authenticated]" do
      before do
        authenticate_request(user: create(:user))
      end

      it { is_expected.to be_successful }
      it { expect { subject }.to change { Menu::Category.count }.by(1) }

      it do
        subject
        expect(parsed_response_body).not_to include(message: String)
      end

      context "when providing parent_id" do
        context "when providing {parent_id: nil} creates as root category" do
          before do
            category.update!(visibility: nil, parent: create(:menu_category))
          end

          let(:parent_id) { nil }

          context "checking mock data" do
            it { expect(category.parent).to be_present }
          end

          it { expect { subject }.to change { Menu::Category.count }.by(1) }
          it { expect { subject }.not_to(change { category.reload.parent }) }
          it { expect { subject }.not_to(change { category.reload.parent.children.count }) }

          it do
            subject
            expect(Menu::Category.order(id: :desc).first.parent).to be_blank
          end

          it "returns 200" do
            subject
            expect(parsed_response_body).not_to include(message: String)
            expect(response).to have_http_status(:ok)
          end
        end

        context "when providing {parent_id: <int>} creates as child of another category" do
          before do
            category.update!(visibility: nil, parent: create(:menu_category))
          end

          let!(:parent) { create(:menu_category) }
          let(:parent_id) { parent.id }

          context "checking mock data" do
            it { expect(category.parent).to be_present }
          end

          it { expect { subject }.to change { Menu::Category.count }.by(1) }
          it { expect { subject }.not_to(change { category.reload.parent }) }
          it { expect { subject }.not_to(change { category.reload.parent.children.count }) }
          it { expect { subject }.to change { parent.reload.children.count }.by(1) }

          it do
            subject
            expect(Menu::Category.order(id: :desc).first.parent&.id).to eq parent_id
          end

          it "returns 200" do
            subject
            expect(parsed_response_body).not_to include(message: String)
            expect(response).to have_http_status(:ok)
          end
        end
      end

      context "when providing {copy_images: 'none'} does not copy images" do
        before do
          category.images << create(:image, :with_attached_image)
        end

        let(:copy_images) { "none" }

        context "checking mock data" do
          it { expect(category.images.count).to eq 1 }
        end

        it { expect { subject }.not_to(change { Image.count }) }
        it { expect { subject }.not_to(change { ImageToRecord.count }) }

        it do
          subject
          expect(parsed_response_body).not_to include(message: String)
          expect(response).to have_http_status(:ok)
        end
      end

      context "when providing {copy_images: 'link'} does not copy images but links existing" do
        before do
          category.images << create(:image, :with_attached_image)
        end

        let(:copy_images) { "link" }

        context "checking mock data" do
          it { expect(category.images.count).to eq 1 }
        end

        it { expect { subject }.not_to(change { Image.count }) }
        it { expect { subject }.not_to(change { category.reload.images.count }) }
        it { expect { subject }.to change { ImageToRecord.count }.by(1) }

        it do
          subject
          expect(parsed_response_body).not_to include(message: String)
          expect(response).to have_http_status(:ok)
        end
      end

      context "when providing {copy_images: 'full'} copy and links them" do
        before do
          category.images << create(:image, :with_attached_image)
        end

        let(:copy_images) { "full" }

        context "checking mock data" do
          it { expect(category.images.count).to eq 1 }
        end

        it { expect { subject }.to change { Image.count }.by(1) }
        it { expect { subject }.to change { ImageToRecord.count }.by(1) }

        it do
          subject
          expect(parsed_response_body).not_to include(message: String)
          expect(response).to have_http_status(:ok)
        end
      end

      context "when providing {copy_dishes: 'none'} does not copy dishes" do
        before do
          category.dishes = create_list(:menu_dish, 3)
        end

        let(:copy_dishes) { "none" }

        context "checking mock data" do
          it { expect(category.dishes.count).to eq 3 }
        end

        it { expect { subject }.not_to(change { Menu::Dish.count }) }
        it { expect { subject }.not_to(change { Menu::DishesInCategory.count }) }

        it do
          subject
          expect(parsed_response_body).not_to include(message: String)
          expect(response).to have_http_status(:ok)
        end
      end

      context "when providing {copy_dishes: 'link'} does not copy dishes but links them." do
        before do
          category.dishes = create_list(:menu_dish, 3)
        end

        let(:copy_dishes) { "link" }

        context "checking mock data" do
          it { expect(category.dishes.count).to eq 3 }
        end

        it { expect { subject }.not_to(change { Menu::Dish.count }) }
        it { expect { subject }.not_to(change { category.reload.dishes.count }) }
        it { expect { subject }.to change { Menu::DishesInCategory.count }.by(3) }

        it do
          subject
          expect(parsed_response_body).not_to include(message: String)
          expect(response).to have_http_status(:ok)
        end
      end

      context "when providing {copy_dishes: 'full'} copy dishes" do
        before do
          category.dishes = create_list(:menu_dish, 3)
        end

        let(:copy_dishes) { "full" }

        context "checking mock data" do
          it { expect(category.dishes.count).to eq 3 }
        end

        it { expect { subject }.to change { Menu::Dish.count }.by(3) }
        it { expect { subject }.not_to(change { category.reload.dishes.count }) }
        it { expect { subject }.to change { Menu::DishesInCategory.count }.by(3) }

        it do
          subject
          expect(parsed_response_body).not_to include(message: String)
          expect(response).to have_http_status(:ok)
        end
      end

      context "when providing {copy_children: 'none'}, should not copy children." do
        before do
          create_list(:menu_category, 3, visibility: nil, parent: category)
        end

        let(:copy_children) { "none" }

        context "checking mock data" do
          it { expect(category.children.count).to eq 3 }
        end

        it { expect { subject }.to change { Menu::Category.count }.by(1) }
        it { expect { subject }.not_to(change { category.reload.children.count }) }

        it do
          subject
          expect(parsed_response_body).not_to include(message: String)
          expect(response).to have_http_status(:ok)
        end
      end

      context "when providing {copy_children: 'full'}, should copy all children." do
        before do
          create_list(:menu_category, 3, visibility: nil, parent: category)
        end

        let(:copy_children) { "full" }

        context "checking mock data" do
          it { expect(category.children.count).to eq 3 }
        end

        it { expect { subject }.to change { Menu::Category.count }.by(3 + 1) }
        it { expect { subject }.not_to(change { category.reload.children.count }) }

        it do
          subject
          expect(parsed_response_body).not_to include(message: String)
          expect(response).to have_http_status(:ok)
        end
      end
    end
  end

  context "PATCH #move" do
    let(:params) { { id:, to_index: } }
    let(:id) { category.id }
    let(:to_index) { 1 }
    let(:category) { create(:menu_category, index: 0) }

    it { expect(instance).to respond_to(:move) }

    it {
      expect(described_class).to route(:patch, "/v1/admin/menu/categories/22/move/5").to(action: :move, format: :json,
                                                                                         id: 22, to_index: 5)
    }

    def req(req_params = params)
      patch :move, params: req_params
    end

    context "when user is not authenticated" do
      before { req }

      it_behaves_like UNAUTHORIZED
    end

    context "(authenticated)" do
      before { authenticate_request }

      context "when passing a invalid id" do
        subject { response }

        let(:id) { "invalid" }

        before { req }

        it_behaves_like NOT_FOUND
      end

      context "when passing a invalid id" do
        subject { response }

        let(:id) { 999_999_999 }

        before { req }

        it_behaves_like NOT_FOUND
      end

      context "basic" do
        subject do
          req
          response
        end

        let(:category) { category0 }
        let!(:category0) { create(:menu_category, index: 0) }
        let!(:category1) { create(:menu_category, index: 1) }
        let!(:category2) { create(:menu_category, index: 2) }

        it do
          expect { subject }.to change { category.reload.index }.from(0).to(1)
          expect(parsed_response_body).not_to include(message: String, details: Hash)
          expect(response).to have_http_status(:ok)
        end

        context "when moving the first one as the last one" do
          let(:to_index) { 2 }

          it do
            expect { subject }.to change { category.reload.index }.from(0).to(2)
            expect(parsed_response_body).not_to include(message: String, details: Hash)
            expect(response).to have_http_status(:ok)
          end

          it do
            expect { subject }.to change { category1.reload.index }.from(1).to(0)
          end

          it do
            expect { subject }.to change { category2.reload.index }.from(2).to(1)
          end

          it do
            subject
            expect(Menu::Category.order(:index).pluck(:id)).to eq([category1.id, category2.id, category0.id])
          end
        end

        context "when moving the last one as the first one" do
          let(:to_index) { 0 }
          let(:category) { category2 }

          it { expect { subject }.to change { category0.reload.index }.from(0).to(1) }
          it { expect { subject }.to change { category1.reload.index }.from(1).to(2) }
          it { expect { subject }.to change { category2.reload.index }.from(2).to(0) }

          it do
            subject
            expect(Menu::Category.order(:index).pluck(:id)).to eq([category2.id, category0.id, category1.id])
          end
        end

        context "when moving the middle one as last one" do
          let(:to_index) { 9 }
          let(:category) { category1 }

          it { expect { subject }.not_to(change { category0.reload.index }) }

          it { expect { subject }.to change { category1.reload.index }.from(1).to(2) }
          it { expect { subject }.to(change { category1.reload.updated_at }) }
          it { expect { subject }.to change { category2.reload.index }.from(2).to(1) }
          it { expect { subject }.to(change { category2.reload.updated_at }) }
        end

        context "when (fake) moving the first one as the first one" do
          let(:category) { category0 }
          let(:to_index) { 0 }

          it { expect { subject }.not_to(change { Menu::Category.order(:id).pluck(:updated_at) }) }
          it { expect { subject }.not_to(change { Menu::Category.order(:id).pluck(:index) }) }
        end
      end
    end
  end
end
