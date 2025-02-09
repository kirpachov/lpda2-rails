# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Routing /v1/admin/menu/dishes" do
  it { expect(get: "/v1/admin/menu/dishes").to route_to("v1/admin/menu/dishes#index", format: :json) }
  it { expect(post: "/v1/admin/menu/dishes").to route_to("v1/admin/menu/dishes#create", format: :json) }
  it { expect(get: "/v1/admin/menu/dishes/77").to route_to("v1/admin/menu/dishes#show", format: :json, id: "77") }
  it { expect(get: "/v1/admin/menu/dishes/22").to route_to("v1/admin/menu/dishes#show", format: :json, id: "22") }
  it { expect(patch: "/v1/admin/menu/dishes/77").to route_to("v1/admin/menu/dishes#update", format: :json, id: "77") }
  it { expect(delete: "/v1/admin/menu/dishes/77").to route_to("v1/admin/menu/dishes#destroy", format: :json, id: "77") }
  it { expect(post: "/v1/admin/menu/dishes/77/copy").to route_to("v1/admin/menu/dishes#copy", format: :json, id: "77") }
  it { expect(post: "/v1/admin/menu/dishes/52/copy").to route_to("v1/admin/menu/dishes#copy", format: :json, id: "52") }

  it {
    expect(patch: "/v1/admin/menu/dishes/update_prices").to route_to("v1/admin/menu/dishes#update_prices",
                                                                     format: :json)
  }

  it {
    expect(get: "/v1/admin/menu/dishes/52/references").to route_to("v1/admin/menu/dishes#references", format: :json,
                                                                                                      id: "52")
  }

  it {
    expect(post: "/v1/admin/menu/dishes/52/suggestions/86").to route_to("v1/admin/menu/dishes#add_suggestion",
                                                                        format: :json, id: "52", suggestion_id: "86")
  }

  it {
    expect(delete: "/v1/admin/menu/dishes/52/suggestions/86").to route_to("v1/admin/menu/dishes#remove_suggestion",
                                                                          format: :json, id: "52", suggestion_id: "86")
  }

  it {
    expect(patch: "/v1/admin/menu/dishes/52/move").to route_to("v1/admin/menu/dishes#move", format: :json, id: "52")
  }

  it {
    expect(delete: "/v1/admin/menu/dishes/52/remove_from_category").to route_to(
      "v1/admin/menu/dishes#remove_from_category", format: :json, id: "52"
    )
  }

  it {
    expect(delete: "/v1/admin/menu/dishes/52/remove_from_category/21").to route_to(
      "v1/admin/menu/dishes#remove_from_category", format: :json, id: "52", category_id: "21"
    )
  }

  it {
    expect(patch: "/v1/admin/menu/dishes/52/status/some-new-status").to route_to("v1/admin/menu/dishes#update_status",
                                                                                 format: :json, id: "52", status: "some-new-status")
  }

  it {
    expect(post: "/v1/admin/menu/dishes/52/ingredients/71").to route_to("v1/admin/menu/dishes#add_ingredient",
                                                                        format: :json, id: "52", ingredient_id: "71")
  }

  it {
    expect(patch: "/v1/admin/menu/dishes/52/ingredients/71/move").to route_to("v1/admin/menu/dishes#move_ingredient",
                                                                              format: :json, id: "52", ingredient_id: "71")
  }

  it {
    expect(delete: "/v1/admin/menu/dishes/52/ingredients/71").to route_to("v1/admin/menu/dishes#remove_ingredient",
                                                                          format: :json, id: "52", ingredient_id: "71")
  }

  it {
    expect(post: "/v1/admin/menu/dishes/52/tags/71").to route_to("v1/admin/menu/dishes#add_tag", format: :json, id: "52",
                                                                                                 tag_id: "71")
  }

  it {
    expect(patch: "/v1/admin/menu/dishes/52/tags/71/move").to route_to("v1/admin/menu/dishes#move_tag", format: :json,
                                                                                                        id: "52", tag_id: "71")
  }

  it {
    expect(delete: "/v1/admin/menu/dishes/52/tags/71").to route_to("v1/admin/menu/dishes#remove_tag", format: :json,
                                                                                                      id: "52", tag_id: "71")
  }

  it {
    expect(post: "/v1/admin/menu/dishes/52/allergens/71").to route_to("v1/admin/menu/dishes#add_allergen", format: :json,
                                                                                                           id: "52", allergen_id: "71")
  }

  it {
    expect(patch: "/v1/admin/menu/dishes/52/allergens/71/move").to route_to("v1/admin/menu/dishes#move_allergen",
                                                                            format: :json, id: "52", allergen_id: "71")
  }

  it {
    expect(delete: "/v1/admin/menu/dishes/52/allergens/71").to route_to("v1/admin/menu/dishes#remove_allergen",
                                                                        format: :json, id: "52", allergen_id: "71")
  }

  it {
    expect(post: "/v1/admin/menu/dishes/52/images/71").to route_to("v1/admin/menu/dishes#add_image", format: :json,
                                                                                                     id: "52", image_id: "71")
  }

  it {
    expect(delete: "/v1/admin/menu/dishes/52/images/71").to route_to("v1/admin/menu/dishes#remove_image", format: :json,
                                                                                                          id: "52", image_id: "71")
  }
end
