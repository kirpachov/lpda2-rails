# frozen_string_literal: true

module Dev::Menu
  class ImportMenus < ActiveInteraction::Base
    DEFAULT_FILE = Rails.root.join("migration/records/menu.csv").to_s

    string :file, default: DEFAULT_FILE
    boolean :verbose, default: false

    def execute
      Rails.logger.silence(verbose ? Logger::DEBUG : Logger::WARN) do
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

          if row["imageId"].to_i.positive? && (image = Image.find_by(member_id: row["imageId"]))
            menu.images << image unless menu.images.include?(image)
          else
            Rails.logger.warn "Image not found for menu #{menu.member_id}. Old image id: #{row["imageId"].inspect}"
          end

          menu.save!
        end
      end
    end
  end
end
