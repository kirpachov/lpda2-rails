# frozen_string_literal: true

require "csv"

module Dev::Menu
  class ImportAllergens < ActiveInteraction::Base
    DEFAULT_FILE = Rails.root.join("migration/menu/allergens.csv").to_s

    string :file, default: DEFAULT_FILE

    def execute
      CSV.foreach(file, headers: true, col_sep: ";", liberal_parsing: true) do |row|
        allergen = Menu::Allergen.find_or_initialize_by(member_id: row["id"])
        Mobility.with_locale(:it) do
          allergen.name = row["name.it"]
        end

        Mobility.with_locale(:en) do
          allergen.name = row["name.en"]
        end

        allergen.image = Image.where(member_id: row["imageId"]).first if row["imageId"].present?

        allergen.save!
      end
    end
  end
end
