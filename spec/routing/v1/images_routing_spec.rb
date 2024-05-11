# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Routing /v1/images" do
  it { expect(get: "/v1/images").to route_to("v1/images#index", format: :json) }
  it { expect(get: "/v1/images/22").to route_to("v1/images#show", format: :json, id: "22") }
  it { expect(get: "/v1/images/22/download").to route_to("v1/images#download", format: :json, id: "22") }

  it {
    expect(get: "/v1/images/22/download/tag").to route_to("v1/images#download_variant", format: :json, id: "22",
                                                                                        variant: "tag")
  }

  it {
    expect(get: "/v1/images/key/super-secret-key").to route_to("v1/images#download_by_key", format: :json,
                                                                                            key: "super-secret-key")
  }

  it {
    expect(get: "/v1/images/p/super-secret").to route_to("v1/images#download_by_pixel_secret", format: :json,
                                                                                               secret: "super-secret")
  }

  # May want to move this under /admin route (?)
  it {
    expect(patch: "/v1/images/22/remove_from_record").to route_to("v1/images#remove_from_record", format: :json,
                                                                                                  id: "22")
  }

  it { expect(patch: "/v1/images/record").to route_to("v1/images#update_record", format: :json) }
  it { expect(post: "/v1/images/").to route_to("v1/images#create", format: :json) }
end
