# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Routing /v1/menu/allergens" do
  it { expect(get: "/v1/menu/allergens").to route_to("v1/menu/allergens#index", format: :json) }
  it { expect(get: "/v1/menu/allergens/77").to route_to("v1/menu/allergens#show", format: :json, id: "77") }
  it { expect(get: "/v1/menu/allergens/22").to route_to("v1/menu/allergens#show", format: :json, id: "22") }
end
