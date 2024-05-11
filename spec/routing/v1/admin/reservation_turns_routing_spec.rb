# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Routing /v1/admin/reservation_turns" do
  it do
    expect(get: "/v1/admin/reservation_turns").to route_to("v1/admin/reservation_turns#index", format: :json)
  end

  it do
    expect(get: "/v1/admin/reservation_turns/1").to route_to("v1/admin/reservation_turns#show", id: "1", format: :json)
  end

  it do
    expect(post: "/v1/admin/reservation_turns").to route_to("v1/admin/reservation_turns#create", format: :json)
  end

  it do
    expect(put: "/v1/admin/reservation_turns/1").to route_to("v1/admin/reservation_turns#update", id: "1",
                                                                                                  format: :json)
  end

  it do
    expect(patch: "/v1/admin/reservation_turns/1").to route_to("v1/admin/reservation_turns#update", id: "1",
                                                                                                    format: :json)
  end

  it do
    expect(delete: "/v1/admin/reservation_turns/1").to route_to("v1/admin/reservation_turns#destroy", id: "1",
                                                                                                      format: :json)
  end
end
