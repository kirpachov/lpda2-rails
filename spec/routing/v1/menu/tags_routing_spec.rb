# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Routing /v1/menu/tags" do
  it { expect(get: "/v1/menu/tags").to route_to("v1/menu/tags#index", format: :json) }
  it { expect(get: "/v1/menu/tags/77").to route_to("v1/menu/tags#show", format: :json, id: "77") }
  it { expect(get: "/v1/menu/tags/22").to route_to("v1/menu/tags#show", format: :json, id: "22") }
end
