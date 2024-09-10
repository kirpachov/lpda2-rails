# frozen_string_literal: true

require "csv"

module Dev::Menu
  class ImportMenus < ActiveInteraction::Base
    DEFAULT_FILE = Rails.root.join("migration/menu/menu.csv").to_s

    string :file, default: DEFAULT_FILE

    def execute
      CSV.foreach(file, headers: true, col_sep: ";", liberal_parsing: true) do |row|
        menu = Menu::Category.find_or_initialize_by(member_id: "lpda-menu-#{row["id"]}")
        Mobility.with_locale(:it) do
          menu.name = row["name.it"]
          menu.description = row["description.it"]
        end

        Mobility.with_locale(:en) do
          menu.name = row["name.en"]
          menu.description = row["description.en"]
        end

        if row["imageId"].present? && (image = Image.find_by(member_id: row["imageId"])) && !menu.images.include?(image)
          menu.images << image
        end

        menu.save!
      end
    end
  end
end
