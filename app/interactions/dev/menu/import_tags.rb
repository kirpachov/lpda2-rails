# frozen_string_literal: true

require "csv"

module Dev::Menu
  class ImportTags < ActiveInteraction::Base
    DEFAULT_FILE = Rails.root.join("migration/records/tags.csv").to_s

    string :file, default: DEFAULT_FILE
    boolean :verbose, default: false

    def execute
      Rails.logger.silence(verbose ? Logger::DEBUG : Logger::WARN) do
        CSV.foreach(file, headers: true, col_sep: ";", liberal_parsing: true) do |row|
          tag = Menu::Tag.find_or_initialize_by(member_id: row["id"])

          Mobility.with_locale(:it) do
            tag.name = row["name.it"]
          end

          Mobility.with_locale(:en) do
            tag.name = row["name.en"]
          end

          tag.color = row["color"] if row["color"].present?

          image_id = row["imageId"].to_i.zero? ? nil : row["imageId"].to_i

          tag.image = Image.where(member_id: image_id).first if image_id.present?

          if tag.image.nil? && image_id.present?
            Rails.logger.warn "Image not found for tag #{tag.member_id}. Old image id: #{image_id.inspect}"
          end

          tag.save!
        end
      end
    end
  end
end
