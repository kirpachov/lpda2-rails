require "rails_helper"

RSpec.describe V1::Admin::ReservationsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "v1/admin/reservations").to route_to("v1/admin/reservations#index", format: :json)
    end

    it "routes to #show" do
      expect(get: "v1/admin/reservations/1").to route_to("v1/admin/reservations#show", id: "1", format: :json)
    end


    it "routes to #create" do
      expect(post: "v1/admin/reservations").to route_to("v1/admin/reservations#create", format: :json)
    end

    it "routes to #update via PUT" do
      expect(put: "v1/admin/reservations/1").to route_to("v1/admin/reservations#update", id: "1", format: :json)
    end

    it "routes to #update via PATCH" do
      expect(patch: "v1/admin/reservations/1").to route_to("v1/admin/reservations#update", id: "1", format: :json)
    end

    it "routes to #destroy" do
      expect(delete: "v1/admin/reservations/1").to route_to("v1/admin/reservations#destroy", id: "1", format: :json)
    end
  end
end
