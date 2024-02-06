# frozen_string_literal: true

require 'rails_helper'

ADMIN_MENU_ALLERGEN_ITEM = 'ADMIN_MENU_ALLERGEN_ITEM'
RSpec.shared_context ADMIN_MENU_ALLERGEN_ITEM do |options = {}|
  it 'should include all basic information' do
    is_expected.to include(
                     id: Integer,
                     created_at: String,
                     updated_at: String,
                     images: Array,
                   )
  end

  if options[:has_name] == true
    it 'should have name' do
      is_expected.to include(
                       name: String,
                     )
    end
  elsif options[:has_name] == false
    it 'should NOT have name' do
      is_expected.to include(
                       name: nil,
                     )
    end
  end

  if options[:has_description] == true
    it 'should have description' do
      is_expected.to include(
                       description: String,
                     )
    end
  elsif options[:has_description] == false
    it 'should NOT have description' do
      is_expected.to include(
                       description: nil,
                     )
    end
  end

  if options[:has_images] == true
    it 'should have images' do
      expect(subject[:images]&.length).to be_positive
    end
  elsif options[:has_images] == false
    it 'should NOT have images' do
      is_expected.to include(
                       images: []
                     )
    end
  end
end

RSpec.describe V1::Admin::Menu::AllergensController, type: :controller do
  include_context CONTROLLER_UTILS_CONTEXT
  include_context CONTROLLER_AUTHENTICATION_CONTEXT
  include_context TESTS_OPTIMIZATIONS_CONTEXT

  let(:instance) { described_class.new }

  def create_menu_allergens(count, attrs = {})
    items = count.times.map do |i|
      build(:menu_allergen, attrs)
    end

    Menu::Allergen.import! items, validate: false
  end

  let(:user) { create(:user) }

  context '#index' do
    it { expect(instance).to respond_to(:index) }
    it { expect(described_class).to route(:get, '/v1/admin/menu/allergens').to(action: :index, format: :json) }

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

    context 'should return all allergens, paginated' do
      before do
        authenticate_request(user: user)
        create_menu_allergens(10)
      end

      it { expect(Menu::Allergen.count).to eq 10 }
      it { expect(Menu::Allergen.all.pluck(:status)).to all(eq 'active') }

      context 'without pagination params' do
        before do
          create_menu_allergens(20)
          req
        end

        it { expect(Menu::Allergen.count).to eq 30 }
        it { expect(Menu::Allergen.all.pluck(:status)).to all(eq 'active') }

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

      context 'when calling all pages to get all allergens' do
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
      before { authenticate_request(user: user) }

      context 'returned items should contain all relevant information' do
        let!(:images) { create_list(:image, 2, :with_attached_image) }

        let!(:allergen) do
          create(:menu_allergen, name: nil, description: nil).tap do |cat|
            cat.images << images
          end
        end

        before { req }

        subject { parsed_response_body[:items].first }

        context 'checking test data' do
          it { expect(Menu::Allergen.count).to eq 1 }
          it { expect(subject).to be_a(Hash) }
          it { expect(Menu::Allergen.find(subject[:id])).to be_a(Menu::Allergen) }
          it { expect(allergen.images).not_to be_empty }
          it { expect(allergen.images.count).to be_positive }
        end

        it_behaves_like ADMIN_MENU_ALLERGEN_ITEM, has_name: false, has_description: false, has_images: true

        it { expect(subject[:images].count).to eq 2 }
      end

      context 'when filtering by query' do
        before do
          5.times.each do |i|
            create(:menu_allergen, name: "Allergen ##{i + 1}!!!", description: "Description for ##{i + 1}!!!")
          end
        end

        context 'checking test data' do
          it { expect(Menu::Allergen.count).to eq 5 }
          it { expect(Menu::Allergen.all).to all(be_valid) }
          it { expect(Menu::Allergen.all.map(&:name)).to all(be_present) }
          it { expect(Menu::Allergen.all.map(&:name)).to all(be_a String) }
          it { expect(Menu::Allergen.all.map(&:description)).to all(be_present) }
          it { expect(Menu::Allergen.all.map(&:description)).to all(be_a String) }
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

        context "when querying with {query: 'Allergen #1'} should return just the first item" do
          subject do
            req(query: 'Allergen #1')
            parsed_response_body[:items]
          end

          it { expect(subject.count).to eq 1 }
          it { expect(subject.map { |j| j[:id] }.uniq.count).to eq 1 }
          it { expect(subject.first[:name]).to eq 'Allergen #1!!!' }
        end

        context "when querying with {query: 'Description for #1'} should return just the first item" do
          subject do
            req(query: 'Description for #1')
            parsed_response_body[:items]
          end

          it { expect(subject.count).to eq 1 }
          it { expect(subject.map { |j| j[:id] }.uniq.count).to eq 1 }
          it { expect(subject.first[:name]).to eq 'Allergen #1!!!' }
          it { expect(subject.first[:description]).to eq 'Description for #1!!!' }
        end

        context "when querying with {query: 'Description for #5'} should return just the first item" do
          subject do
            req(query: 'Description for #5')
            parsed_response_body[:items]
          end

          it { expect(subject.count).to eq 1 }
          it { expect(subject.map { |j| j[:id] }.uniq.count).to eq 1 }
          it { expect(subject.first[:name]).to eq 'Allergen #5!!!' }
          it { expect(subject.first[:description]).to eq 'Description for #5!!!' }
        end
      end

      context 'should return only non-deleted items' do
        before do
          create(:menu_allergen, status: :active)
          create(:menu_allergen, status: :deleted)
        end

        subject do
          req
          parsed_response_body[:items]
        end

        it { expect(Menu::Allergen.count).to eq 2 }
        it { expect(Menu::Allergen.visible.count).to eq 1 }
        it { expect(subject).to all(include(status: 'active')) }
        it { expect(subject.size).to eq 1 }
      end
    end
  end

  context '#show' do
    def req(params = {})
      get :show, params: params
    end

    let(:allergen) { create(:menu_allergen) }

    it { expect(instance).to respond_to(:show) }
    it { expect(described_class).to route(:get, '/v1/admin/menu/allergens/2').to(action: :show, format: :json, id: 2) }

    context 'if user is unauthorized' do
      before { req(id: allergen.id) }
      it_behaves_like UNAUTHORIZED
    end

    context '(authenticated)' do
      before { authenticate_request }

      context 'basic' do
        let(:allergen) { create(:menu_allergen, name: nil, description: nil) }

        subject do
          req(id: allergen.id)
          parsed_response_body[:item]
        end

        it { expect(allergen).to be_valid }

        it { expect(response).to be_successful }
        it { expect(response).to have_http_status(:ok) }

        it_behaves_like ADMIN_MENU_ALLERGEN_ITEM, has_name: false, has_description: false, has_images: false

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

      context 'when allergen has images' do
        let(:allergen) { create(:menu_allergen, name: nil, description: nil) }
        before { allergen.images << create_list(:image, 2, :with_attached_image) }

        subject do
          req(id: allergen.id)
          parsed_response_body[:item]
        end

        it { expect(allergen).to be_valid }
        it { expect(response).to have_http_status(:ok) }

        it_behaves_like ADMIN_MENU_ALLERGEN_ITEM, has_name: false, has_description: false, has_images: true

        it { expect(subject[:images].count).to eq 2 }
      end

      context 'when allergen has name' do
        let(:allergen) { create(:menu_allergen, description: nil, name: nil) }
        before do
          allergen.update!(name: 'test')
          allergen.reload
          req(id: allergen.id)
        end

        it { expect(allergen.name).to eq 'test' }

        subject { parsed_response_body[:item] }

        it { expect(allergen).to be_valid }
        it { expect(response).to have_http_status(:ok) }

        it_behaves_like ADMIN_MENU_ALLERGEN_ITEM, has_name: true, has_description: false, has_images: false
        it { should include(name: 'test') }
      end

      context 'when allergen has description (in another language)' do
        before do
          @initial_lang = I18n.locale
          I18n.locale = (I18n.available_locales - [I18n.default_locale]).sample
          allergen.update!(description: "test-#{I18n.locale}")
          allergen.reload
          req(id: allergen.id)
        end

        after do
          I18n.locale = @initial_lang
          @initial_lang = nil
        end

        it { expect(allergen.description).to eq "test-#{I18n.locale}" }

        subject { parsed_response_body[:item] }

        it { expect(allergen).to be_valid }
        it { expect(response).to have_http_status(:ok) }

        it_behaves_like ADMIN_MENU_ALLERGEN_ITEM, has_name: true, has_description: true
        it { should include(description: "test-#{I18n.locale}") }
      end
    end
  end

  context '#create' do
    it { expect(instance).to respond_to(:create) }
    it { expect(described_class).to route(:post, '/v1/admin/menu/allergens').to(action: :create, format: :json) }

    def req(params = {})
      post :create, params: params
    end

    context 'when user is not authenticated' do
      before { req }
      it_behaves_like UNAUTHORIZED
    end

    context '(authenticated)' do
      before { authenticate_request }

      it { expect { req }.to change(Menu::Allergen, :count).by(1) }

      context 'basic' do
        subject do
          req
          parsed_response_body[:item]
        end

        it { expect(response).to have_http_status(:ok) }
        it { expect(response).to be_successful }
        it_behaves_like ADMIN_MENU_ALLERGEN_ITEM, has_name: false, has_description: false

        it { expect(subject[:images].count).to eq 0 }
      end

      context 'passing {} (empty hash)' do
        subject do
          req
          response
        end

        it "request should create a allergen" do
          expect { subject }.to change(Menu::Allergen, :count).by(1)
          expect(Menu::Allergen.count).to eq 1
        end

        it { should have_http_status(:ok) }
        it { should be_successful }

        context 'response[:item]' do
          subject do
            req
            parsed_response_body[:item]
          end

          it_behaves_like ADMIN_MENU_ALLERGEN_ITEM, has_name: false, has_description: false

          it { expect(subject[:images].count).to eq 0 }
        end
      end

      context 'passing {name: <String>}' do
        subject do
          req(name: 'test')
          response
        end

        it "request should create a allergen" do
          expect { subject }.to change(Menu::Allergen, :count).by(1)
          expect(Menu::Allergen.count).to eq 1
        end

        it { should have_http_status(:ok) }
        it { should be_successful }

        context 'response[:item]' do
          subject do
            req(name: 'test')
            parsed_response_body[:item]
          end

          it_behaves_like ADMIN_MENU_ALLERGEN_ITEM, has_name: true, has_description: false, has_images: false

          it { should include(name: 'test') }
        end
      end

      context 'passing {description: <String>}' do
        subject do
          req(description: 'test')
          response
        end

        it "request should create a allergen" do
          expect { subject }.to change(Menu::Allergen, :count).by(1)
          expect(Menu::Allergen.count).to eq 1
        end

        it { should have_http_status(:ok) }
        it { should be_successful }

        context 'response[:item]' do
          subject do
            req(description: 'test')
            parsed_response_body[:item]
          end

          it_behaves_like ADMIN_MENU_ALLERGEN_ITEM, has_name: false, has_description: true, has_images: false

          it { should include(description: 'test') }
        end
      end

      context 'passing {name: {it: <String>, en: <String>}}' do
        subject do
          Menu::Allergen.destroy_all
          req(name: { it: 'test-it', en: 'test-en' })
          response
        end

        it "request should create a allergen" do
          expect { subject }.to change(Menu::Allergen, :count).by(1)
          expect(Menu::Allergen.count).to eq 1
        end

        it { should have_http_status(:ok) }
        it { should be_successful }

        context 'response[:item]' do
          subject do
            req(name: { it: 'test-it', en: 'test-en' })
            parsed_response_body[:item]
          end

          it_behaves_like ADMIN_MENU_ALLERGEN_ITEM, has_name: true, has_description: false, has_images: false

          it { should include(name: "test-#{I18n.locale}") }

          context 'after call' do
            before { subject }
            it { expect(Menu::Allergen.count).to eq 1 }
            %i[it en].each do |locale|
              it { Mobility.with_locale(locale) { expect(Menu::Allergen.first.name).to eq "test-#{locale}" } }
              it { Mobility.with_locale(locale) { expect(Menu::Allergen.first.description).to eq nil } }
            end
          end
        end
      end

      context 'passing {description: {it: <String>, en: <String>}}' do
        subject do
          Menu::Allergen.destroy_all
          req(description: { it: 'test-it', en: 'test-en' })
          response
        end

        it "request should create a allergen" do
          expect { subject }.to change(Menu::Allergen, :count).by(1)
          expect(Menu::Allergen.count).to eq 1
        end

        it { should have_http_status(:ok) }
        it { should be_successful }

        context 'response[:item]' do
          subject do
            req(description: { it: 'test-it', en: 'test-en' })
            parsed_response_body[:item]
          end

          it_behaves_like ADMIN_MENU_ALLERGEN_ITEM, has_name: false, has_description: true, has_images: false

          it { should include(description: "test-#{I18n.locale}") }

          context 'after call' do
            before { subject }
            it { expect(Menu::Allergen.count).to eq 1 }
            %i[it en].each do |locale|
              it { Mobility.with_locale(locale) { expect(Menu::Allergen.first.description).to eq "test-#{locale}" } }
              it { Mobility.with_locale(locale) { expect(Menu::Allergen.first.name).to eq nil } }
            end
          end
        end
      end

      context 'passing {name: {it: <String>, invalid_locale: <String>}}' do
        subject do
          Menu::Allergen.destroy_all
          req(name: { it: 'test-it', invalid_locale: 'test-invalid' })
          response
        end

        it do
          expect { subject }.not_to change(Menu::Allergen, :count)
          expect(Menu::Allergen.count).to eq 0
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

        context 'after call' do
          before { subject }
          it { expect(Menu::Allergen.count).to eq 0 }
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
    it { expect(described_class).to route(:patch, '/v1/admin/menu/allergens/22').to(action: :update, format: :json, id: 22) }

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
        let!(:allergen) { create(:menu_allergen) }

        subject do
          req(id: allergen.id, name: 'test-name', description: nil)
          parsed_response_body[:item]
        end

        it { expect(response).to have_http_status(:ok) }
        it { expect(response).to be_successful }

        it_behaves_like ADMIN_MENU_ALLERGEN_ITEM, has_name: true, has_description: false, has_images: false
      end

      context 'if cannot find allergen by id' do
        before { req(id: 'invalid') }
        subject { response }
        it_behaves_like NOT_FOUND
      end

      context 'with {name: "Hello"}' do
        let!(:allergen) { create(:menu_allergen, name: nil, description: nil) }

        subject do
          req(id: allergen.id, name: 'Hello')
          parsed_response_body[:item]
        end

        it { expect(response).to have_http_status(:ok) }
        it { expect(response).to be_successful }

        it_behaves_like ADMIN_MENU_ALLERGEN_ITEM, has_name: true, has_description: false
        it { should include(name: 'Hello') }
      end

      context 'with {description: "Hello"}' do
        let!(:allergen) { create(:menu_allergen, name: nil, description: nil) }

        subject do
          req(id: allergen.id, description: 'Hello')
          parsed_response_body[:item]
        end

        it { expect(response).to have_http_status(:ok) }
        it { expect(response).to be_successful }
        it_behaves_like ADMIN_MENU_ALLERGEN_ITEM, has_name: false, has_description: true
        it { should include(description: 'Hello') }
      end

      context 'with {name: {it: "Hello", en: "Hello"}}' do
        let!(:allergen) { create(:menu_allergen, description: nil) }

        subject do
          req(id: allergen.id, name: { it: 'Ciao', en: 'Hello' })
          parsed_response_body[:item]
        end

        it { expect(response).to have_http_status(:ok) }
        it { expect(response).to be_successful }
        it_behaves_like ADMIN_MENU_ALLERGEN_ITEM, has_name: true, has_description: false, has_images: false
        it { should include(name: 'Hello') }

        context 'after request' do
          before { req(id: allergen.id, name: { it: 'Ciao', en: 'Hello' }) }
          subject { allergen.reload }
          it { Mobility.with_locale(:it) { expect(subject.name).to eq 'Ciao' } }
          it { Mobility.with_locale(:it) { expect(subject.description).to eq nil } }
          it { Mobility.with_locale(:en) { expect(subject.name).to eq 'Hello' } }
          it { Mobility.with_locale(:en) { expect(subject.description).to eq nil } }
          it { expect(subject.name).to eq 'Hello' }
          it { expect(subject.name_it).to eq 'Ciao' }
          it { expect(subject.name_en).to eq 'Hello' }
        end
      end

      context 'with {description: {it: "Hello", en: "Hello"}}' do
        let!(:allergen) { create(:menu_allergen, name: nil, description: nil) }

        subject do
          req(id: allergen.id, description: { it: 'Ciao', en: 'Hello' })
          parsed_response_body[:item]
        end

        it { expect(response).to have_http_status(:ok) }
        it { expect(response).to be_successful }
        it_behaves_like ADMIN_MENU_ALLERGEN_ITEM, has_name: false, has_description: true, has_images: false

        it { should include(description: 'Hello') }

        context 'after request' do
          before { req(id: allergen.id, description: { it: 'Ciao', en: 'Hello' }) }
          subject { allergen.reload }
          it { expect(subject.description).to eq 'Hello' }
          it { expect(subject.description_it).to eq 'Ciao' }
          it { expect(subject.description_en).to eq 'Hello' }
        end
      end

      context 'passing {name: {it: <String>, invalid_locale: <String>}}' do
        let!(:allergen) { create(:menu_allergen) }
        let(:params) { { id: allergen.id, name: { it: 'test-it', invalid_locale: 'test-invalid' } } }

        subject do
          req params
          response
        end

        it do
          expect { subject }.not_to change(Menu::Allergen, :count)
          expect(Menu::Allergen.count).to eq 1
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

      context 'passing {name: nil} to a allergen with name' do
        let!(:allergen) do
          mc = create(:menu_allergen)
          Mobility.with_locale(:it) { mc.update!(name: 'test-it') }
          Mobility.with_locale(:en) { mc.update!(name: 'test-en') }
          mc.reload
          mc
        end

        subject do
          req(id: allergen.id, name: nil)
          parsed_response_body[:item]
        end

        context 'checking mock data' do
          it { expect(allergen.name).to eq 'test-en' }
          it { expect(allergen.name_en).to eq 'test-en' }
          it { expect(allergen.name_it).to eq 'test-it' }
        end

        it { expect(response).to have_http_status(:ok) }
        it { expect(response).to be_successful }
        it { expect(subject[:name]).to eq nil }

        context 'after request' do
          before { req(id: allergen.id, name: nil) }
          subject { allergen.reload }
          it { expect(subject.name).to eq nil }
          it { expect(subject.name_en).to eq nil }
          it { expect(subject.name_it).to eq 'test-it' }
        end
      end

      context 'passing {name: { it: nil, en: nil } } to a allergen with name in both langauges' do
        let!(:allergen) do
          mc = create(:menu_allergen)
          Mobility.with_locale(:it) { mc.update!(name: 'test-it') }
          Mobility.with_locale(:en) { mc.update!(name: 'test-en') }
          mc.reload
          mc
        end

        subject do
          req(id: allergen.id, name: { it: nil, en: nil })
          parsed_response_body[:item]
        end

        context 'checking mock data' do
          it { expect(allergen.name).to eq 'test-en' }
          it { expect(allergen.name_en).to eq 'test-en' }
          it { expect(allergen.name_it).to eq 'test-it' }
        end

        it { expect(response).to have_http_status(:ok) }
        it { expect(response).to be_successful }
        it { expect(subject[:name]).to eq nil }

        context 'after request' do
          before { req(id: allergen.id, name: { it: nil, en: nil }) }
          subject { allergen.reload }

          it { expect(subject.name).to eq nil }
          it { expect(subject.name_en).to eq nil }
          it { expect(subject.name_it).to eq nil }
        end
      end

      context 'when setting name to nil with {name: nil}' do
        let!(:allergen) { create(:menu_allergen, name: 'Allergen name') }

        subject do
          req(id: allergen.id, name: nil)
          parsed_response_body[:item]
        end

        it { should include(name: nil) }
      end

      context 'when setting name to nil with {name: {<locale>: nil}}' do
        let!(:allergen) { create(:menu_allergen, name: 'Allergen name') }

        subject do
          req(id: allergen.id, name: { en: nil })
          parsed_response_body[:item]
        end

        it { should include(name: nil) }
      end
    end
  end

  context '#destroy' do
    it { expect(instance).to respond_to(:destroy) }
    it { expect(described_class).to route(:DELETE, '/v1/admin/menu/allergens/22').to(action: :destroy, format: :json, id: 22) }

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
        let!(:allergen) { create(:menu_allergen) }

        subject do
          req(id: allergen.id)
          response
        end

        it { expect { subject }.to change { Menu::Allergen.visible.count }.by(-1) }
        it { should have_http_status(:no_content) }
        it { should be_successful }
      end

      context 'when cannot delete record' do
        let!(:allergen) { create(:menu_allergen) }
        before { allow_any_instance_of(Menu::Allergen).to receive(:deleted!).and_return(false) }

        subject do
          req(id: allergen.id)
          response
        end

        it { expect { subject }.not_to change { Menu::Allergen.visible.count } }
        it { should have_http_status(:unprocessable_entity) }
        it { should_not be_successful }
      end

      context 'when record deletion raises error' do
        let!(:allergen) { create(:menu_allergen) }
        before { allow_any_instance_of(Menu::Allergen).to receive(:deleted!).and_raise(ActiveRecord::RecordInvalid) }

        subject do
          req(id: allergen.id)
          response
        end

        it { expect { subject }.not_to change { Menu::Allergen.visible.count } }
        it { should have_http_status(:unprocessable_entity) }
        it { should_not be_successful }
      end

      context 'if cannot find allergen by id' do
        before { req(id: 22) }
        subject { response }
        it_behaves_like NOT_FOUND
      end
    end
  end
end
