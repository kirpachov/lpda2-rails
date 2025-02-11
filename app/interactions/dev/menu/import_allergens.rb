# frozen_string_literal: true

module Dev::Menu
  class ImportAllergens < ActiveInteraction::Base
    DEFAULT_FILE = Rails.root.join("migration/records/allergens.csv").to_s

    string :file, default: DEFAULT_FILE
    boolean :verbose, default: false

    def execute
      Rails.logger.silence(verbose ? Logger::DEBUG : Logger::WARN) do
        CSV.foreach(file, headers: true, col_sep: ";", liberal_parsing: true) do |row|
          allergen = Menu::Allergen.find_or_initialize_by(member_id: row["id"])
          Mobility.with_locale(:it) do
            allergen.name = row["name.it"]
          end

          Mobility.with_locale(:en) do
            allergen.name = row["name.en"]
          end

          image_id = row["imageId"].to_i.zero? ? nil : row["imageId"].to_i

          allergen.image = Image.where(member_id: image_id).first if image_id.present?

          if allergen.image.nil? && image_id.present?
            Rails.logger.warn "Image not found for allergen #{allergen.member_id}. Old image id: #{image_id.inspect}"
          end

          allergen.save!
        end
      end
    end
  end
end
