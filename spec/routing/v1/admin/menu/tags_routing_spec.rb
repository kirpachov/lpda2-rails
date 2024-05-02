# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Routing /v1/admin/menu/tags" do
  it { expect(get: "/v1/admin/menu/tags").to route_to("v1/admin/menu/tags#index", format: :json) }
  it { expect(post: "/v1/admin/menu/tags").to route_to("v1/admin/menu/tags#create", format: :json) }
  it { expect(get: "/v1/admin/menu/tags/77").to route_to("v1/admin/menu/tags#show", format: :json, id: "77") }
  it { expect(get: "/v1/admin/menu/tags/22").to route_to("v1/admin/menu/tags#show", format: :json, id: "22") }
  it { expect(patch: "/v1/admin/menu/tags/77").to route_to("v1/admin/menu/tags#update", format: :json, id: "77") }
  it { expect(delete: "/v1/admin/menu/tags/77").to route_to("v1/admin/menu/tags#destroy", format: :json, id: "77") }
  it { expect(post: "/v1/admin/menu/tags/77/copy").to route_to("v1/admin/menu/tags#copy", format: :json, id: "77") }
  it { expect(post: "/v1/admin/menu/tags/52/copy").to route_to("v1/admin/menu/tags#copy", format: :json, id: "52") }
end
