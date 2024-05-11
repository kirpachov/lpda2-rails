# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Routing /v1/admin/menu/allergens" do
  it { expect(get: "/v1/admin/menu/allergens").to route_to("v1/admin/menu/allergens#index", format: :json) }
  it { expect(post: "/v1/admin/menu/allergens").to route_to("v1/admin/menu/allergens#create", format: :json) }
  it { expect(get: "/v1/admin/menu/allergens/77").to route_to("v1/admin/menu/allergens#show", format: :json, id: "77") }
  it { expect(get: "/v1/admin/menu/allergens/22").to route_to("v1/admin/menu/allergens#show", format: :json, id: "22") }

  it {
    expect(patch: "/v1/admin/menu/allergens/77").to route_to("v1/admin/menu/allergens#update", format: :json, id: "77")
  }

  it {
    expect(delete: "/v1/admin/menu/allergens/77").to route_to("v1/admin/menu/allergens#destroy", format: :json,
                                                                                                 id: "77")
  }

  it {
    expect(post: "/v1/admin/menu/allergens/77/copy").to route_to("v1/admin/menu/allergens#copy", format: :json,
                                                                                                 id: "77")
  }

  it {
    expect(post: "/v1/admin/menu/allergens/52/copy").to route_to("v1/admin/menu/allergens#copy", format: :json,
                                                                                                 id: "52")
  }
end
