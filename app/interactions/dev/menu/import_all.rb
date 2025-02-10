# frozen_string_literal: true

module Dev
  module Menu
    class ImportAll < ActiveInteraction::Base

      boolean :verbose, default: false

      def execute
        ImportAllergens.run!(verbose:)
        ImportIngredients.run!(verbose:)
        ImportTags.run!(verbose:)
        ImportMenus.run!(verbose:)
        ImportCategories.run!(verbose:)
        ImportDishes.run!(verbose:)
      end
    end
  end
end
