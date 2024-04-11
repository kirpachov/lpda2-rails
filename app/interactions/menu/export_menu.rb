# frozen_string_literal: true

require "rubyXL"
require "rubyXL/convenience_methods" # requires all convenience methods
# require "rubyXL/convenience_methods/workbook"
# require "rubyXL/convenience_methods/worksheet"

module Menu
  # Export menu in xlsx file.
  class ExportMenu < ActiveInteraction::Base
    OUTPUT_FILE = Rails.root.join("tmp/menu-#{Time.now.to_i}.xlsx").to_s

    def execute
      write_allergens(foc_sheet("Allergens"))
      write_ingredients(foc_sheet("Ingredients"))
      write_tags(foc_sheet("Tags"))
      write_dishes(foc_sheet("Dishes"))
      write_menu(foc_sheet("Menu"))
      # TODO add a massive file where all the data is present.
      # Menu
      # - Category1
      # - - Dish1
      # - - - Ingredient1
      # - - - Ingredient2
      # - - - Tag1
      # - - - Tag2
      # - - - Allergen1
      # - - Dish2
      # - Category2

      workbook.write(OUTPUT_FILE)

      OUTPUT_FILE
    end

    def write_menu(sheet)
      write_row(sheet, 0, %w[id name.it name.en description.it description.en status price images])
      Menu::Category.all.where(parent_id: nil).each_with_index do |cat, index|
        write_row(sheet, index + 1, [cat.id, cat.name_it, cat.name_en, cat.description_it, cat.description_en, cat.status, cat.price, cat.images.map(&:url)].flatten)
      end
    end

    def write_dishes(sheet)
      write_row(sheet, 0, %w[id name.it name.en description.it description.en status price images])
      Menu::Dish.all.each_with_index do |dish, index|
        write_row(sheet, index + 1, [dish.id, dish.name_it, dish.name_en, dish.description_it, dish.description_en, dish.status, dish.price, dish.images.map(&:url)].flatten)
      end
    end

    def write_allergens(sheet)
      write_row(sheet, 0, %w[id name.it name.en description.it description.en status imageUrl])
      Menu::Allergen.all.visible.each_with_index do |allergen, index|
        write_row(sheet, index + 1, [allergen.id, allergen.name_it, allergen.name_en, allergen.description_it, allergen.description_en, allergen.status, allergen.image&.url])
      end
    end

    def write_tags(sheet)
      write_row(sheet, 0, %w[id name.it name.en description.it description.en status color imageUrl])
      Menu::Tag.all.visible.each_with_index do |tag, index|
        write_row(sheet, index + 1, [tag.id, tag.name_it, tag.name_en, tag.description_it, tag.description_en, tag.status, tag.color, tag.image&.url])
      end
    end

    def write_ingredients(sheet)
      write_row(sheet, 0, %w[id name.it name.en description.it description.en status imageUrl])
      Menu::Ingredient.all.visible.each_with_index do |ingredient, index|
        write_row(sheet, index + 1, [ingredient.id, ingredient.name_it, ingredient.name_en, ingredient.description_it, ingredient.description_en, ingredient.status, ingredient.image&.url])
      end
    end

    private

    def workbook
      @workbook ||= RubyXL::Workbook.new
    end

    def foc_sheet(name)
      workbook.add_worksheet(name) if workbook[name].nil?

      workbook[name]
    end

    def write(sheet, x_start, y_start, data)
      data.each_with_index do |d, index|
        sheet.insert_cell(x_start, y_start + index, d)
      end
    end

    def write_row(sheet, x_start, data)
      write(sheet, x_start, 0, data)
    end
  end
end
