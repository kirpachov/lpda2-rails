# frozen_string_literal: true

require "csv"

module Dev::Menu
  class ImportAllergens < ActiveInteraction::Base
    DEFAULT_FILE = Rails.root.join("migration/menu/allergens.csv").to_s

    string :file, default: DEFAULT_FILE

    def execute
      CSV.foreach(file, headers: true, col_sep: ";", liberal_parsing: true) do |row|
        ingredient = Menu::Allergen.find_or_initialize_by(member_id: row["id"])
        Mobility.with_locale(:it) do
          ingredient.name = row["name.it"]
        end

        Mobility.with_locale(:en) do
          ingredient.name = row["name.en"]
        end

        # TODO: attach image from row["imageId"]

        ingredient.save!
      end
    end
  end
end
