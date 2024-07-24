# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Routing /v1/reservations" do
  it { expect(post: "/v1/reservations").to route_to("v1/reservations#create", format: :json) }

  it {
    expect(get: "/v1/reservations/some-secret").to route_to("v1/reservations#show", format: :json,
                                                                                    secret: "some-secret")
  }

  it { expect(patch: "/v1/reservations/cancel").to route_to("v1/reservations#cancel", format: :json) }

  it {
    expect(patch: "/v1/reservations/some-secret/cancel").to route_to("v1/reservations#cancel", format: :json,
                                                                                               secret: "some-secret")
  }

  it {
    expect(post: "/v1/reservations/some-secret/resend_confirmation_email").to route_to("v1/reservations#resend_confirmation_email", format: :json, secret: "some-secret")
  }
end
