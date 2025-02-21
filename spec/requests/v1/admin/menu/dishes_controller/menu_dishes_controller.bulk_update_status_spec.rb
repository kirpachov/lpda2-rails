# frozen_string_literal: true

require "rails_helper"

RSpec.shared_examples "PATCH /v1/admin/menu/dishes/bulk_status/:status FAILURE" do
  it { expect { req }.not_to(change { Menu::DishesInCategory.all.as_json }) }
  it { expect { req }.not_to(change { Menu::Dish.all.as_json }) }
  it { expect { req }.not_to(change { Menu::Category.all.as_json }) }

  it do
    req
    expect(response).not_to be_successful
  end

  it do
    req
    expect(json).to include(message: String)
  end
end

RSpec.shared_examples "PATCH /v1/admin/menu/dishes/bulk_status/:status SUCCESS" do
  it { expect { req }.not_to(change { Menu::DishesInCategory.all.as_json }) }
  # it { expect { req }.not_to(change { Menu::Dish.all.as_json }) }
  it { expect { req }.not_to(change { Menu::Category.all.as_json }) }

  it do
    req
    expect(response).to have_http_status(:ok)
  end

  it do
    req
    expect(json).not_to include(message: String)
  end

  it do
    req
    expect(json).to include(ok: true)
  end
end

RSpec.describe "PATCH /v1/admin/menu/dishes/bulk_status/:status" do
  include_context REQUEST_AUTHENTICATION_CONTEXT

  let(:default_headers) { auth_headers }
  let(:dishes) do
    [
      create(:menu_dish, status: :active),
      create(:menu_dish, status: :inactive),
      create(:menu_dish, status: :active)
    ]
  end

  let(:status) { "inactive" }

  let(:dish_ids) { dishes.map(&:id) }
  let!(:default_params) { { status:, dish_ids: } }

  def req(params: default_params, headers: default_headers)
    patch "/v1/admin/menu/dishes/bulk_status/#{default_params[:status]}", headers:, params:
  end

  context "when not authenticated" do
    let(:default_headers) { {} }

    before { req }

    it { expect(response).to have_http_status(:unauthorized) }

    it { expect(json).to include(message: String) }
  end

  context "when can bulk update dishes status" do
    include_context "PATCH /v1/admin/menu/dishes/bulk_status/:status SUCCESS"

    it { expect { req }.to(change { Menu::Dish.all.map(&:status).uniq }.to(["inactive"])) }
  end

  %w[active inactive].each do |new_status|
    context "when can bulk update dishes status to #{new_status.inspect}" do
      let(:status) { new_status }

      include_context "PATCH /v1/admin/menu/dishes/bulk_status/:status SUCCESS"

      it { expect { req }.to(change { Menu::Dish.all.map(&:status).uniq }.to([new_status])) }
    end
  end

  context "when status is missing" do
    let!(:default_params) { super().except(:status) }

    include_context "PATCH /v1/admin/menu/dishes/bulk_status/:status FAILURE"
  end

  context "when status is empty" do
    let!(:default_params) { super().merge(status: "") }

    include_context "PATCH /v1/admin/menu/dishes/bulk_status/:status FAILURE"
  end

  context "when status is invalid" do
    let!(:default_params) { super().merge(status: "something-invalid") }

    include_context "PATCH /v1/admin/menu/dishes/bulk_status/:status FAILURE"
  end

  context "when dish_ids is missing" do
    let!(:default_params) { super().except(:dish_ids) }

    include_context "PATCH /v1/admin/menu/dishes/bulk_status/:status FAILURE"
  end

  context "when dish_ids is empty" do
    let!(:default_params) { super().merge(dish_ids: []) }

    include_context "PATCH /v1/admin/menu/dishes/bulk_status/:status FAILURE"
  end

  context "when one of the dish_ids does not exist" do
    let!(:default_params) { super().merge(dish_ids: [*dish_ids, -1]) }

    include_context "PATCH /v1/admin/menu/dishes/bulk_status/:status FAILURE"
  end

  context "when instead of dish_ids, is passed a single dish_id" do
    let!(:default_params) { super().merge(dish_ids: dishes.first.id) }

    include_context "PATCH /v1/admin/menu/dishes/bulk_status/:status SUCCESS"
  end

  [
    { default: :dish_ids, variants: %i[dish_ids dish_id dish_ids dishes dish] }
  ].each do |params_options|
    params_options[:variants].each do |variant|
      context "when #{params_options[:default]} is called #{variant}" do
        let!(:default_params) { super().merge(params_options[:default] => nil, variant => dishes.map(&:id)) }

        include_context "PATCH /v1/admin/menu/dishes/bulk_status/:status SUCCESS"
      end
    end
  end
end
