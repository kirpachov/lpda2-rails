# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Routing /v1/admin/reservation_tags" do
  it { expect(get: "/v1/admin/reservation_tags").to route_to("v1/admin/reservation_tags#index", format: :json) }

  it {
    expect(get: "/v1/admin/reservation_tags/67").to route_to("v1/admin/reservation_tags#show", format: :json, id: "67")
  }

  it {
    expect(patch: "/v1/admin/reservation_tags/67").to route_to("v1/admin/reservation_tags#update", format: :json,
                                                                                                   id: "67")
  }

  it { expect(post: "/v1/admin/reservation_tags").to route_to("v1/admin/reservation_tags#create", format: :json) }

  it {
    expect(delete: "/v1/admin/reservation_tags/22").to route_to("v1/admin/reservation_tags#destroy", format: :json,
                                                                                                     id: "22")
  }
end
