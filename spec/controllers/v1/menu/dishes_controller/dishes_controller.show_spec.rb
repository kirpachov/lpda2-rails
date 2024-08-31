# frozen_string_literal: true

require "rails_helper"

RSpec.describe V1::Menu::DishesController do
  include_context CONTROLLER_UTILS_CONTEXT
  include_context TESTS_OPTIMIZATIONS_CONTEXT

  let(:instance) { described_class.new }

  describe "#show" do
    def req(params = {})
      get :show, params:
    end

    let(:dish) { create(:menu_dish, :with_name, :with_description) }

    it { expect(instance).to respond_to(:show) }
    it { expect(described_class).to route(:get, "/v1/menu/dishes/2").to(action: :show, format: :json, id: 2) }

    context "basic" do
      subject do
        req(id: dish.id)
        parsed_response_body[:item]
      end

      let(:dish) { create(:menu_dish, name: nil, description: nil) }

      it { expect(dish).to be_valid }

      it { expect(response).to be_successful }
      it { expect(response).to have_http_status(:ok) }
      it { expect(subject).to include(id: Integer, name: nil, description: nil) }
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

    context "when dish has images" do
      subject do
        req(id: dish.id)
        parsed_response_body[:item]
      end

      let(:dish) { create(:menu_dish, name: nil, description: nil) }

      before { dish.images = [create(:image, :with_attached_image)] }

      it { expect(dish).to be_valid }
      it { expect(response).to have_http_status(:ok) }
      it { expect(subject).to include(images: Array) }
    end

    context "when dish has name" do
      subject { parsed_response_body[:item] }

      let(:dish) { create(:menu_dish, description: nil, name: nil) }

      before do
        dish.update!(name: "test")
        dish.reload
        req(id: dish.id)
      end

      it { expect(dish.name).to eq "test" }

      it { expect(dish).to be_valid }
      it { expect(response).to have_http_status(:ok) }

      it { is_expected.to include(name: "test") }
      it { is_expected.to include(translations: Hash) }
      it { expect(subject[:translations]).to include(name: Hash) }
      it { expect(subject.dig(:translations, :name)).to include(en: "test") }
    end

    context "when dish has description (in another language)" do
      subject { parsed_response_body[:item] }

      before do
        @initial_lang = I18n.locale
        I18n.locale = (I18n.available_locales - [I18n.default_locale]).sample
        dish.update!(description: "test-#{I18n.locale}")
        dish.reload
        req(id: dish.id, lang: I18n.locale)
      end

      after do
        I18n.locale = @initial_lang
        @initial_lang = nil
      end

      it { expect(dish.description).to eq "test-#{I18n.locale}" }

      it { expect(dish).to be_valid }
      it { expect(response).to have_http_status(:ok) }

      it { is_expected.to include(description: "test-#{I18n.locale}") }
    end
  end
end
