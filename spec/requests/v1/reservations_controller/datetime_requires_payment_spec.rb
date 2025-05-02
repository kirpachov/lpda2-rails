# frozen_string_literal: true

require "rails_helper"

RSpec.shared_examples "SUCCESSFUL GET /v1/reservations/datetime_requires_payment" do |table_types: nil|
  it { expect(response).to have_http_status(:ok) }
  it { expect(json).not_to include(:message) }
  it { expect(json).to include(preorder_reservation_group: Hash) }
  it { expect(json[:preorder_reservation_group]).to include(:id) }
  it { expect(json[:preorder_reservation_group]).to include(payment_value: Float) }
  it { expect(json[:preorder_reservation_group]).to include(table_types: Array) }

  if table_types
    it { expect(json[:preorder_reservation_group][:table_types].length).to be_positive }
    it { expect(json[:preorder_reservation_group][:table_types]).to all(include(id: Integer)) }
    it { expect(json[:preorder_reservation_group][:table_types]).to all(include(name: String)) }
    it { expect(json[:preorder_reservation_group][:table_types]).to all(include(description: String)) }
    it { expect(json[:preorder_reservation_group][:table_types]).to all(include(translations: Hash)) }
    it { expect(json[:preorder_reservation_group][:table_types]).to all(include(images: Array)) }
    it { expect(json[:preorder_reservation_group][:table_types].pluck(:images)).to all(be_present) }
  elsif table_types == false
    it { expect(json[:preorder_reservation_group][:table_types].length).to eq(0) }
  end
end

RSpec.shared_examples "PAYMENT NOT REQUIRED GET /v1/reservations/datetime_requires_payment" do
  it { expect(response).to have_http_status(:ok) }
  it { expect(json).not_to include(:message) }
end

RSpec.context "GET /v1/reservations/datetime_requires_payment", type: :request do
  def create_table_type
    create(:table_type, :with_images).tap do |tt|
      I18n.available_locales.each do |loc|
        Mobility.with_locale(loc) do
          tt.update!(name: "[#{loc}] Table type", description: "[#{loc}] Table type description")
        end
      end
    end
  end

  let!(:group) do
    create(:preorder_reservation_group).tap do |g|
      I18n.available_locales.each do |loc|
        Mobility.with_locale(loc) do
          g.update!(message: "[#{loc}] Please, pay in advance")
        end
      end
    end
  end
  let(:date) { "2025-1-1" }
  let(:time) { "12:00" }
  let(:people) { 2 }
  let(:default_params) { { date:, time:, people: } }
  let(:default_headers) { {} }

  let!(:turn) do
    create(:reservation_turn, starts_at: "12:00", ends_at: "15:00", weekday: DateTime.parse("2025-1-1").wday)
  end

  let(:table_type) do
    create_table_type
  end

  before do
    group.turns << turn
  end

  def req(params: default_params, headers: default_headers)
    get "/v1/reservations/datetime_requires_payment", headers:, params:
  end

  context "basic request" do
    before { req }

    include_context "SUCCESSFUL GET /v1/reservations/datetime_requires_payment"
  end

  context "when preorder reservation group has one type" do
    before do
      group.add_table_type(table_type:, price: table_type.default_price,
                           people_per_turn: table_type.default_people_per_turn)
      req
    end

    include_context "SUCCESSFUL GET /v1/reservations/datetime_requires_payment", table_types: true
  end

  context "when preorder reservation group has many table types" do
    before do
      group.add_table_type(table_type:, price: table_type.default_price,
                           people_per_turn: table_type.default_people_per_turn)

      tt2 = create_table_type

      group.add_table_type(table_type: tt2, price: tt2.default_price, people_per_turn: tt2.default_people_per_turn)
      req
    end

    include_context "SUCCESSFUL GET /v1/reservations/datetime_requires_payment", table_types: true
  end

  context "when there are no turns" do
    before do
      group.turns.destroy_all
      ReservationTurn.destroy_all
      req
    end

    include_context "PAYMENT NOT REQUIRED GET /v1/reservations/datetime_requires_payment"
  end

  context "when are turns but no preorder reservation group" do
    before do
      group.destroy
      req
    end

    include_context "PAYMENT NOT REQUIRED GET /v1/reservations/datetime_requires_payment"
  end

  context "when are turns but no table type" do
    before do
      group.table_types.destroy_all
      req
    end

    include_context "SUCCESSFUL GET /v1/reservations/datetime_requires_payment", table_types: false
  end
end
