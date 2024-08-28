# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Routing /v1/menu/categories" do
  it { expect(get: "/v1/menu/categories").to route_to("v1/menu/categories#index", format: :json) }

  it do
    expect(get: "/v1/menu/categories/22").to route_to("v1/menu/categories#show", format: :json, id: "22")
  end
end
