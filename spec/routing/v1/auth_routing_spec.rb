# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Routing /v1/auth" do
  it { expect(post: "/v1/auth/login").to route_to("v1/auth#login", format: :json) }
  it { expect(post: "/v1/auth/refresh_token").to route_to("v1/auth#refresh_token", format: :json) }
  it { expect(post: "/v1/auth/logout").to route_to("v1/auth#logout", format: :json) }
  it { expect(post: "/v1/auth/reset_password").to route_to("v1/auth#reset_password", format: :json) }
  it { expect(post: "/v1/auth/require_reset_password").to route_to("v1/auth#require_reset_password", format: :json) }
end
