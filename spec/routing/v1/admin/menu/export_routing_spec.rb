# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Routing /v1/admin/menu/export" do
  it { expect(get: "/v1/admin/menu/export").to route_to("v1/admin/menu/export#export", format: :json) }
end
