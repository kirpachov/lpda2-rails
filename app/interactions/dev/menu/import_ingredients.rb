# frozen_string_literal: true

require "csv"

module Dev::Menu
  class ImportIngredients < ActiveInteraction::Base
    DEFAULT_FILE = Rails.root.join("migration/menu/ingredients.csv").to_s

    string :file, default: DEFAULT_FILE

    def execute
      CSV.foreach(file, headers: true, col_sep: ";", liberal_parsing: true) do |row|
        ingredient = Menu::Ingredient.find_or_initialize_by(member_id: row["id"])
        Mobility.with_locale(:it) do
          ingredient.name = row["name.it"]
          ingredient.description = row["description.it"]
        end

        Mobility.with_locale(:en) do
          ingredient.name = row["name.en"]
          ingredient.description = row["description.en"]
        end

        ingredient.image = Image.where(member_id: row["imageId"]).first if row["imageId"].present?

        ingredient.save!
      end
    end
  end
end
