# frozen_string_literal: true

require "csv"

module Dev::Menu
  class ImportCategories < ActiveInteraction::Base
    DEFAULT_FILE = Rails.root.join("migration/records/categories.csv").to_s

    string :file, default: DEFAULT_FILE
    boolean :verbose, default: false

    def execute
      Rails.logger.silence(verbose ? Logger::DEBUG : Logger::WARN) do
        CSV.foreach(file, headers: true, col_sep: ";", liberal_parsing: true) do |row|
          category = Menu::Category.find_or_initialize_by(member_id: "lpda-category-#{row["id"]}")
          Mobility.with_locale(:it) do
            category.name = row["name.it"]
            category.description = row["description.it"]
          end

          Mobility.with_locale(:en) do
            category.name = row["name.en"]
            category.description = row["description.en"]
          end

          if (parent = Menu::Category.find_by(member_id: "lpda-menu-#{categories[row["id"]]}"))
            category.parent = parent
            category.visibility = nil
          else
            Rails.logger.warn "Parent not found for category #{category.member_id}. Old parent id: #{categories[row["id"]].inspect}"
          end

          if row["imageId"].to_i.positive? && (image = Image.find_by(member_id: row["imageId"])) && !category.images.include?(image)
            category.images << image
          else
            Rails.logger.warn "Image not found for category #{category.member_id}. Old image id: #{row["imageId"].inspect}"
          end

          category.save!
        end
      end
    end

    # Returns a hash of { categoryId => menuId }
    def categories
      return @categories if @categories

      data = CSV.open(Rails.root.join("migration/records/menuCategoryAssociation.csv"), headers: true, col_sep: ";",
                                                                                     liberal_parsing: true).to_a.map(&:to_h)

      @categories = data.map { |j| [j["categoryId"], j["menuId"]] }.to_h
    end
  end
end
