# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Routing /v1/profile" do
  it { expect(get: "/v1/profile").to route_to("v1/profile#index", format: :json) }
end
