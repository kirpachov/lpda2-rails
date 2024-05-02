# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Routing /v1/admin/settings" do
  it { expect(get: "/v1/admin/settings").to route_to("v1/admin/settings#index", format: :json) }

  it { expect(get: "/v1/admin/settings/some-key").to route_to("v1/admin/settings#show", format: :json, key: "some-key") }
  it { expect(get: "/v1/admin/settings/pref-key").to route_to("v1/admin/settings#show", format: :json, key: "pref-key") }

  it { expect(get: "/v1/admin/settings/some-key/value").to route_to("v1/admin/settings#value", format: :json, key: "some-key") }
  it { expect(get: "/v1/admin/settings/pref-key/value").to route_to("v1/admin/settings#value", format: :json, key: "pref-key") }

  it { expect(patch: "/v1/admin/settings/some-key").to route_to("v1/admin/settings#update", format: :json, key: "some-key") }
  it { expect(patch: "/v1/admin/settings/pref-key").to route_to("v1/admin/settings#update", format: :json, key: "pref-key") }
end
