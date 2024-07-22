# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Routing /v1/public_data" do
  it { expect(get: "/v1/public_data").to route_to("v1/public_data#index", format: :json) }
end
