# frozen_string_literal: true

require "rails_helper"

RSpec.describe V1::Admin::ReservationTurnsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/v1/admin/reservation_turns").to route_to("v1/admin/reservation_turns#index", format: :json)
    end

    it "routes to #show" do
      expect(get: "/v1/admin/reservation_turns/1").to route_to("v1/admin/reservation_turns#show", id: "1", format: :json)
    end

    it "routes to #create" do
      expect(post: "/v1/admin/reservation_turns").to route_to("v1/admin/reservation_turns#create", format: :json)
    end

    it "routes to #update via PUT" do
      expect(put: "/v1/admin/reservation_turns/1").to route_to("v1/admin/reservation_turns#update", id: "1", format: :json)
    end

    it "routes to #update via PATCH" do
      expect(patch: "/v1/admin/reservation_turns/1").to route_to("v1/admin/reservation_turns#update", id: "1", format: :json)
    end

    it "routes to #destroy" do
      expect(delete: "/v1/admin/reservation_turns/1").to route_to("v1/admin/reservation_turns#destroy", id: "1", format: :json)
    end
  end
end
