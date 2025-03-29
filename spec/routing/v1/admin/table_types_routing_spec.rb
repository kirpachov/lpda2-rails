# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Routing /v1/admin/table_types" do
  it do
    expect(get: "/v1/admin/table_types").to route_to("v1/admin/table_types#index", format: :json)
  end

  it do
    expect(get: "/v1/admin/table_types/67").to route_to("v1/admin/table_types#show", format: :json, id: "67")
  end

  it do
    expect(patch: "/v1/admin/table_types/67").to route_to("v1/admin/table_types#update", format: :json,
                                                                                         id: "67")
  end

  it do
    expect(post: "/v1/admin/table_types").to route_to("v1/admin/table_types#create", format: :json)
  end

  it do
    expect(delete: "/v1/admin/table_types/22").to route_to("v1/admin/table_types#destroy", format: :json,
                                                                                           id: "22")
  end

  it do
    expect(delete: "/v1/admin/table_types/22/remove_from_preorder_reservation_groups").to route_to("v1/admin/table_types#remove_from_preorder_reservation_groups", format: :json,
                                                                                                                                                                   id: "22")
  end

  it do
    expect(patch: "/v1/admin/table_types/22/update_status").to route_to("v1/admin/table_types#update_status", format: :json,
                                                                                                              id: "22")
  end
end
