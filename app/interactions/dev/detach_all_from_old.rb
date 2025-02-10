# frozen_string_literal: true

module Dev
  # Will remove all member_id from all records.
  class DetachAllFromOld < ActiveInteraction::Base
    def execute
      Menu::Category.update_all(member_id: nil)
      Menu::Tag.update_all(member_id: nil)
      Menu::Ingredient.update_all(member_id: nil)
      Menu::Allergen.update_all(member_id: nil)
      Menu::Dish.update_all(member_id: nil)
      Image.update_all(member_id: nil)
      Reservation.update_all(member_id: nil)
    end
  end
end
