# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Routing /v1/admin/users" do
  it { expect(get: "/v1/admin/users").to route_to("v1/admin/users#index", format: :json) }
  it { expect(post: "/v1/admin/users").to route_to("v1/admin/users#create", format: :json) }
  it { expect(get: "/v1/admin/users/2").to route_to("v1/admin/users#show", format: :json, id: "2") }
  it { expect(delete: "/v1/admin/users/2").to route_to("v1/admin/users#destroy", format: :json, id: "2") }
end
