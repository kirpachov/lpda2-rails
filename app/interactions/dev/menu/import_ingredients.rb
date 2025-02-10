# frozen_string_literal: true

require "csv"

module Dev::Menu
  class ImportIngredients < ActiveInteraction::Base
    DEFAULT_FILE = Rails.root.join("migration/records/ingredients.csv").to_s

    string :file, default: DEFAULT_FILE
    boolean :verbose, default: false

    def execute
      Rails.logger.silence(verbose ? Logger::DEBUG : Logger::WARN) do
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

          image_id = row["imageId"].to_i.zero? ? nil : row["imageId"].to_i

          ingredient.image = Image.where(member_id: image_id).first if image_id.to_i.positive?.present?

          if ingredient.image.nil? && image_id.present?
            Rails.logger.warn "Image not found for ingredient #{ingredient.member_id}. Old image id: #{image_id.inspect}"
          end

          ingredient.save!
        end
      end
    end
  end
end
