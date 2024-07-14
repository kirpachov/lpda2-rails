# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Routing /v1/admin/reservations" do
  it { expect(get: "v1/admin/reservations").to route_to("v1/admin/reservations#index", format: :json) }
  it { expect(get: "v1/admin/reservations/1").to route_to("v1/admin/reservations#show", id: "1", format: :json) }
  it { expect(post: "v1/admin/reservations").to route_to("v1/admin/reservations#create", format: :json) }
  it { expect(put: "v1/admin/reservations/1").to route_to("v1/admin/reservations#update", id: "1", format: :json) }
  it { expect(patch: "v1/admin/reservations/1").to route_to("v1/admin/reservations#update", id: "1", format: :json) }
  it { expect(delete: "v1/admin/reservations/1").to route_to("v1/admin/reservations#destroy", id: "1", format: :json) }

  it {
    expect(get: "v1/admin/reservations/valid_times").to route_to("v1/admin/reservations#valid_times", format: :json)
  }

  it {
    expect(patch: "v1/admin/reservations/33/status/new-status").to route_to("v1/admin/reservations#update_status",
                                                                            format: :json, id: "33", status: "new-status")
  }

  it {
    expect(post: "v1/admin/reservations/33/add_tag/29").to route_to("v1/admin/reservations#add_tag", format: :json,
                                                                                                     id: "33", tag_id: "29")
  }

  it {
    expect(delete: "v1/admin/reservations/33/remove_tag/29").to route_to("v1/admin/reservations#remove_tag",
                                                                         format: :json, id: "33", tag_id: "29")
  }

  it {
    expect(post: "v1/admin/reservations/33/deliver_confirmation_email").to route_to(
      "v1/admin/reservations#deliver_confirmation_email", format: :json, id: "33"
    )
  }

  it { expect(get: "v1/admin/reservations/tables_summary").to route_to("v1/admin/reservations#tables_summary", format: :json) }
end
