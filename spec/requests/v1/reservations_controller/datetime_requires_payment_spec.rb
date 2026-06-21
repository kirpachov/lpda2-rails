# frozen_string_literal: true

require "rails_helper"

RSpec.shared_examples "SUCCESSFUL GET /v1/reservations/datetime_requires_payment" do |table_types: nil|
  it { expect(response).to have_http_status(:ok) }
  it { expect(json).not_to include(:message) }
  it { expect(json).to include(preorder_reservation_group: Hash) }
  it { expect(json[:preorder_reservation_group]).to include(:id) }
  it { expect(json[:preorder_reservation_group]).to include(payment_value: Float) }
  it { expect(json[:preorder_reservation_group]).to include(message: String) }
  it { expect(json[:preorder_reservation_group]).to include(table_type_to_preorder_reservation_groups: Array) }

  if table_types
    it { expect(json[:preorder_reservation_group][:table_type_to_preorder_reservation_groups].length).to be_positive }

    it {
      expect(json[:preorder_reservation_group][:table_type_to_preorder_reservation_groups].pluck(:table_type)).to all(include(id: Integer))
    }

    it {
      expect(json[:preorder_reservation_group][:table_type_to_preorder_reservation_groups].pluck(:table_type)).to all(include(name: String))
    }

    it {
      expect(json[:preorder_reservation_group][:table_type_to_preorder_reservation_groups].pluck(:table_type)).to all(include(description: String))
    }

    it {
      expect(json[:preorder_reservation_group][:table_type_to_preorder_reservation_groups].pluck(:table_type)).to all(include(translations: Hash))
    }

    it {
      expect(json[:preorder_reservation_group][:table_type_to_preorder_reservation_groups].pluck(:table_type)).to all(include(images: Array))
    }

    it {
      expect(json[:preorder_reservation_group][:table_type_to_preorder_reservation_groups].pluck(:table_type).pluck(:images)).to all(be_present)
    }

    it {
      expect(json[:preorder_reservation_group][:table_type_to_preorder_reservation_groups].pluck(:table_type).pluck(:images).flatten).to all(include(
                                                                                                                                               filename: String, url: String
                                                                                                                                             ))
    }
  elsif table_types == false
    it { expect(json[:preorder_reservation_group][:table_type_to_preorder_reservation_groups].length).to eq(0) }
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

  context "when preorder group has two table types but only one has enough seats for the requested people" do
    let(:tt1) do
      table_type
    end
    let(:tt2) do
      create_table_type
    end

    before do
    group.add_table_type(
        table_type: tt1 , price: 20,
                           people_per_turn: 5
                           )

      group.add_table_type(
        table_type: tt2 , price: 30,
                           people_per_turn: 3
                           )

      group
    end

    context "when requested people is 2" do
      let(:people) { 2 }

      before { req }

      include_context "SUCCESSFUL GET /v1/reservations/datetime_requires_payment", table_types: true

      it "returns only the table type that has enough seats" do
        expect(json).to include(preorder_reservation_group: Hash)
        expect(json[:preorder_reservation_group]).to include(table_type_to_preorder_reservation_groups: Array)
        expect(json.dig(:preorder_reservation_group, :table_type_to_preorder_reservation_groups)).not_to be_empty
        expect(json.dig(:preorder_reservation_group, :table_type_to_preorder_reservation_groups).pluck(:table_type_id)).to match_array([tt1.id, tt2.id])
      end
    end

    context "when requested people is 3" do
      let(:people) { 3 }

      before { req }

      include_context "SUCCESSFUL GET /v1/reservations/datetime_requires_payment", table_types: true

      it "returns only the table type that has enough seats" do
        expect(json).to include(preorder_reservation_group: Hash)
        expect(json[:preorder_reservation_group]).to include(table_type_to_preorder_reservation_groups: Array)
        expect(json.dig(:preorder_reservation_group, :table_type_to_preorder_reservation_groups)).not_to be_empty
        expect(json.dig(:preorder_reservation_group, :table_type_to_preorder_reservation_groups).pluck(:table_type_id)).to match_array([tt1.id, tt2.id])
      end
    end

    context "when requested people is 4" do
      let(:people) { 4 }

      before do
        # Reservation.delete_all
        req
      end

      include_context "SUCCESSFUL GET /v1/reservations/datetime_requires_payment", table_types: true

      it "returns only the table type that has enough seats" do
        expect(json).to include(preorder_reservation_group: Hash)
        expect(json[:preorder_reservation_group]).to include(table_type_to_preorder_reservation_groups: Array)
        expect(json.dig(:preorder_reservation_group, :table_type_to_preorder_reservation_groups)).not_to be_empty
        expect(json.dig(:preorder_reservation_group, :table_type_to_preorder_reservation_groups).pluck(:table_type_id)).to match_array([tt1.id])
      end
    end

    context "when requested people is 5" do
      let(:people) { 5 }

      before do
        # Reservation.delete_all
        req
      end

      include_context "SUCCESSFUL GET /v1/reservations/datetime_requires_payment", table_types: true

      it "returns only the table type that has enough seats" do
        expect(json).to include(preorder_reservation_group: Hash)
        expect(json[:preorder_reservation_group]).to include(table_type_to_preorder_reservation_groups: Array)
        expect(json.dig(:preorder_reservation_group, :table_type_to_preorder_reservation_groups)).not_to be_empty
        expect(json.dig(:preorder_reservation_group, :table_type_to_preorder_reservation_groups).pluck(:table_type_id)).to match_array([tt1.id])
      end
    end

    context "when requested people is 2 but there is a confirmed reservation for two people for tt1" do
      let(:people) { 2 }

      before do
        create(:reservation, adults: 2, status: :arrived, table_type: tt1, datetime: DateTime.parse("#{date} #{time}")).tap do |r|
          create(:reservation_payment, reservation: r, value: 20, status: :paid)
        end

        req
      end

      include_context "SUCCESSFUL GET /v1/reservations/datetime_requires_payment", table_types: true

      it "returns only the table type that has enough seats" do
        expect(json).to include(preorder_reservation_group: Hash)
        expect(json[:preorder_reservation_group]).to include(table_type_to_preorder_reservation_groups: Array)
        expect(json.dig(:preorder_reservation_group, :table_type_to_preorder_reservation_groups)).not_to be_empty
        expect(json.dig(:preorder_reservation_group, :table_type_to_preorder_reservation_groups).pluck(:table_type_id)).to match_array([tt1.id, tt2.id])
      end
    end

    context "when requested people is 2 but there is a confirmed reservation for two people for tt2" do
      let(:people) { 2 }

      before do
        create(:reservation, adults: 2, status: :arrived, table_type: tt2, datetime: DateTime.parse("#{date} #{time}")).tap do |r|
          create(:reservation_payment, reservation: r, value: 20, status: :paid)
        end

        req
      end

      include_context "SUCCESSFUL GET /v1/reservations/datetime_requires_payment", table_types: true

      it "returns only the table type that has enough seats" do
        expect(json).to include(preorder_reservation_group: Hash)
        expect(json[:preorder_reservation_group]).to include(table_type_to_preorder_reservation_groups: Array)
        expect(json.dig(:preorder_reservation_group, :table_type_to_preorder_reservation_groups)).not_to be_empty
        expect(json.dig(:preorder_reservation_group, :table_type_to_preorder_reservation_groups).pluck(:table_type_id)).to match_array([tt1.id])
      end
    end

    %w[deleted cancelled].each do |reservation_status|
      [true, false].each do |has_payment|
        context "when requested people is 2 but there is a confirmed reservation for two people for tt2 but it has status #{reservation_status} and has_payment=#{has_payment}" do
          let(:people) { 2 }

          before do
            create(:reservation, adults: 2, status: reservation_status, table_type: tt2, datetime: DateTime.parse("#{date} #{time}")).tap do |r|
              create(:reservation_payment, reservation: r, value: 20, status: :paid) if has_payment
            end

            req
          end

          # include_context "SUCCESSFUL GET /v1/reservations/datetime_requires_payment", table_types: true

          it "returns only the table type that has enough seats" do
            expect(json).to include(preorder_reservation_group: Hash)
            expect(json[:preorder_reservation_group]).to include(table_type_to_preorder_reservation_groups: Array)
            expect(json.dig(:preorder_reservation_group, :table_type_to_preorder_reservation_groups)).not_to be_empty
            expect(json.dig(:preorder_reservation_group, :table_type_to_preorder_reservation_groups).pluck(:table_type_id)).to match_array([tt1.id, tt2.id])
          end
        end
      end
    end
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
