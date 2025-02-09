# frozen_string_literal: true

require "rails_helper"

RSpec.describe "PATCH /v1/admin/menu/dishes/update_prices" do
  include_context REQUEST_AUTHENTICATION_CONTEXT

  let(:default_headers) { auth_headers }
  let(:default_params) { { amount:, percent:, filters:, dry_run: } }

  let(:amount) { 1 }
  let(:percent) { nil }
  let(:filters) { {} }
  let(:dry_run) { [nil, false].sample }

  let!(:dishes) do
    [
      create(:menu_dish, price: 1),
      create(:menu_dish, price: 2.5),
      create(:menu_dish, price: 3.99)
    ]
  end

  def req(params: default_params, headers: default_headers)
    patch "/v1/admin/menu/dishes/update_prices", headers:, params:
  end

  context "when not authenticated" do
    let(:default_headers) { {} }

    before { req }

    it { expect(response).to have_http_status(:unauthorized) }

    it { expect(json).to include(message: String) }
  end

  context "when updating all dish prices by 1.01" do
    let(:amount) { 1.01 }

    it { expect { req }.to change { dishes.first.reload.price.to_f }.from(1.0).to(2.01) }
    it { expect { req }.to change { dishes.last.reload.price.to_f }.from(3.99).to(5.00) }

    it do
      req
      expect(response).to have_http_status(:ok)
    end

    it do
      req
      expect(json).to include(details: Array)
    end

    it do
      req
      expect(json[:details]).to eq([
                                     { "id" => dishes.first.id, "price" => 2.01 },
                                     { "id" => dishes.second.id, "price" => 3.51 },
                                     { "id" => dishes.last.id, "price" => 5.00 }
                                   ])
    end

    context "when some dish has price nil" do
      before { dishes.first.update!(price: nil) }

      it { expect { req }.to(change { dishes.first.reload.price }.from(nil).to(1.01)) }
      it { expect { req }.to change { dishes.second.reload.price.to_f }.from(2.5).to(3.51) }
      it { expect { req }.to change { dishes.last.reload.price.to_f }.from(3.99).to(5.00) }

      it do
        req
        expect(response).to have_http_status(:ok)
      end

      it do
        req
        expect(json).to include(details: Array)
      end

      it do
        req
        expect(json[:details]).to contain_exactly({ "id" => dishes.first.id, "price" => 1.01 },
                                                  { "id" => dishes.second.id, "price" => 3.51 }, { "id" => dishes.last.id, "price" => 5.00 })
      end
    end

    context "when providing :dry_run" do
      let(:dry_run) { true }

      it { expect { req }.not_to(change { dishes.first.reload.price }) }
      it { expect { req }.not_to(change { dishes.last.reload.price }) }

      it do
        req
        expect(response).to have_http_status(:ok)
      end

      it do
        req
        expect(json).to include(details: Array)
      end

      it do
        req
        expect(json[:details]).to eq([
                                       { "id" => dishes.first.id, "price" => 2.01 },
                                       { "id" => dishes.second.id, "price" => 3.51 },
                                       { "id" => dishes.last.id, "price" => 5.00 }
                                     ])
      end
    end
  end

  context "when updating all dish prices by percentage" do
    let(:percent) { 15 }
    let(:amount) { nil }

    it { expect { req }.to change { dishes.first.reload.price.to_f }.from(1.0).to(1.15) }
    it { expect { req }.to change { dishes.last.reload.price.to_f }.from(3.99).to(4.59) }

    it do
      req
      expect(response).to have_http_status(:ok)
    end

    it do
      req
      expect(json).to include(details: Array)
    end

    it do
      req
      expect(json[:details].length).to eq(3)
    end
  end

  context "when filtering for ids" do
    let(:amount) { 1.01 }
    let(:filters) { { id: dishes.first.id } }

    it { expect { req }.to change { dishes.first.reload.price.to_f }.from(1.0).to(2.01) }
    it { expect { req }.not_to(change { dishes.second.as_json }) }
    it { expect { req }.not_to(change { dishes.last.as_json }) }

    it do
      req
      expect(json).to include(details: Array)
    end

    it do
      req
      expect(json[:details]).to eq([
                                     { "id" => dishes.first.id, "price" => 2.01 }
                                   ])
    end
  end

  [
    0,
    -101,
    101,
    1000,
    1.15
  ].each do |invalid_percent|
    context "percentage #{invalid_percent.inspect} is not valid" do
      let(:percent) { invalid_percent }
      let(:amount) { nil }

      it { expect { req }.not_to(change { dishes.map(&:as_json) }) }

      it do
        req
        expect(response).to have_http_status(:bad_request)
      end

      it do
        req
        expect(json).to include(message: String)
      end
    end
  end

  [
    1,
    15,
    -20,
    100,
    -100
  ].each do |valid_percent|
    context "when percent is #{valid_percent.inspect}, is valid." do
      let(:percent) { valid_percent }
      let(:amount) { nil }

      it { expect { req }.to(change { dishes.first.reload.price.to_f }.from(1.0).to(1 + (valid_percent.to_f / 100))) }
      it { expect { req }.to(change { dishes.second.reload.price }) }
      it { expect { req }.to(change { dishes.third.reload.price }) }

      it do
        req
        expect(response).to have_http_status(:ok)
      end

      it do
        req
        expect(json).not_to include(:message)
        expect(json).not_to include("message")
      end

      it do
        req
        expect(json[:details].length).to eq(3)
      end
    end
  end
end
