# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Routing /v1/admin/menu/categories" do
  it { expect(get: "/v1/admin/menu/categories").to route_to("v1/admin/menu/categories#index", format: :json) }
  it { expect(post: "/v1/admin/menu/categories").to route_to("v1/admin/menu/categories#create", format: :json) }
  it { expect(get: "/v1/admin/menu/categories/22").to route_to("v1/admin/menu/categories#show", format: :json, id: "22") }
  it { expect(patch: "/v1/admin/menu/categories/22").to route_to("v1/admin/menu/categories#update", format: :json, id: "22") }
  it { expect(delete: "/v1/admin/menu/categories/22").to route_to("v1/admin/menu/categories#destroy", format: :json, id: "22") }
  it { expect(post: "/v1/admin/menu/categories/22/copy").to route_to("v1/admin/menu/categories#copy", format: :json, id: "22") }
  it { expect(patch: "/v1/admin/menu/categories/22/visibility").to route_to("v1/admin/menu/categories#visibility", format: :json, id: "22") }
  it { expect(patch: "/v1/admin/menu/categories/22/move/1").to route_to("v1/admin/menu/categories#move", format: :json, id: "22", to_index: "1") }
  it { expect(patch: "/v1/admin/menu/categories/22/move/0").to route_to("v1/admin/menu/categories#move", format: :json, id: "22", to_index: "0") }
  it { expect(patch: "/v1/admin/menu/categories/22/order_dishes").to route_to("v1/admin/menu/categories#order_dishes", format: :json, id: "22") }
  it { expect(post: "/v1/admin/menu/categories/22/dishes/98").to route_to("v1/admin/menu/categories#add_dish", format: :json, id: "22", dish_id: "98") }
  it { expect(delete: "/v1/admin/menu/categories/22/dishes/98").to route_to("v1/admin/menu/categories#remove_dish", format: :json, id: "22", dish_id: "98") }
  it { expect(post: "/v1/admin/menu/categories/22/add_category/98").to route_to("v1/admin/menu/categories#add_category", format: :json, id: "22", category_child_id: "98") }
  it { expect(get: "/v1/admin/menu/categories/22/dashboard_data").to route_to("v1/admin/menu/categories#dashboard_data", format: :json, id: "22") }
end
