# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Routing /v1/menu/ingredients" do
  it { expect(get: "/v1/menu/ingredients").to route_to("v1/menu/ingredients#index", format: :json) }

  it {
    expect(get: "/v1/menu/ingredients/77").to route_to("v1/menu/ingredients#show", format: :json, id: "77")
  }

  it {
    expect(get: "/v1/menu/ingredients/22").to route_to("v1/menu/ingredients#show", format: :json, id: "22")
  }
end
