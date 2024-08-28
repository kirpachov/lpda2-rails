# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Routing /v1/menu/dishes" do
  it { expect(get: "/v1/menu/dishes").to route_to("v1/menu/dishes#index", format: :json) }
  it { expect(get: "/v1/menu/dishes/77").to route_to("v1/menu/dishes#show", format: :json, id: "77") }
  it { expect(get: "/v1/menu/dishes/22").to route_to("v1/menu/dishes#show", format: :json, id: "22") }
end
