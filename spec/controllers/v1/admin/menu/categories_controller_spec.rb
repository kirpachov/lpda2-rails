# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V1::Admin::Menu::CategoriesController, type: :controller do
  include_context CONTROLLER_UTILS_CONTEXT
  include_context CONTROLLER_AUTHENTICATION_CONTEXT
  include_context TESTS_OPTIMIZATIONS_CONTEXT

  let(:instance) { described_class.new }

  def create_menu_categories(count, attrs = {})
    attrs[:menu_visibility] ||= create(:menu_visibility)

    items = count.times.map do |i|
      build(:menu_category, attrs.merge(index: i + 1))
    end

    Menu::Category.import! items, validate: false
  end

  context '#index' do
    it { expect(instance).to respond_to(:index) }
    it { expect(described_class).to route(:get, '/v1/admin/menu/categories').to(action: :index, format: :json) }

    def req(params = {})
      get :index, params: params
    end

    context 'when user is not authenticated' do
      before { req }
      it_behaves_like UNAUTHORIZED
    end

    context 'when user is authenticated' do
      before do
        authenticate_request
        req
      end

      subject { response }
      it { should have_http_status(:ok) }
      context 'response' do
        subject { parsed_response_body }
        it { should be_a(Hash) }
        it { should include(items: Array, metadata: Hash) }
      end
    end

    context 'should return all categories, paginated' do
      before do
        authenticate_request
        create_menu_categories(10)
      end

      it { expect(Menu::Category.count).to eq 10 }
      it { expect(Menu::Category.all.pluck(:status)).to all(eq 'active') }

      context 'without pagination params' do
        before do
          create_menu_categories(20)
          req
        end

        it { expect(Menu::Category.count).to eq 30 }
        it { expect(Menu::Category.all.pluck(:status)).to all(eq 'active') }

        subject { parsed_response_body }

        it { expect(subject[:items].size).to eq 10 }
        it { expect(subject[:metadata][:total_count]).to eq 30 }
        it { expect(subject[:metadata][:current_page]).to eq 1 }
        it { expect(subject[:metadata][:per_page]).to eq 10 }
      end

      context 'page 1' do
        before { req(page: 1, per_page: 3) }

        subject { parsed_response_body }
        it { expect(subject[:items].size).to eq 3 }
        it { expect(subject[:metadata][:total_count]).to eq 10 }
        it { expect(subject[:metadata][:current_page]).to eq 1 }
        it { expect(subject[:metadata][:per_page]).to eq 3 }
      end

      context 'page 2' do
        before { req(page: 2, per_page: 3) }

        subject { parsed_response_body }
        it { expect(subject[:items].size).to eq 3 }
        it { expect(subject[:metadata][:total_count]).to eq 10 }
        it { expect(subject[:metadata][:current_page]).to eq 2 }
        it { expect(subject[:metadata][:per_page]).to eq 3 }

        context 'should equal to offset 1' do
          before do
            @page1 = parsed_response_body
            req(offset: 1, per_page: 3)
            @offset0 = parsed_response_body
          end

          it { expect(@page1).to eq @offset0 }
        end
      end

      context 'page 4' do
        before { req(page: 4, per_page: 3) }

        subject { parsed_response_body }
        it { expect(subject[:items].size).to eq 1 }
        it { expect(subject[:metadata][:total_count]).to eq 10 }
        it { expect(subject[:metadata][:current_page]).to eq 4 }
        it { expect(subject[:metadata][:per_page]).to eq 3 }
      end

      context 'page 10' do
        before { req(page: 10, per_page: 3) }

        subject { parsed_response_body }
        it { expect(subject[:items].size).to eq 0 }
        it { expect(subject[:metadata][:total_count]).to eq 10 }
        it { expect(subject[:metadata][:current_page]).to eq 10 }
        it { expect(subject[:metadata][:per_page]).to eq 3 }
      end

      context 'when calling all pages to get all categories' do
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

    context '(authenticated)' do
      before { authenticate_request }

      context 'returned items should be ordered by :index by default' do
        before { create_menu_categories(2) }
        it { expect(Menu::Category.count).to eq 2 }
        it { expect(Menu::Category.all.pluck(:status)).to all(eq 'active') }
        it { expect(Menu::Category.all.pluck(:index).sort!).to eq [1, 2].sort! }

        context 'simple case - no params' do
          before { req }

          subject { parsed_response_body[:items] }
          it { expect(subject).to be_a(Array) }
          it { expect(subject.count).to eq 2 }
          it { expect(subject[0][:index]).to eq 1 }
          it { expect(subject[1][:index]).to eq 2 }
        end

        context 'by switching indexes' do
          before do
            Menu::Category.all.map do |item|
              item.update!(index: item.index + 2)
            end

            @first = Menu::Category.create!(index: 1)
            @last = Menu::Category.create!(index: 10)
            req
          end

          it { expect(Menu::Category.count).to eq 4 }
          it { expect(Menu::Category.all.order(:index).pluck(:index)).to eq [1, 3, 4, 10] }

          subject { parsed_response_body[:items] }
          it { expect(subject).to be_a(Array) }
          it { expect(subject.map { |j| j[:id] }).to eq Menu::Category.order(:index).pluck(:id) }
        end
      end

      context 'returned items should contain all relevant information' do
        let!(:images) { create_list(:image, 2, :with_attached_image) }

        let!(:category) do
          create(:menu_category).tap do |cat|
            cat.images << images
          end
        end

        before { req }

        subject { parsed_response_body[:items].first }

        context 'checking test data' do
          it { expect(Menu::Category.count).to eq 1 }
          it { expect(subject).to be_a(Hash) }
          it { expect(Menu::Category.find(subject[:id])).to be_a(Menu::Category) }
          it { expect(category.visibility).to be_present }
          it { expect(category.images).not_to be_empty }
          it { expect(category.images.count).to be_positive }
        end

        it_behaves_like ADMIN_MENU_CATEGORY
        it { should include(
                      parent_id: NilClass,
                      name: NilClass,
                      description: NilClass,
                      secret_desc: NilClass,
                    ) }

        it { expect(subject[:images].count).to eq 2 }
      end

      context 'when filtering by parent_id' do
        before do
          @parent = create(:menu_category)
          create_list(:menu_category, 2, parent: @parent)
          create_list(:menu_category, 2)
        end

        context 'checking test data' do
          it { expect(Menu::Category.count).to eq 2 + 2 + 1 }
          it { expect(Menu::Category.where(parent_id: nil).count).to eq 2 + 1 }
          it { expect(Menu::Category.where.not(parent_id: nil).count).to eq 2 }
        end

        context '<id>: after request' do
          before { req(parent_id: @parent.id) }

          context 'response' do
            subject { parsed_response_body[:items] }
            it { expect(subject.count).to eq 2 }
            it { expect(subject.map { |j| j[:id] }.uniq.count).to eq 2 }
            it { expect(Menu::Category.where(id: subject.map { |j| j[:id] }.uniq).pluck(:id)).to match_array(Menu::Category.where(parent: @parent).pluck(:id)) }
          end

          context 'metadata' do
            subject { parsed_response_body[:metadata] }
            it { expect(subject[:total_count]).to eq 2 }
            it { expect(subject[:current_page]).to eq 1 }
            it { expect(subject[:per_page]).to eq 10 }
            it { expect(subject[:params]).to be_a(Hash) }
            it { expect(subject[:params]).to include('parent_id' => @parent.id) }
          end
        end

        context 'nil: after request' do
          before { req(parent_id: nil) }

          context 'response' do
            subject { parsed_response_body[:items] }
            it { expect(subject.count).to eq 3 }
            it { expect(subject.map { |j| j[:id] }.uniq.count).to eq 3 }
            it { expect(Menu::Category.where(id: subject.map { |j| j[:id] }.uniq).pluck(:id)).to match_array(Menu::Category.where(parent_id: nil).pluck(:id)) }
          end

          context 'metadata' do
            subject { parsed_response_body[:metadata] }
            it { expect(subject[:total_count]).to eq 3 }
            it { expect(subject[:current_page]).to eq 1 }
            it { expect(subject[:per_page]).to eq 10 }
            it { expect(subject[:params]).to be_a(Hash) }
            it { expect(subject[:params]).to include('parent_id' => '') }
          end
        end
      end

      context 'when filtering by query' do
        before do
          # visibility = create(:menu_visibility)
          items = 5.times.map do |i|
            create(:menu_category, name: "Category ##{i + 1}!!!", description: "Description for ##{i + 1}!!!")
          end

          # Menu::Category.import! items, validate: false
        end

        context 'checking test data' do
          it { expect(Menu::Category.count).to eq 5 }
          it { expect(Menu::Category.all).to all(be_valid) }
          it { expect(Menu::Category.all.map(&:name)).to all(be_present) }
          it { expect(Menu::Category.all.map(&:name)).to all(be_a String) }
          it { expect(Menu::Category.all.map(&:description)).to all(be_present) }
          it { expect(Menu::Category.all.map(&:description)).to all(be_a String) }
        end

        context "when querying with {query: ''} should return all items" do
          subject do
            req(query: '')
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
            req(query: 'Category #1')
            parsed_response_body[:items]
          end

          it { expect(subject.count).to eq 1 }
          it { expect(subject.map { |j| j[:id] }.uniq.count).to eq 1 }
          it { expect(subject.first[:name]).to eq 'Category #1!!!' }
        end

        context "when querying with {query: 'Description for #1'} should return just the first item" do
          subject do
            req(query: 'Description for #1')
            parsed_response_body[:items]
          end

          it { expect(subject.count).to eq 1 }
          it { expect(subject.map { |j| j[:id] }.uniq.count).to eq 1 }
          it { expect(subject.first[:name]).to eq 'Category #1!!!' }
          it { expect(subject.first[:description]).to eq 'Description for #1!!!' }
        end

        context "when querying with {query: 'Description for #5'} should return just the first item" do
          subject do
            req(query: 'Description for #5')
            parsed_response_body[:items]
          end

          it { expect(subject.count).to eq 1 }
          it { expect(subject.map { |j| j[:id] }.uniq.count).to eq 1 }
          it { expect(subject.first[:name]).to eq 'Category #5!!!' }
          it { expect(subject.first[:description]).to eq 'Description for #5!!!' }
        end
      end

      context 'when filtering by {fixed_price: true}' do
        before do
          # visibility = create(:menu_visibility)
          items = 5.times.map do |i|
            create(:menu_category, price: (i + 1) * 10)
          end

          create_list(:menu_category, 5, price: nil)

          # Menu::Category.import! items, validate: false
        end

        context 'checking test data' do
          subject { Menu::Category.all }
          it do
            expect(subject.map(&:price).uniq).to match_array([nil, 10, 20, 30, 40, 50])
            expect(subject.map(&:price?)).to match_array([false] * 5 + [true] * 5)
            expect(subject.count).to eq 10
          end
        end

        context 'when querying with {fixed_price: true}' do
          before { req(fixed_price: true) }
          context 'items' do
            subject { parsed_response_body[:items] }
            it { expect(subject.count).to eq 5 }
            it { expect(subject.map { |j| j[:id] }.uniq.count).to eq 5 }
            it { expect(subject.map { |j| j[:price] }.uniq).to all(be_positive) }
            it { expect(subject.map { |j| j[:price] }.uniq).to all(be_a(Numeric)) }
          end

          context 'metadata' do
            subject { parsed_response_body[:metadata] }
            it { should be_a(Hash) }
            it { should include(params: { fixed_price: true }) }
          end
        end
      end

      context 'when filtering for {fixed_price: false}' do
        before do
          # visibility = create(:menu_visibility)
          items = 5.times.map do |i|
            create(:menu_category, price: (i + 1) * 10)
          end

          create_list(:menu_category, 5, price: nil)

          # Menu::Category.import! items, validate: false
        end

        context 'checking test data' do
          subject { Menu::Category.all }
          it do
            expect(subject.map(&:price).uniq).to match_array([nil, 10, 20, 30, 40, 50])
            expect(subject.map(&:price?)).to match_array([false] * 5 + [true] * 5)
            expect(subject.count).to eq 10
          end
        end

        context 'when querying with {fixed_price: false}' do
          before { req(fixed_price: false) }
          context 'items' do
            subject { parsed_response_body[:items] }
            it { expect(subject.count).to eq 5 }
            it { expect(subject.map { |j| j[:id] }.uniq.count).to eq 5 }
            it { expect(subject.map { |j| j[:price] }.uniq).to eq [nil] }
          end

          context 'metadata' do
            subject { parsed_response_body[:metadata] }
            it { should be_a(Hash) }
            it { should include(params: { fixed_price: false }) }
          end
        end
      end
    end
  end

  context '#show' do
    def req(params = {})
      get :show, params: params
    end

    let(:category) { create(:menu_category) }

    it { expect(instance).to respond_to(:show) }
    it { expect(described_class).to route(:get, '/v1/admin/menu/categories/2').to(action: :show, format: :json, id: 2) }

    context 'if user is unauthorized' do
      before { req(id: category.id) }
      it_behaves_like UNAUTHORIZED
    end

    context '(authenticated)' do
      before { authenticate_request }

      context 'basic' do
        subject do
          req(id: category.id)
          parsed_response_body[:item]
        end

        it { expect(category).to be_valid }
        it { expect(category.visibility).to be_persisted }

        it { expect(response).to be_successful }
        it { expect(response).to have_http_status(:ok) }

        it_behaves_like ADMIN_MENU_CATEGORY
        it { should include(
                      parent_id: NilClass,
                      name: NilClass,
                      description: NilClass,
                      secret_desc: NilClass,
                    ) }

        it { expect(subject[:images].count).to eq 0 }
      end

      context 'when passing a invalid id' do
        before { req(id: 'invalid') }
        subject { response }
        it_behaves_like NOT_FOUND
      end

      context 'when passing a invalid id' do
        before { req(id: 999_999) }
        subject { response }
        it_behaves_like NOT_FOUND
      end

      context 'when category has images' do
        before { category.images << create_list(:image, 2, :with_attached_image) }

        subject do
          req(id: category.id)
          parsed_response_body[:item]
        end

        it { expect(category).to be_valid }
        it { expect(response).to have_http_status(:ok) }

        it_behaves_like ADMIN_MENU_CATEGORY
        it { should include(
                      parent_id: NilClass,
                      name: NilClass,
                      description: NilClass,
                      secret_desc: NilClass,
                    ) }

        it { expect(subject[:images].count).to eq 2 }
      end

      context 'when category has parent' do
        let(:parent) { create(:menu_category) }
        let(:category) { create(:menu_category, parent: parent) }

        subject do
          req(id: category.id)
          parsed_response_body[:item]
        end

        it { expect(category).to be_valid }
        it { expect(category.parent).to be_a(Menu::Category) }
        it { expect(response).to have_http_status(:ok) }

        it_behaves_like ADMIN_MENU_CATEGORY
        it { should include(
                      parent_id: Integer,
                      name: NilClass,
                      description: NilClass,
                      secret_desc: NilClass,
                      parent: Hash
                    ) }
      end

      context 'when category has name' do
        before do
          category.update!(name: 'test')
          category.reload
          req(id: category.id)
        end

        it { expect(category.name).to eq 'test' }

        subject { parsed_response_body[:item] }

        it { expect(category).to be_valid }
        it { expect(response).to have_http_status(:ok) }

        it_behaves_like ADMIN_MENU_CATEGORY
        it { should include(name: 'test') }
      end

      context 'when category has description (in another language)' do
        before do
          I18n.locale = (I18n.available_locales - [I18n.default_locale]).sample
          category.update!(description: "test-#{I18n.locale}")
          category.reload
          req(id: category.id)
        end

        after { I18n.locale = I18n.default_locale }

        it { expect(category.description).to eq "test-#{I18n.locale}" }

        subject { parsed_response_body[:item] }

        it { expect(category).to be_valid }
        it { expect(response).to have_http_status(:ok) }

        it_behaves_like ADMIN_MENU_CATEGORY
        it { should include(description: "test-#{I18n.locale}") }
      end
    end
  end

  context '#create' do
    it { expect(instance).to respond_to(:create) }
    it { expect(described_class).to route(:post, '/v1/admin/menu/categories').to(action: :create, format: :json) }

    def req(params = {})
      post :create, params: params
    end

    context 'when user is not authenticated' do
      before { req }
      it_behaves_like UNAUTHORIZED
    end

    context '(authenticated)' do
      before { authenticate_request }

      it { expect { req }.to change(Menu::Category, :count).by(1) }

      context 'basic' do
        subject do
          req
          parsed_response_body[:item]
        end

        it { expect(response).to have_http_status(:ok) }
        it { expect(response).to be_successful }
        it_behaves_like ADMIN_MENU_CATEGORY
        it { should include(
                      parent_id: NilClass,
                      name: NilClass,
                      description: NilClass,
                      secret_desc: NilClass,
                    ) }

        it { expect(subject[:images].count).to eq 0 }
      end

      context 'passing {parent_id: <id>}' do
        let!(:parent) { create(:menu_category) }
        subject do
          req(parent_id: parent.id)
          response
        end

        it "request should create a category child" do
          expect { subject }.to change(Menu::Category, :count).by(1)
          expect(Menu::Category.count).to eq 2
          expect(Menu::Category.with_parent.last.parent).to eq parent
          expect(Menu::Category.with_parent.count).to eq 1
          expect(Menu::Category.without_parent.count).to eq 1
        end

        it { should have_http_status(:ok) }
        it { should be_successful }

        context 'response[:item]' do
          subject do
            req(parent_id: parent.id)
            parsed_response_body[:item]
          end

          it_behaves_like ADMIN_MENU_CATEGORY

          it { should include(
                        parent_id: Integer,
                        name: NilClass,
                        description: NilClass,
                        secret_desc: NilClass,
                      ) }

          it { expect(subject[:images].count).to eq 0 }
        end
      end

      context 'passing {} (empty hash)' do
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

        it { should have_http_status(:ok) }
        it { should be_successful }

        context 'response[:item]' do
          subject do
            req
            parsed_response_body[:item]
          end

          it_behaves_like ADMIN_MENU_CATEGORY

          it { should include(
                        parent_id: NilClass,
                        name: NilClass,
                        description: NilClass,
                        secret_desc: NilClass,
                      ) }

          it { expect(subject[:images].count).to eq 0 }
        end
      end

      context 'passing {name: <String>}' do
        subject do
          req(name: 'test')
          response
        end

        it "request should create a category" do
          expect { subject }.to change(Menu::Category, :count).by(1)
          expect(Menu::Category.count).to eq 1
          expect(Menu::Category.with_parent.count).to eq 0
          expect(Menu::Category.without_parent.count).to eq 1
        end

        it { should have_http_status(:ok) }
        it { should be_successful }

        context 'response[:item]' do
          subject do
            req(name: 'test')
            parsed_response_body[:item]
          end

          it_behaves_like ADMIN_MENU_CATEGORY

          it { should include(
                        parent_id: NilClass,
                        name: 'test',
                        description: NilClass,
                        secret_desc: NilClass,
                      ) }

          it { expect(subject[:images].count).to eq 0 }
        end
      end

      context 'passing {description: <String>}' do
        subject do
          req(description: 'test')
          response
        end

        it "request should create a category" do
          expect { subject }.to change(Menu::Category, :count).by(1)
          expect(Menu::Category.count).to eq 1
          expect(Menu::Category.with_parent.count).to eq 0
          expect(Menu::Category.without_parent.count).to eq 1
        end

        it { should have_http_status(:ok) }
        it { should be_successful }

        context 'response[:item]' do
          subject do
            req(description: 'test')
            parsed_response_body[:item]
          end

          it_behaves_like ADMIN_MENU_CATEGORY

          it { should include(
                        parent_id: NilClass,
                        name: NilClass,
                        description: 'test',
                        secret_desc: NilClass,
                      ) }

          it { expect(subject[:images].count).to eq 0 }
        end
      end

      context 'passing {name: <String>, description: <String>, parent_id: <id>}' do
        let!(:parent) { create(:menu_category) }
        subject do
          req(name: 'test', description: 'test', parent_id: parent.id)
          response
        end

        it "request should create a category" do
          expect { subject }.to change(Menu::Category, :count).by(1)
          expect(Menu::Category.count).to eq 2
          expect(Menu::Category.with_parent.count).to eq 1
          expect(Menu::Category.without_parent.count).to eq 1
        end

        it { should have_http_status(:ok) }
        it { should be_successful }

        context 'response[:item]' do
          subject do
            req(name: 'test', description: 'test', parent_id: parent.id)
            parsed_response_body[:item]
          end

          it_behaves_like ADMIN_MENU_CATEGORY

          it { should include(
                        parent_id: Integer,
                        name: 'test',
                        description: 'test',
                        secret_desc: NilClass,
                      ) }

          it { expect(subject[:images].count).to eq 0 }
        end
      end

      context 'passing {name: {it: <String>, en: <String>}}' do
        subject do
          req(name: { it: 'test-it', en: 'test-en' })
          response
        end

        it "request should create a category" do
          expect { subject }.to change(Menu::Category, :count).by(1)
          expect(Menu::Category.count).to eq 1
          expect(Menu::Category.with_parent.count).to eq 0
          expect(Menu::Category.without_parent.count).to eq 1
        end

        it { should have_http_status(:ok) }
        it { should be_successful }

        context 'response[:item]' do
          subject do
            req(name: { it: 'test-it', en: 'test-en' })
            parsed_response_body[:item]
          end

          it_behaves_like ADMIN_MENU_CATEGORY

          it { should include(
                        parent_id: NilClass,
                        name: "test-#{I18n.locale}",
                        description: NilClass,
                        secret_desc: NilClass,
                      ) }

          it { expect(subject[:images].count).to eq 0 }
        end
      end

      context 'passing {description: {it: <String>, en: <String>}}' do
        subject do
          req(description: { it: 'test-it', en: 'test-en' })
          response
        end

        it "request should create a category" do
          expect { subject }.to change(Menu::Category, :count).by(1)
          expect(Menu::Category.count).to eq 1
          expect(Menu::Category.with_parent.count).to eq 0
          expect(Menu::Category.without_parent.count).to eq 1
        end

        it { should have_http_status(:ok) }
        it { should be_successful }

        context 'response[:item]' do
          subject do
            req(description: { it: 'test-it', en: 'test-en' })
            parsed_response_body[:item]
          end

          it_behaves_like ADMIN_MENU_CATEGORY

          it { should include(
                        parent_id: NilClass,
                        name: NilClass,
                        description: "test-#{I18n.locale}",
                        secret_desc: NilClass,
                      ) }

          it { expect(subject[:images].count).to eq 0 }
        end
      end

      context 'passing {name: {it: <String>, invalid_locale: <String>}}' do
        subject do
          req(name: { it: 'test-it', invalid_locale: 'test-invalid' })
          response
        end

        it do
          expect { subject }.not_to change(Menu::Category, :count)
          expect(Menu::Category.count).to eq 0
        end

        it { should have_http_status(:unprocessable_entity) }
        it { should_not be_successful }

        context 'response[:item]' do
          subject do
            req(name: { it: 'test-it', invalid_locale: 'test-invalid' })
            parsed_response_body[:item]
          end

          it { should be_nil }
        end

        context 'response[:message]' do
          subject do
            req(name: { it: 'test-it', invalid_locale: 'test-invalid' })
            parsed_response_body[:message]
          end

          it { should be_a(String) }
          it { should include(I18n.t('errors.messages.invalid_locale', lang: :invalid_locale)) }
        end

        context 'response[:details]' do
          subject do
            req(name: { it: 'test-it', invalid_locale: 'test-invalid' })
            parsed_response_body[:details]
          end

          it { should be_a(Hash) }
          it { should include(:name) }
          it { should include(name: Array) }
        end

        context 'response[:details][:name]' do
          subject do
            req(name: { it: 'test-it', invalid_locale: 'test-invalid' })
            parsed_response_body[:details][:name]
          end

          it { should be_a(Array) }
          it { should_not be_empty }
          it { should all(be_a(Hash)) }
          it { should all(include(:attribute, :raw_type, :type, :options, :message)) }
        end
      end
    end
  end

  context '#update' do
    it { expect(instance).to respond_to(:update) }
    it { expect(described_class).to route(:patch, '/v1/admin/menu/categories/22').to(action: :update, format: :json, id: 22) }

    def req(params = {})
      patch :update, params: params
    end

    context 'when user is not authenticated' do
      before { req(id: 22) }
      it_behaves_like UNAUTHORIZED
    end

    context '(authenticated)' do
      before { authenticate_request }

      context 'basic' do
        let!(:category) { create(:menu_category) }

        subject do
          req(id: category.id)
          parsed_response_body[:item]
        end

        it { expect(response).to have_http_status(:ok) }
        it { expect(response).to be_successful }
        it_behaves_like ADMIN_MENU_CATEGORY
        it { should include(
                      parent_id: NilClass,
                      name: NilClass,
                      description: NilClass,
                      secret_desc: NilClass,
                      images: []
                    ) }
      end

      context 'if cannot find category by id' do
        before { req(id: 'invalid') }
        subject { response }
        it_behaves_like NOT_FOUND
      end

      context 'with {name: "Hello"}' do
        let!(:category) { create(:menu_category) }

        subject do
          req(id: category.id, name: 'Hello')
          parsed_response_body[:item]
        end

        it { expect(response).to have_http_status(:ok) }
        it { expect(response).to be_successful }
        it_behaves_like ADMIN_MENU_CATEGORY
        it { should include(
                      parent_id: NilClass,
                      name: 'Hello',
                      description: NilClass,
                      secret_desc: NilClass,
                      images: []
                    ) }
      end

      context 'with {description: "Hello"}' do
        let!(:category) { create(:menu_category) }

        subject do
          req(id: category.id, description: 'Hello')
          parsed_response_body[:item]
        end

        it { expect(response).to have_http_status(:ok) }
        it { expect(response).to be_successful }
        it_behaves_like ADMIN_MENU_CATEGORY
        it { should include(
                      parent_id: NilClass,
                      name: NilClass,
                      description: 'Hello',
                      secret_desc: NilClass,
                      images: []
                    ) }
      end

      context 'with {secret_desc: "Hello"}' do
        let!(:category) { create(:menu_category) }

        subject do
          req(id: category.id, secret_desc: 'Hello')
          parsed_response_body[:item]
        end

        it { expect(response).to have_http_status(:ok) }
        it { expect(response).to be_successful }
        it_behaves_like ADMIN_MENU_CATEGORY
        it { should include(
                      parent_id: NilClass,
                      name: NilClass,
                      description: NilClass,
                      secret_desc: 'Hello',
                      images: []
                    ) }
      end

      context 'with {name: "Hello", description: "Hello", secret_desc: "Hello"}' do
        let!(:category) { create(:menu_category) }

        subject do
          req(id: category.id, name: 'HelloName', description: 'HelloDesc', secret_desc: 'HelloSecret')
          parsed_response_body[:item]
        end

        it { expect(response).to have_http_status(:ok) }
        it { expect(response).to be_successful }
        it_behaves_like ADMIN_MENU_CATEGORY
        it { should include(
                      parent_id: NilClass,
                      name: 'HelloName',
                      description: 'HelloDesc',
                      secret_desc: 'HelloSecret',
                      images: []
                    ) }
      end

      context 'with {name: {it: "Hello", en: "Hello"}}' do
        let!(:category) { create(:menu_category) }

        subject do
          req(id: category.id, name: { it: 'Ciao', en: 'Hello' })
          parsed_response_body[:item]
        end

        it { expect(response).to have_http_status(:ok) }
        it { expect(response).to be_successful }
        it_behaves_like ADMIN_MENU_CATEGORY
        it { should include(
                      parent_id: NilClass,
                      name: 'Hello',
                      description: NilClass,
                      secret_desc: NilClass,
                      images: []
                    ) }

        context 'after request' do
          before { req(id: category.id, name: { it: 'Ciao', en: 'Hello' }) }
          subject { category.reload }
          it { expect(subject.name).to eq 'Hello' }
          it { expect(subject.name_it).to eq 'Ciao' }
          it { expect(subject.name_en).to eq 'Hello' }
        end
      end

      context 'with {description: {it: "Hello", en: "Hello"}}' do
        let!(:category) { create(:menu_category) }

        subject do
          req(id: category.id, description: { it: 'Ciao', en: 'Hello' })
          parsed_response_body[:item]
        end

        it { expect(response).to have_http_status(:ok) }
        it { expect(response).to be_successful }
        it_behaves_like ADMIN_MENU_CATEGORY
        it { should include(
                      parent_id: NilClass,
                      name: NilClass,
                      description: 'Hello',
                      secret_desc: NilClass,
                      images: []
                    ) }

        context 'after request' do
          before { req(id: category.id, description: { it: 'Ciao', en: 'Hello' }) }
          subject { category.reload }
          it { expect(subject.description).to eq 'Hello' }
          it { expect(subject.description_it).to eq 'Ciao' }
          it { expect(subject.description_en).to eq 'Hello' }
        end
      end

      context 'with {parent_id: <id>}' do
        let!(:category) { create(:menu_category) }
        let!(:parent) { create(:menu_category) }

        subject do
          req(id: category.id, parent_id: parent.id)
          response
        end

        it { expect { subject }.not_to change(Menu::Category, :count) }
        it { expect { subject }.to change { category.reload.parent }.from(nil).to(parent) }
        it { should have_http_status(:ok) }
        it { should be_successful }

        context 'response[:item]' do
          subject do
            req(id: category.id, parent_id: parent.id)
            parsed_response_body[:item]
          end

          it_behaves_like ADMIN_MENU_CATEGORY

          it { should include(
                        parent_id: Integer,
                        name: NilClass,
                        description: NilClass,
                        secret_desc: NilClass,
                        images: []
                      ) }
        end

        context 'after request' do
          before { req(id: category.id, parent_id: parent.id) }
          subject { category.reload }
          it { expect(subject.parent).to eq parent }
        end
      end

      context 'with {parent_id: nil}' do
        let!(:parent) { create(:menu_category) }
        let!(:category) { create(:menu_category, parent: parent) }

        subject do
          req(id: category.id, parent_id: nil)
          response
        end

        it { expect { subject }.not_to change(Menu::Category, :count) }
        it { expect { subject }.to change { category.reload.parent }.from(parent).to(nil) }
        it { should have_http_status(:ok) }
        it { should be_successful }

        context 'response[:item]' do
          subject do
            req(id: category.id, parent_id: nil)
            parsed_response_body[:item]
          end

          it_behaves_like ADMIN_MENU_CATEGORY

          it { should include(
                        parent_id: NilClass,
                        name: NilClass,
                        description: NilClass,
                        secret_desc: NilClass,
                        images: []
                      ) }
        end

        context 'after request' do
          before { req(id: category.id, parent_id: nil) }
          subject { category.reload }
          it { expect(subject.parent).to eq nil }
        end
      end

      context 'passing {name: {it: <String>, invalid_locale: <String>}}' do
        let!(:category) { create(:menu_category) }
        let(:params) { { id: category.id, name: { it: 'test-it', invalid_locale: 'test-invalid' } } }

        subject do
          req params
          response
        end

        it do
          expect { subject }.not_to change(Menu::Category, :count)
          expect(Menu::Category.count).to eq 1
        end

        it { should have_http_status(:unprocessable_entity) }
        it { should_not be_successful }

        context 'response[:item]' do
          subject do
            req params
            parsed_response_body[:item]
          end

          it { should be_nil }
        end

        context 'response[:message]' do
          subject do
            req params
            parsed_response_body[:message]
          end

          it { should be_a(String) }
          it { should include(I18n.t('errors.messages.invalid_locale', lang: :invalid_locale)) }
        end

        context 'response[:details]' do
          subject do
            req params
            parsed_response_body[:details]
          end

          it { should be_a(Hash) }
          it { should include(:name) }
          it { should include(name: Array) }
        end

        context 'response[:details][:name]' do
          subject do
            req params
            parsed_response_body[:details][:name]
          end

          it { should be_a(Array) }
          it { should_not be_empty }
          it { should all(be_a(Hash)) }
          it { should all(include(:attribute, :raw_type, :type, :options, :message)) }
        end
      end

      context 'passing {secret_desc: "ciaobanana", description: {it: <String>, invalid_locale: <String>}}' do
        let!(:parent) { create(:menu_category) }
        let!(:category) { create(:menu_category, parent:) }
        let(:params) { { id: category.id, secret_desc: "ciaobanana", description: { it: 'test-it', invalid_locale: 'test-invalid' } } }

        it 'should not update parent' do
          expect { req params }.not_to change { category.reload.secret_desc }
        end

        it "checking mock data" do
          expect(category.secret_desc).to eq nil
          expect(category.description).to eq nil
        end

        subject do
          req params
          response
        end

        it { should have_http_status(:unprocessable_entity) }
        it { should_not be_successful }

        context 'response[:details][:name]' do
          subject do
            req params
            parsed_response_body[:details][:name]
          end

          it { should be_a(Array) }
          it { should_not be_empty }
          it { should all(be_a(Hash)) }
          it { should all(include(:attribute, :raw_type, :type, :options, :message)) }
        end
      end

      context 'passing {parent_id: nil, name: {it: <String>, invalid_locale: <String>}}' do
        let!(:parent) { create(:menu_category) }
        let!(:category) { create(:menu_category, parent:) }
        let(:params) { { id: category.id, parent_id: nil, name: { it: 'test-it', invalid_locale: 'test-invalid' } } }

        it 'should not update parent' do
          expect { req params }.not_to change { category.reload.parent }
        end

        context 'response[:item]' do
          subject do
            req params
            parsed_response_body[:item]
          end

          it { should be_nil }
        end

        context 'response[:message]' do
          subject do
            req params
            parsed_response_body[:message]
          end

          it { should be_a(String) }
          it { should include(I18n.t('errors.messages.invalid_locale', lang: :invalid_locale)) }
        end

        context 'response[:details]' do
          subject do
            req params
            parsed_response_body[:details]
          end

          it { should be_a(Hash) }
          it { should include(:name) }
          it { should include(name: Array) }
        end

        context 'response[:details][:name]' do
          subject do
            req params
            parsed_response_body[:details][:name]
          end

          it { should be_a(Array) }
          it { should_not be_empty }
          it { should all(be_a(Hash)) }
          it { should all(include(:attribute, :raw_type, :type, :options, :message)) }
        end
      end

      context 'passing {name: nil} to a category with name' do
        let!(:category) do
          mc = create(:menu_category)
          Mobility.with_locale(:it) { mc.update!(name: 'test-it') }
          Mobility.with_locale(:en) { mc.update!(name: 'test-en') }
          mc.reload
          mc
        end

        subject do
          req(id: category.id, name: nil)
          parsed_response_body[:item]
        end

        context 'checking mock data' do
          it { expect(category.name).to eq 'test-en' }
          it { expect(category.name_en).to eq 'test-en' }
          it { expect(category.name_it).to eq 'test-it' }
        end

        it { expect(response).to have_http_status(:ok) }
        it { expect(response).to be_successful }
        it { expect(subject[:name]).to eq nil }

        context 'after request' do
          before { req(id: category.id, name: nil) }
          subject { category.reload }
          it { expect(subject.name).to eq nil }
          it { expect(subject.name_en).to eq nil }
          it { expect(subject.name_it).to eq 'test-it' }
        end
      end
    end
  end

  context '#destroy' do
    it { expect(instance).to respond_to(:destroy) }
    it { expect(described_class).to route(:DELETE, '/v1/admin/menu/categories/22').to(action: :destroy, format: :json, id: 22) }

    def req(params = {})
      delete :destroy, params: params
    end

    context 'when user is not authenticated' do
      before { req(id: 22) }
      it_behaves_like UNAUTHORIZED
    end

    context '(authenticated)' do
      before { authenticate_request }

      context 'basic' do
        let!(:category) { create(:menu_category) }

        subject do
          req(id: category.id)
          response
        end

        it { expect { subject }.to change { Menu::Category.visible.count }.by(-1) }
        it { should have_http_status(:no_content) }
        it { should be_successful }
      end

      context 'if cannot find category by id' do
        before { req(id: 22) }
        subject { response }
        it_behaves_like NOT_FOUND
      end
    end
  end
end
