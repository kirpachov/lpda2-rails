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
      @default_sheet_name = workbook.worksheets.map(&:sheet_name).first
      write_all(foc_sheet("All"))
      write_allergens(foc_sheet("Allergens"))
      write_ingredients(foc_sheet("Ingredients"))
      write_tags(foc_sheet("Tags"))
      write_dishes(foc_sheet("Dishes"))
      write_menu(foc_sheet("Menu"))

      workbook.worksheets.filter! { |s| s.sheet_name != @default_sheet_name }
      workbook.worksheets.sort_by!(&:sheet_name)

      workbook.write(OUTPUT_FILE)

      OUTPUT_FILE
    end

    def write_all(sheet)
      write_row(sheet, 0, %w[element_type element_id name.it name.en description.it description.en status images])
      Menu::Category.all.each_with_index do |cat, cat_index|
        write_row(sheet, cat_index + 1,
                  ["Category", cat.id, cat.name_it, cat.name_en, cat.description_it, cat.description_en, cat.status, cat.images.map(&:url)].flatten)
        cat.dishes.each_with_index do |dish, index_dish|
          write_row(sheet, cat_index + index_dish + 2,
                    ["Dish", dish.id, dish.name_it, dish.name_en, dish.description_it, dish.description_en, dish.status, dish.images.map(&:url)].flatten)
          dish.tags.each_with_index do |tag, index_tag|
            write_row(sheet, cat_index + index_dish + index_tag + 3,
                      ["Tag", tag.id, tag.name_it, tag.name_en, tag.description_it, tag.description_en, tag.status, tag.image&.url])
          end

          dish.allergens.each_with_index do |allergen, index_allergen|
            write_row(sheet, cat_index + index_dish + index_allergen + dish.tags.count + 3,
                      ["Allergen", allergen.id, allergen.name_it, allergen.name_en, allergen.description_it, allergen.description_en, allergen.status, allergen.image&.url])
          end

          dish.ingredients.each_with_index do |ingredient, index_ingredient|
            write_row(sheet, cat_index + index_dish + index_ingredient + dish.tags.count + dish.allergens.count + 3,
                      ["Ingredient", ingredient.id, ingredient.name_it, ingredient.name_en, ingredient.description_it, ingredient.description_en, ingredient.status, ingredient.image&.url])
          end
        end
      end
    end

    def write_menu(sheet)
      write_row(sheet, 0, %w[id name.it name.en description.it description.en status price images])
      Menu::Category.all.where(parent_id: nil).each_with_index do |cat, index|
        write_row(sheet, index + 1,
                  [cat.id, cat.name_it, cat.name_en, cat.description_it, cat.description_en, cat.status, cat.price, cat.images.map(&:url)].flatten)
      end
    end

    def write_dishes(sheet)
      write_row(sheet, 0, %w[id name.it name.en description.it description.en status price images])
      Menu::Dish.all.each_with_index do |dish, index|
        write_row(sheet, index + 1,
                  [dish.id, dish.name_it, dish.name_en, dish.description_it, dish.description_en, dish.status, dish.price, dish.images.map(&:url)].flatten)
      end
    end

    def write_allergens(sheet)
      write_row(sheet, 0, %w[id name.it name.en description.it description.en status imageUrl])
      Menu::Allergen.all.visible.each_with_index do |allergen, index|
        write_row(sheet, index + 1,
                  [allergen.id, allergen.name_it, allergen.name_en, allergen.description_it, allergen.description_en, allergen.status, allergen.image&.url])
      end
    end

    def write_tags(sheet)
      write_row(sheet, 0, %w[id name.it name.en description.it description.en status color imageUrl])
      Menu::Tag.all.visible.each_with_index do |tag, index|
        write_row(sheet, index + 1,
                  [tag.id, tag.name_it, tag.name_en, tag.description_it, tag.description_en, tag.status, tag.color, tag.image&.url])
      end
    end

    def write_ingredients(sheet)
      write_row(sheet, 0, %w[id name.it name.en description.it description.en status imageUrl])
      Menu::Ingredient.all.visible.each_with_index do |ingredient, index|
        write_row(sheet, index + 1,
                  [ingredient.id, ingredient.name_it, ingredient.name_en, ingredient.description_it, ingredient.description_en, ingredient.status, ingredient.image&.url])
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
