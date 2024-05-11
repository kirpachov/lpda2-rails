# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Routing /v1/admin/menu/ingredients" do
  it { expect(get: "/v1/admin/menu/ingredients").to route_to("v1/admin/menu/ingredients#index", format: :json) }
  it { expect(post: "/v1/admin/menu/ingredients").to route_to("v1/admin/menu/ingredients#create", format: :json) }

  it {
    expect(get: "/v1/admin/menu/ingredients/77").to route_to("v1/admin/menu/ingredients#show", format: :json, id: "77")
  }

  it {
    expect(get: "/v1/admin/menu/ingredients/22").to route_to("v1/admin/menu/ingredients#show", format: :json, id: "22")
  }

  it {
    expect(patch: "/v1/admin/menu/ingredients/77").to route_to("v1/admin/menu/ingredients#update", format: :json,
                                                                                                   id: "77")
  }

  it {
    expect(delete: "/v1/admin/menu/ingredients/77").to route_to("v1/admin/menu/ingredients#destroy", format: :json,
                                                                                                     id: "77")
  }

  it {
    expect(post: "/v1/admin/menu/ingredients/77/copy").to route_to("v1/admin/menu/ingredients#copy", format: :json,
                                                                                                     id: "77")
  }

  it {
    expect(post: "/v1/admin/menu/ingredients/52/copy").to route_to("v1/admin/menu/ingredients#copy", format: :json,
                                                                                                     id: "52")
  }
end
