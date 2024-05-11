FactoryBot.define do
  factory :menu_dish_suggestion, class: "Menu::DishSuggestion" do
    dish_id { 1 }
    suggestion_id { 1 }
    index { 1 }
  end
end
