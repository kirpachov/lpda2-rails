# frozen_string_literal: true

require "csv"

module Dev::Menu
  class ImportCategories < ActiveInteraction::Base
    DEFAULT_FILE = Rails.root.join("migration/menu/categories.csv").to_s

    string :file, default: DEFAULT_FILE

    def execute
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
        end

        if row["imageId"].present? && (image = Image.find_by(member_id: row["imageId"])) && !category.images.include?(image)
          category.images << image
        end

        category.save!
      end
    end

    # Returns a hash of { categoryId => menuId }
    def categories
      return @categories if @categories

      data = CSV.open(Rails.root.join("migration/menu/menuCategoryAssociation.csv"), headers: true, col_sep: ";", liberal_parsing: true).to_a.map(&:to_h)

      @categories = data.map { |j| [j["categoryId"], j["menuId"]] }.to_h
    end
  end
end
