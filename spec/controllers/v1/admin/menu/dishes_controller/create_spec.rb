# frozen_string_literal: true

require "rails_helper"

RSpec.describe V1::Admin::Menu::DishesController do
  include_context CONTROLLER_UTILS_CONTEXT
  include_context CONTROLLER_AUTHENTICATION_CONTEXT
  include_context TESTS_OPTIMIZATIONS_CONTEXT

  let(:instance) { described_class.new }

  describe "#create" do
    it { expect(instance).to respond_to(:create) }

    it do
      expect(subject).to route(:post, "/v1/admin/menu/dishes").to(format: :json, action: :create,
                                                                  controller: "v1/admin/menu/dishes")
    end

    def req(params = {})
      post :create, params:
    end

    context "when user is not authenticated" do
      before { req(name: Faker::Lorem.sentence) }

      it_behaves_like UNAUTHORIZED
    end

    context "[user is authenticated]" do
      before do
        authenticate_request(user: create(:user))
      end

      it { expect(req).to be_successful }

      it { expect { req(description: "desc") }.to change(Menu::Dish, :count).by(1) }

      context "when category_id is provided but blank, should create dish without category (root dish)." do
        subject do
          req(category_id: "", description: "desc")
          parsed_response_body[:item]
        end

        it { is_expected.to include(name: nil) }
        it { is_expected.to include(description: "desc") }

        it {
          subject
          expect(response).to be_successful
        }

        it { expect { subject }.to change { Menu::Dish.count }.by(1) }
        it { expect { subject }.to change { Menu::DishesInCategory.count }.by(1) }
        it { expect { subject }.to change { Menu::DishesInCategory.where(menu_category_id: nil).count }.by(1) }
      end

      context "when category_id is present, should create dish as category child" do
        subject do
          req(category_id: category.id, description: "desc")
          parsed_response_body[:item]
        end

        let(:category) { create(:menu_category) }

        it { is_expected.to include(name: nil) }
        it { is_expected.to include(description: "desc") }
        it { expect(response).to be_successful }
        it { expect { subject }.to change { Menu::Dish.count }.by(1) }
        it { expect { subject }.to change { Menu::DishesInCategory.count }.by(1) }
        it { expect { subject }.to change { Menu::DishesInCategory.where(menu_category_id: category.id).count }.by(1) }
      end

      context "when creating new dish with {description: <string>}" do
        subject { parsed_response_body[:item] }

        before { req(description: "desc") }

        it { is_expected.to include(name: nil) }
        it { is_expected.to include(description: "desc") }
        it { expect(response).to be_successful }
      end

      it { expect { req(price: 15) }.to change(Menu::Dish, :count).by(1) }

      context "when creating new dish with {price: 15}" do
        subject { parsed_response_body[:item] }

        before { req(price: 15) }

        it { is_expected.to include(name: nil) }
        it { is_expected.to include(description: nil) }
        it { is_expected.to include(price: 15.0) }
        it { expect(response).to be_successful }
      end

      it { expect { req(price: 15.7) }.to change(Menu::Dish, :count).by(1) }

      context "when creating new dish with {price: 15.7}" do
        subject { parsed_response_body[:item] }

        before { req(price: 15.7) }

        it { is_expected.to include(name: nil) }
        it { is_expected.to include(description: nil) }
        it { is_expected.to include(price: 15.7) }
        it { expect(response).to be_successful }
      end

      it { expect { req(price: "15.7") }.to change(Menu::Dish, :count).by(1) }

      context 'when creating new dish with {price: "15.7"}' do
        subject { parsed_response_body[:item] }

        before { req(price: "15.7") }

        it { is_expected.to include(name: nil) }
        it { is_expected.to include(description: nil) }
        it { is_expected.to include(price: 15.7) }
        it { expect(response).to be_successful }
      end

      it { expect { req(name: "wassa") }.to change(Menu::Dish, :count).by(1) }

      context "when creating new dish with {name: <string>}" do
        subject { parsed_response_body[:item] }

        before { req(name: "wassa") }

        it { is_expected.to include(description: nil) }
        it { is_expected.to include(name: "wassa") }
        it { expect(response).to be_successful }
      end

      it { expect { req }.to change(Menu::Dish, :count).by(1) }

      context "when creating new dish with {}" do
        subject { parsed_response_body[:item] }

        before { req }

        it { is_expected.to include(name: nil) }
        it { is_expected.to include(description: nil) }
        it { expect(response).to be_successful }
      end

      it { expect { req(name: "wassa", description: "bratan") }.to change(Menu::Dish, :count).by(1) }

      context "when creating new dish with {name: <name>, description: <description>}" do
        subject { parsed_response_body[:item] }

        before { req(name: "wassa", description: "bratan") }

        it { is_expected.to include(name: "wassa") }
        it { is_expected.to include(description: "bratan") }
        it { expect(response).to be_successful }
      end

      context %(when creating new dish with {name: {it: "wassa-it", en: "wassa-en"}) do
        subject { parsed_response_body[:item] }

        before do
          req(name: { it: "wassa-it", en: "wassa-en" }, description: { it: "bratan-it", en: "bratan-en" })
        end

        it { expect(subject).to include(translations: Hash) }
        it { expect(subject[:translations]).to include(name: Hash) }
        it { expect(subject.dig(:translations, :name)).to include(en: "wassa-en") }
        it { expect(subject.dig(:translations, :name)).to include(it: "wassa-it") }
        it { expect(subject.dig(:translations, :description)).to include(it: "bratan-it") }
        it { expect(subject.dig(:translations, :description)).to include(en: "bratan-en") }
      end
    end
  end
end
