# frozen_string_literal: true

require "csv"

module Dev::Menu
  class ImportTags < ActiveInteraction::Base
    DEFAULT_FILE = Rails.root.join("migration/menu/tags.csv").to_s

    string :file, default: DEFAULT_FILE

    def execute
      CSV.foreach(file, headers: true, col_sep: ";", liberal_parsing: true) do |row|
        next if row["id"].blank?

        tag = Menu::Tag.find_or_initialize_by(member_id: row["id"])
        Mobility.with_locale(:it) do
          tag.name = row["name.it"]
        end

        Mobility.with_locale(:en) do
          tag.name = row["name.en"]
        end

        tag.color = row["color"] if row["color"].present?

        tag.image = Image.where(member_id: row["imageId"]).first if row["imageId"].present?

        tag.save!
      end
    end
  end
end
