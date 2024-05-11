# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Routing /v1/admin/preferences" do
  it { expect(get: "/v1/admin/preferences").to route_to("v1/admin/preferences#index", format: :json) }

  it { expect(get: "/v1/admin/preferences/hash").to route_to("v1/admin/preferences#hash", format: :json) }

  it {
    expect(get: "/v1/admin/preferences/some-key").to route_to("v1/admin/preferences#show", format: :json,
                                                                                           key: "some-key")
  }

  it {
    expect(get: "/v1/admin/preferences/pref-key").to route_to("v1/admin/preferences#show", format: :json,
                                                                                           key: "pref-key")
  }

  it {
    expect(patch: "/v1/admin/preferences/some-key").to route_to("v1/admin/preferences#update", format: :json,
                                                                                               key: "some-key")
  }

  it {
    expect(patch: "/v1/admin/preferences/pref-key").to route_to("v1/admin/preferences#update", format: :json,
                                                                                               key: "pref-key")
  }
end
