# frozen_string_literal: true

require "rails_helper"

RSpec.describe V1::Admin::ReservationsController do
  it do
    expect(get: "v1/admin/reservations").to route_to("v1/admin/reservations#index", format: :json)
  end

  it do
    expect(get: "v1/admin/reservations/1").to route_to("v1/admin/reservations#show", id: "1", format: :json)
  end

  it do
    expect(post: "v1/admin/reservations").to route_to("v1/admin/reservations#create", format: :json)
  end

  it do
    expect(put: "v1/admin/reservations/1").to route_to("v1/admin/reservations#update", id: "1", format: :json)
  end

  it do
    expect(patch: "v1/admin/reservations/1").to route_to("v1/admin/reservations#update", id: "1", format: :json)
  end

  it do
    expect(delete: "v1/admin/reservations/1").to route_to("v1/admin/reservations#destroy", id: "1", format: :json)
  end
end
