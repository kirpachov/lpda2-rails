# frozen_string_literal: true

require "rails_helper"

ADMIN_MENU_TAG_ITEM = "ADMIN_MENU_TAG_ITEM"
RSpec.shared_context ADMIN_MENU_TAG_ITEM do |options = {}|
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

  if options[:has_color] == true
    it "has color" do
      expect(subject).to include(color: String)
    end
  elsif options[:has_color] == false
    it "does not have color" do
      expect(subject).to include(color: nil)
    end
  end
end

RSpec.describe V1::Admin::Menu::TagsController, type: :controller do
  include_context CONTROLLER_UTILS_CONTEXT
  include_context CONTROLLER_AUTHENTICATION_CONTEXT
  include_context TESTS_OPTIMIZATIONS_CONTEXT

  let(:instance) { described_class.new }
  let(:user) { create(:user) }

  def create_menu_tags(count, attrs = {})
    items = count.times.map do |_i|
      build(:menu_tag, attrs)
    end

    Menu::Tag.import! items, validate: false
  end

  describe "#index" do
    it { expect(instance).to respond_to(:index) }
    it { expect(described_class).to route(:get, "/v1/admin/menu/tags").to(action: :index, format: :json) }

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

    context "should return all tags, paginated" do
      before do
        authenticate_request(user:)
        create_menu_tags(10)
      end

      it { expect(Menu::Tag.count).to eq 10 }
      it { expect(Menu::Tag.all.pluck(:status)).to all(eq "active") }

      context "without pagination params" do
        subject { parsed_response_body }

        before do
          create_menu_tags(20)
          req
        end

        it { expect(Menu::Tag.count).to eq 30 }
        it { expect(Menu::Tag.all.pluck(:status)).to all(eq "active") }

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

      context "when calling all pages to get all tags" do
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

    context "(authenticated)" do
      before { authenticate_request(user:) }

      context "returned items should contain all relevant information" do
        subject { parsed_response_body[:items].first }

        let!(:image) { create(:image, :with_attached_image) }

        let!(:tag) do
          create(:menu_tag, name: nil, description: nil).tap do |cat|
            cat.image = image
          end
        end

        before { req }

        context "checking test data" do
          it { expect(Menu::Tag.count).to eq 1 }
          it { expect(subject).to be_a(Hash) }
          it { expect(Menu::Tag.find(subject[:id])).to be_a(Menu::Tag) }
          it { expect(tag.image).not_to be_nil }
        end

        it_behaves_like ADMIN_MENU_TAG_ITEM, has_name: false, has_description: false, has_image: true
      end

      context "when filtering by query" do
        before do
          5.times.each do |i|
            create(:menu_tag, name: "Tag ##{i + 1}!!!", description: "Description for ##{i + 1}!!!")
          end
        end

        context "checking test data" do
          it { expect(Menu::Tag.count).to eq 5 }
          it { expect(Menu::Tag.all).to all(be_valid) }
          it { expect(Menu::Tag.all.map(&:name)).to all(be_present) }
          it { expect(Menu::Tag.all.map(&:name)).to all(be_a String) }
          it { expect(Menu::Tag.all.map(&:description)).to all(be_present) }
          it { expect(Menu::Tag.all.map(&:description)).to all(be_a String) }
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

        context "when querying with {query: 'Tag #1'} should return just the first item" do
          subject do
            req(query: "Tag #1")
            parsed_response_body[:items]
          end

          it { expect(subject.count).to eq 1 }
          it { expect(subject.pluck(:id).uniq.count).to eq 1 }
          it { expect(subject.first[:name]).to eq "Tag #1!!!" }
        end

        context "when querying with {query: 'Description for #1'} should return just the first item" do
          subject do
            req(query: "Description for #1")
            parsed_response_body[:items]
          end

          it { expect(subject.count).to eq 1 }
          it { expect(subject.pluck(:id).uniq.count).to eq 1 }
          it { expect(subject.first[:name]).to eq "Tag #1!!!" }
          it { expect(subject.first[:description]).to eq "Description for #1!!!" }
        end

        context "when querying with {query: 'Description for #5'} should return just the first item" do
          subject do
            req(query: "Description for #5")
            parsed_response_body[:items]
          end

          it { expect(subject.count).to eq 1 }
          it { expect(subject.pluck(:id).uniq.count).to eq 1 }
          it { expect(subject.first[:name]).to eq "Tag #5!!!" }
          it { expect(subject.first[:description]).to eq "Description for #5!!!" }
        end
      end

      context "should return only non-deleted items" do
        subject do
          req
          parsed_response_body[:items]
        end

        before do
          create(:menu_tag, status: :active)
          create(:menu_tag, status: :deleted)
        end

        it { expect(Menu::Tag.count).to eq 2 }
        it { expect(Menu::Tag.visible.count).to eq 1 }
        it { expect(subject).to all(include(status: "active")) }
        it { expect(subject.size).to eq 1 }
      end

      context "when providing {avoid_associated_dish_id: <DishId>}" do
        let(:dish) { create(:menu_dish) }

        before do
          create_list(:menu_tag, 3)
          dish.tags = [Menu::Tag.all.sample]
          req(avoid_associated_dish_id: dish.id)
          create(:menu_dish).tags = Menu::Tag.all
        end

        it { expect(response).to have_http_status(:ok) }
        it { expect(parsed_response_body).not_to include(message: String) }
        it { expect(parsed_response_body[:items].count).to eq 2 }
      end

      context "when providing {associated_dish_id: <DishId>}" do
        let(:dish) { create(:menu_dish) }

        before do
          create_list(:menu_tag, 3)
          dish.tags = [Menu::Tag.all.sample]
          req(associated_dish_id: dish.id)
          create(:menu_dish).tags = Menu::Tag.all
        end

        it { expect(response).to have_http_status(:ok) }
        it { expect(parsed_response_body).not_to include(message: String) }
        it { expect(parsed_response_body[:items].count).to eq 1 }
        it { expect(parsed_response_body.dig(:items, 0, :id)).to eq dish.tags.first.id }
      end
    end
  end

  describe "#show" do
    def req(params = {})
      get :show, params:
    end

    let(:tag) { create(:menu_tag) }

    it { expect(instance).to respond_to(:show) }
    it { expect(described_class).to route(:get, "/v1/admin/menu/tags/2").to(action: :show, format: :json, id: 2) }

    context "if user is unauthorized" do
      before { req(id: tag.id) }

      it_behaves_like UNAUTHORIZED
    end

    context "(authenticated)" do
      before { authenticate_request }

      context "basic" do
        subject do
          req(id: tag.id)
          parsed_response_body[:item]
        end

        let(:tag) { create(:menu_tag, name: nil, description: nil) }

        it { expect(tag).to be_valid }

        it { expect(response).to be_successful }
        it { expect(response).to have_http_status(:ok) }

        it_behaves_like ADMIN_MENU_TAG_ITEM, has_name: false, has_description: false, has_image: false
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

      context "when tag has image" do
        subject do
          req(id: tag.id)
          parsed_response_body[:item]
        end

        let(:tag) { create(:menu_tag, name: nil, description: nil) }

        before { tag.image = create(:image, :with_attached_image) }

        it { expect(tag).to be_valid }
        it { expect(response).to have_http_status(:ok) }

        it_behaves_like ADMIN_MENU_TAG_ITEM, has_name: false, has_description: false, has_image: true
      end

      context "when tag has name" do
        subject { parsed_response_body[:item] }

        let(:tag) { create(:menu_tag, description: nil, name: nil) }

        before do
          tag.update!(name: "test")
          tag.reload
          req(id: tag.id)
        end

        it { expect(tag.name).to eq "test" }

        it { expect(tag).to be_valid }
        it { expect(response).to have_http_status(:ok) }

        it_behaves_like ADMIN_MENU_TAG_ITEM, has_name: true, has_description: false, has_image: false
        it { is_expected.to include(name: "test") }
      end

      context "when tag has description (in another language)" do
        subject { parsed_response_body[:item] }

        before do
          @initial_lang = I18n.locale
          I18n.locale = (I18n.available_locales - [I18n.default_locale]).sample
          tag.update!(description: "test-#{I18n.locale}")
          tag.reload
          req(id: tag.id, lang: I18n.locale)
        end

        after do
          I18n.locale = @initial_lang
          @initial_lang = nil
        end

        it { expect(tag.description).to eq "test-#{I18n.locale}" }

        it { expect(tag).to be_valid }
        it { expect(response).to have_http_status(:ok) }

        it_behaves_like ADMIN_MENU_TAG_ITEM, has_name: true, has_description: true
        it { is_expected.to include(description: "test-#{I18n.locale}") }
      end
    end
  end

  describe "#create" do
    it { expect(instance).to respond_to(:create) }
    it { expect(described_class).to route(:post, "/v1/admin/menu/tags").to(action: :create, format: :json) }

    def req(params = {})
      post :create, params:
    end

    context "when user is not authenticated" do
      before { req }

      it_behaves_like UNAUTHORIZED
    end

    context "(authenticated)" do
      before { authenticate_request }

      it { expect { req }.to change(Menu::Tag, :count).by(1) }

      context "basic" do
        subject do
          req
          parsed_response_body[:item]
        end

        it { expect(response).to have_http_status(:ok) }
        it { expect(response).to be_successful }

        it_behaves_like ADMIN_MENU_TAG_ITEM, has_name: false, has_description: false, has_image: false
      end

      context "passing {} (empty hash)" do
        subject do
          req
          response
        end

        it "request should create a tag" do
          expect { subject }.to change(Menu::Tag, :count).by(1)
          expect(Menu::Tag.count).to eq 1
        end

        it { is_expected.to have_http_status(:ok) }
        it { is_expected.to be_successful }

        context "response[:item]" do
          subject do
            req
            parsed_response_body[:item]
          end

          it_behaves_like ADMIN_MENU_TAG_ITEM, has_name: false, has_description: false, has_image: false
        end
      end

      context "should include translations" do
        subject { parsed_response_body[:item] }

        before { req(name: "test") }

        it do
          expect(subject).to include(translations: Hash)
          expect(subject[:translations]).to include(name: Hash)
          expect(subject.dig(:translations, :name)).to include(en: "test")
        end
      end

      context "if providing name as JSON-encoded string in two languages" do
        subject do
          req(name: { it: "italian", en: "english" }.to_json)
          response
        end

        it "request should create a allergen" do
          expect { subject }.to change(Menu::Tag, :count).by(1)
          expect(Menu::Tag.count).to eq 1
        end

        it { is_expected.to have_http_status(:ok) }

        context "response[:item]" do
          subject do
            req(name: { it: "italian", en: "english" }.to_json)
            parsed_response_body[:item]
          end

          it { is_expected.to include(name: "english") }
        end
      end

      context "passing {name: <String>}" do
        subject do
          req(name: "test")
          response
        end

        it "request should create a tag" do
          expect { subject }.to change(Menu::Tag, :count).by(1)
          expect(Menu::Tag.count).to eq 1
        end

        it { is_expected.to have_http_status(:ok) }
        it { is_expected.to be_successful }

        context "response[:item]" do
          subject do
            req(name: "test")
            parsed_response_body[:item]
          end

          it_behaves_like ADMIN_MENU_TAG_ITEM, has_name: true, has_description: false, has_image: false

          it { is_expected.to include(name: "test") }
        end
      end

      context "passing {image: File}" do
        subject do
          req(image: fixture_file_upload("cat.jpeg", "image/jpeg"))
          response
        end

        it { expect { subject }.to change { Image.count }.by(1) }

        it do
          subject
          expect(parsed_response_body[:item]).to include(image: Hash)
        end

        it do
          subject
          expect(response).to have_http_status(:ok)
        end
      end

      context "passing {description: <String>}" do
        subject do
          req(description: "test")
          response
        end

        it "request should create a tag" do
          expect { subject }.to change(Menu::Tag, :count).by(1)
          expect(Menu::Tag.count).to eq 1
        end

        it { is_expected.to have_http_status(:ok) }
        it { is_expected.to be_successful }

        context "response[:item]" do
          subject do
            req(description: "test")
            parsed_response_body[:item]
          end

          it_behaves_like ADMIN_MENU_TAG_ITEM, has_name: false, has_description: true, has_image: false

          it { is_expected.to include(description: "test") }
        end
      end

      context "passing {name: {it: <String>, en: <String>}}" do
        subject do
          Menu::Tag.destroy_all
          req(name: { it: "test-it", en: "test-en" })
          response
        end

        it "request should create a tag" do
          expect { subject }.to change(Menu::Tag, :count).by(1)
          expect(Menu::Tag.count).to eq 1
        end

        it { is_expected.to have_http_status(:ok) }
        it { is_expected.to be_successful }

        context "response[:item]" do
          subject do
            req(name: { it: "test-it", en: "test-en" })
            parsed_response_body[:item]
          end

          it_behaves_like ADMIN_MENU_TAG_ITEM, has_name: true, has_description: false, has_image: false

          it { is_expected.to include(name: "test-#{I18n.locale}") }

          context "after call" do
            before { subject }

            it { expect(Menu::Tag.count).to eq 1 }

            %i[it en].each do |locale|
              it { Mobility.with_locale(locale) { expect(Menu::Tag.first.name).to eq "test-#{locale}" } }
              it { Mobility.with_locale(locale) { expect(Menu::Tag.first.description).to eq nil } }
            end
          end
        end
      end

      context "passing {description: {it: <String>, en: <String>}}" do
        subject do
          Menu::Tag.destroy_all
          req(description: { it: "test-it", en: "test-en" })
          response
        end

        it "request should create a tag" do
          expect { subject }.to change(Menu::Tag, :count).by(1)
          expect(Menu::Tag.count).to eq 1
        end

        it { is_expected.to have_http_status(:ok) }
        it { is_expected.to be_successful }

        context "response[:item]" do
          subject do
            req(description: { it: "test-it", en: "test-en" })
            parsed_response_body[:item]
          end

          it_behaves_like ADMIN_MENU_TAG_ITEM, has_name: false, has_description: true, has_image: false

          it { is_expected.to include(description: "test-#{I18n.locale}") }

          context "after call" do
            before { subject }

            it { expect(Menu::Tag.count).to eq 1 }

            %i[it en].each do |locale|
              it { Mobility.with_locale(locale) { expect(Menu::Tag.first.description).to eq "test-#{locale}" } }
              it { Mobility.with_locale(locale) { expect(Menu::Tag.first.name).to eq nil } }
            end
          end
        end
      end

      context "passing {name: {it: <String>, invalid_locale: <String>}}" do
        subject do
          Menu::Tag.destroy_all
          req(name: { it: "test-it", invalid_locale: "test-invalid" })
          response
        end

        it do
          expect { subject }.not_to change(Menu::Tag, :count)
          expect(Menu::Tag.count).to eq 0
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

        context "after call" do
          before { subject }

          it { expect(Menu::Tag.count).to eq 0 }
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
    it { expect(described_class).to route(:patch, "/v1/admin/menu/tags/22").to(action: :update, format: :json, id: 22) }

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
          req(id: tag.id, name: "test-name", description: nil)
          parsed_response_body[:item]
        end

        let!(:tag) { create(:menu_tag) }

        it { expect(response).to have_http_status(:ok) }
        it { expect(response).to be_successful }

        it_behaves_like ADMIN_MENU_TAG_ITEM, has_name: true, has_description: false, has_image: false
      end

      context "if cannot find tag by id" do
        subject { response }

        before { req(id: "invalid") }

        it_behaves_like NOT_FOUND
      end

      context 'with {name: "Hello"}' do
        subject do
          req(id: tag.id, name: "Hello")
          parsed_response_body[:item]
        end

        let!(:tag) { create(:menu_tag, name: nil, description: nil) }

        it { expect(response).to have_http_status(:ok) }
        it { expect(response).to be_successful }

        it_behaves_like ADMIN_MENU_TAG_ITEM, has_name: true, has_description: false
        it { is_expected.to include(name: "Hello") }
      end

      context 'can remove image with {image: "null"}' do
        subject do
          req(id: tag.id, image: "null")
          parsed_response_body[:item]
        end

        let!(:tag) { create(:menu_tag, :with_image_with_attachment) }

        it { expect { subject }.to change { tag.reload.image }.to(nil) }
        it { expect { subject }.not_to(change { Image.count }) }

        it "returns 200" do
          subject
          expect(parsed_response_body).not_to include(message: String)
          expect(response).to have_http_status(:ok)
        end
      end

      context "can remove image with {image: nil}" do
        subject do
          req(id: tag.id, image: nil)
          parsed_response_body[:item]
        end

        let!(:tag) { create(:menu_tag, :with_image_with_attachment) }

        it { expect { subject }.to change { tag.reload.image }.to(nil) }
        it { expect { subject }.not_to(change { Image.count }) }

        it "returns 200" do
          subject
          expect(parsed_response_body).not_to include(message: String)
          expect(response).to have_http_status(:ok)
        end
      end

      context "can update image with {image: File}" do
        subject do
          req(id: tag.id, image: fixture_file_upload("cat.jpeg", "image/jpeg"))
          response
        end

        let!(:tag) { create(:menu_tag, :with_image_with_attachment) }

        it { expect { subject }.to change { Image.count }.by(1) }
        it { expect { subject }.to change { tag.reload.image }.to(an_instance_of(Image)) }
      end

      context 'with {description: "Hello"}' do
        subject do
          req(id: tag.id, description: "Hello")
          parsed_response_body[:item]
        end

        let!(:tag) { create(:menu_tag, name: nil, description: nil) }

        it { expect(response).to have_http_status(:ok) }
        it { expect(response).to be_successful }

        it_behaves_like ADMIN_MENU_TAG_ITEM, has_name: false, has_description: true
        it { is_expected.to include(description: "Hello") }
      end

      context 'with {name: {it: "Hello", en: "Hello"}}' do
        subject do
          req(id: tag.id, name: { it: "Ciao", en: "Hello" })
          parsed_response_body[:item]
        end

        let!(:tag) { create(:menu_tag, description: nil) }

        it { expect(response).to have_http_status(:ok) }
        it { expect(response).to be_successful }

        it_behaves_like ADMIN_MENU_TAG_ITEM, has_name: true, has_description: false, has_image: false
        it { is_expected.to include(name: "Hello") }

        context "after request" do
          subject { tag.reload }

          before { req(id: tag.id, name: { it: "Ciao", en: "Hello" }) }

          it { Mobility.with_locale(:it) { expect(subject.name).to eq "Ciao" } }
          it { Mobility.with_locale(:it) { expect(subject.description).to eq nil } }
          it { Mobility.with_locale(:en) { expect(subject.name).to eq "Hello" } }
          it { Mobility.with_locale(:en) { expect(subject.description).to eq nil } }
          it { expect(subject.name).to eq "Hello" }
          it { expect(subject.name_it).to eq "Ciao" }
          it { expect(subject.name_en).to eq "Hello" }
        end
      end

      context 'with {description: {it: "Hello", en: "Hello"}}' do
        subject do
          req(id: tag.id, description: { it: "Ciao", en: "Hello" })
          parsed_response_body[:item]
        end

        let!(:tag) { create(:menu_tag, name: nil, description: nil) }

        it { expect(response).to have_http_status(:ok) }
        it { expect(response).to be_successful }

        it_behaves_like ADMIN_MENU_TAG_ITEM, has_name: false, has_description: true, has_image: false

        it { is_expected.to include(description: "Hello") }

        context "after request" do
          subject { tag.reload }

          before { req(id: tag.id, description: { it: "Ciao", en: "Hello" }) }

          it { expect(subject.description).to eq "Hello" }
          it { expect(subject.description_it).to eq "Ciao" }
          it { expect(subject.description_en).to eq "Hello" }
        end
      end

      context "passing {name: {it: <String>, invalid_locale: <String>}}" do
        subject do
          req params
          response
        end

        let!(:tag) { create(:menu_tag) }
        let(:params) { { id: tag.id, name: { it: "test-it", invalid_locale: "test-invalid" } } }

        it do
          expect { subject }.not_to change(Menu::Tag, :count)
          expect(Menu::Tag.count).to eq 1
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

      context "passing {name: nil} to a tag with name" do
        subject do
          req(id: tag.id, name: nil)
          parsed_response_body[:item]
        end

        let!(:tag) do
          mc = create(:menu_tag)
          Mobility.with_locale(:it) { mc.update!(name: "test-it") }
          Mobility.with_locale(:en) { mc.update!(name: "test-en") }
          mc.reload
          mc
        end

        context "checking mock data" do
          it { expect(tag.name).to eq "test-en" }
          it { expect(tag.name_en).to eq "test-en" }
          it { expect(tag.name_it).to eq "test-it" }
        end

        it { expect(response).to have_http_status(:ok) }
        it { expect(response).to be_successful }
        it { expect(subject[:name]).to eq nil }

        context "after request" do
          subject { tag.reload }

          before { req(id: tag.id, name: nil) }

          it { expect(subject.name).to eq nil }
          it { expect(subject.name_en).to eq nil }
          it { expect(subject.name_it).to eq "test-it" }
        end
      end

      context "passing {name: { it: nil, en: nil } } to a tag with name in both langauges" do
        subject do
          req(id: tag.id, name: { it: nil, en: nil })
          parsed_response_body[:item]
        end

        let!(:tag) do
          mc = create(:menu_tag)
          Mobility.with_locale(:it) { mc.update!(name: "test-it") }
          Mobility.with_locale(:en) { mc.update!(name: "test-en") }
          mc.reload
          mc
        end

        context "checking mock data" do
          it { expect(tag.name).to eq "test-en" }
          it { expect(tag.name_en).to eq "test-en" }
          it { expect(tag.name_it).to eq "test-it" }
        end

        it { expect(response).to have_http_status(:ok) }
        it { expect(response).to be_successful }
        it { expect(subject[:name]).to eq nil }

        context "after request" do
          subject { tag.reload }

          before { req(id: tag.id, name: { it: nil, en: nil }) }

          it { expect(subject.name).to eq nil }
          it { expect(subject.name_en).to eq nil }
          it { expect(subject.name_it).to eq nil }
        end
      end

      context "when setting name to nil with {name: nil}" do
        subject do
          req(id: tag.id, name: nil)
          parsed_response_body[:item]
        end

        let!(:tag) { create(:menu_tag, name: "Tag name") }

        it { is_expected.to include(name: nil) }
      end

      context "when setting name to nil with {name: {<locale>: nil}}" do
        subject do
          req(id: tag.id, name: { en: nil })
          parsed_response_body[:item]
        end

        let!(:tag) { create(:menu_tag, name: "Tag name") }

        it { is_expected.to include(name: nil) }
      end
    end
  end

  describe "#destroy" do
    it { expect(instance).to respond_to(:destroy) }

    it {
      expect(described_class).to route(:DELETE, "/v1/admin/menu/tags/22").to(action: :destroy, format: :json, id: 22)
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
          req(id: tag.id)
          response
        end

        let!(:tag) { create(:menu_tag) }

        it { expect { subject }.to change { Menu::Tag.visible.count }.by(-1) }
        it { is_expected.to have_http_status(:no_content) }
        it { is_expected.to be_successful }
      end

      context "when cannot delete record" do
        subject do
          req(id: tag.id)
          response
        end

        let!(:tag) { create(:menu_tag) }

        before { allow_any_instance_of(Menu::Tag).to receive(:deleted!).and_return(false) }

        it { expect { subject }.not_to(change { Menu::Tag.visible.count }) }
        it { is_expected.to have_http_status(:unprocessable_entity) }
        it { is_expected.not_to be_successful }
      end

      context "when record deletion raises error" do
        subject do
          req(id: tag.id)
          response
        end

        let!(:tag) { create(:menu_tag) }

        before { allow_any_instance_of(Menu::Tag).to receive(:deleted!).and_raise(ActiveRecord::RecordInvalid) }

        it { expect { subject }.not_to(change { Menu::Tag.visible.count }) }
        it { is_expected.to have_http_status(:unprocessable_entity) }
        it { is_expected.not_to be_successful }
      end

      context "if cannot find tag by id" do
        subject { response }

        before { req(id: 22) }

        it_behaves_like NOT_FOUND
      end
    end
  end

  describe "#copy" do
    subject { req(tag.id) }

    let!(:tag) { create(:menu_tag) }

    it { expect(instance).to respond_to(:copy) }

    it {
      expect(subject).to route(:post, "/v1/admin/menu/tags/22/copy").to(format: :json, action: :copy, controller: "v1/admin/menu/tags",
                                                                        id: 22)
    }

    def req(id, params = {})
      post :copy, params: params.merge(id:)
    end

    context "when user is not authenticated" do
      before { req(tag.id, name: Faker::Lorem.sentence) }

      it_behaves_like UNAUTHORIZED
    end

    context "[user is authenticated]" do
      before do
        authenticate_request(user: create(:user))
      end

      it { is_expected.to be_successful }
      it { is_expected.to have_http_status(:ok) }

      it { expect { subject }.to change { Menu::Tag.count }.by(1) }

      context "when item does not exist" do
        subject { response }

        before { req(999_999_999) }

        it_behaves_like NOT_FOUND
      end

      context "if tag has image" do
        let!(:image) { create(:image, :with_attached_image) }

        before { tag.image = image }

        it { expect(tag.image&.id).to eq(image.id) }
        it { expect(tag.image&.id).to be_present }

        context 'and providing {copy_image: "full"}' do
          subject { req(tag.id, { copy_image: "full" }) }

          it { is_expected.to be_successful }
          it { is_expected.to have_http_status(:ok) }

          it { expect { subject }.to change { Image.count }.by(1) }
          it { expect { subject }.to change { ImageToRecord.count }.by(1) }

          context "[after req]" do
            before { subject }

            let(:result) { Menu::Tag.find(parsed_response_body.dig(:item, :id)) }

            it { expect(parsed_response_body).to include(item: Hash) }
            it { expect(result.image).to be_present }
            it { expect(result.image&.id).not_to eq(image.id) }
          end
        end

        context 'and providing {copy_image: "link"}' do
          subject { req(tag.id, { copy_image: "link" }) }

          it { expect { subject }.not_to(change { Image.count }) }
          it { expect { subject }.to change { ImageToRecord.count }.by(1) }

          context "[after req]" do
            before { subject }

            let(:result) { Menu::Tag.find(parsed_response_body.dig(:item, :id)) }

            it { expect(result.image).to be_present }
            it { expect(result.image.id).to eq image.id }
            it { expect(result.image.id).to eq tag.image.id }
          end
        end

        context 'and providing {copy_image: "none"}' do
          subject { req(tag.id, { copy_image: "none" }) }

          it { expect { subject }.not_to(change { Image.count }) }
          it { expect { subject }.not_to(change { ImageToRecord.count }) }

          context "[after req]" do
            before { subject }

            let(:result) { Menu::Tag.find(parsed_response_body.dig(:item, :id)) }

            it { expect(result.image).to be_nil }
            it { expect(tag.image).to be_present }
          end
        end
      end
    end
  end
end
