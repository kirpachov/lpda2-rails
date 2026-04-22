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
      load_cached_image_urls

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
      Menu::Category.visible.includes(categories_includes).each_with_index do |cat, cat_index|
        write_row(sheet, cat_index + 1,
                  ["Category", cat.id, cat.name_it, cat.name_en, cat.description_it, cat.description_en, cat.status, record_images_url(cat)].flatten)
        cat.visible_menu_dishes.each_with_index do |dish, index_dish|
          write_row(sheet, cat_index + index_dish + 2,
                    ["Dish", dish.id, dish.name_it, dish.name_en, dish.description_it, dish.description_en, dish.status, record_images_url(dish)].flatten)

          dish_tags_count = 0
          dish.visible_menu_tags.each_with_index do |tag, index_tag|
            dish_tags_count += 1
            write_row(sheet, cat_index + index_dish + index_tag + 3,
                      ["Tag", tag.id, tag.name_it, tag.name_en, tag.description_it, tag.description_en, tag.status, record_image_url(tag)])
          end

          dish_allergens_count = 0
          dish.visible_menu_allergens.each_with_index do |allergen, index_allergen|
            dish_allergens_count += 1
            write_row(sheet, cat_index + index_dish + index_allergen + dish_tags_count + 3,
                      ["Allergen", allergen.id, allergen.name_it, allergen.name_en, allergen.description_it, allergen.description_en, allergen.status, record_image_url(allergen)])
          end

          dish.visible_menu_ingredients.each_with_index do |ingredient, index_ingredient|
            write_row(sheet, cat_index + index_dish + index_ingredient + dish_tags_count + dish_allergens_count + 3,
                      ["Ingredient", ingredient.id, ingredient.name_it, ingredient.name_en, ingredient.description_it, ingredient.description_en, ingredient.status, record_image_url(ingredient)])
          end
        end
      end
    end

    def write_menu(sheet)
      write_row(sheet, 0,
                %w[id name.it name.en description.it description.en status price updated_at created_at images])
      Menu::Category.visible.includes(categories_includes).where(parent_id: nil).limit(1000).each_with_index do |cat, index|
        write_row(sheet, index + 1,
                  [cat.id, cat.name_it, cat.name_en, cat.description_it, cat.description_en, cat.status, cat.price, cat.updated_at, cat.created_at, record_images_url(cat)].flatten)
      end
    end

    def write_dishes(sheet)
      write_row(sheet, 0,
                %w[id name.it name.en description.it description.en status price updated_at created_at images])
      Menu::Dish.visible.includes(dishes_includes).limit(1000).each_with_index do |dish, index|
        write_row(sheet, index + 1,
                  [dish.id, dish.name_it, dish.name_en, dish.description_it, dish.description_en, dish.status, dish.price, dish.updated_at, dish.created_at, record_images_url(dish)].flatten)
      end
    end

    def write_allergens(sheet)
      write_row(sheet, 0, %w[id name.it name.en description.it description.en status imageUrl updated_at created_at])
      Menu::Allergen.visible.includes(allergen_includes).limit(1000).each_with_index do |allergen, index|
        write_row(sheet, index + 1,
                  [allergen.id, allergen.name_it, allergen.name_en, allergen.description_it, allergen.description_en, allergen.status, record_image_url(allergen), allergen.updated_at, allergen.created_at])
      end
    end

    def write_tags(sheet)
      write_row(sheet, 0,
                %w[id name.it name.en description.it description.en status color imageUrl updated_at created_at])
      Menu::Tag.visible.includes(tags_includes).limit(1000).each_with_index do |tag, index|
        write_row(sheet, index + 1,
                  [tag.id, tag.name_it, tag.name_en, tag.description_it, tag.description_en, tag.status, tag.color, record_image_url(tag), tag.updated_at, tag.created_at])
      end
    end

    def write_ingredients(sheet)
      write_row(sheet, 0, %w[id name.it name.en description.it description.en status imageUrl updated_at created_at])
      Menu::Ingredient.visible.includes(ingredient_includes).limit(1000).each_with_index do |ingredient, index|
        write_row(sheet, index + 1,
                  [ingredient.id, ingredient.name_it, ingredient.name_en, ingredient.description_it, ingredient.description_en, ingredient.status, record_image_url(ingredient), ingredient.updated_at, ingredient.created_at])
      end
    end

    # private

    def record_image_url(record)
      image_url(record.image)
    end

    def record_images_url(record)
      images_url(record.images)
    end

    # @Input Image record
    def image_url(image)
      return nil if image.blank?

      # @cached_image_urls[image.id] ||= image.url
      return @cached_image_urls[image.id] if @cached_image_urls.key?(image.id)

      # debugger

      image.url
    end

    def images_url(images)
      images.map { |j| image_url(j) }
    end

    def load_cached_image_urls
      @cached_image_urls = {}

      # , Menu::Ingredient, Menu::Dish, Menu::Tag, Menu::Category].map(&:name)

      images = Image.all.where(
        id: ImageToRecord.all.where(
          record: Menu::Allergen.visible
        ).or(
          ImageToRecord.all.where(record: Menu::Ingredient.visible)
        ).or(
          ImageToRecord.all.where(record: Menu::Dish.visible)
        ).or(
          ImageToRecord.all.where(record: Menu::Tag.visible)
        ).or(
          ImageToRecord.all.where(record: Menu::Category.visible)
        ).select(:image_id)
      )

      # debugger

      images.includes(:attached_image_blob).each do |image|
        @cached_image_urls[image.id] = image.url
      end

      GC.start
    end

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
      data = data.map { |d| d.is_a?(Time) ? d.strftime("%Y-%m-%d %H:%M") : d }
      write(sheet, x_start, 0, data)
    end

    def tags_includes
      %i[text_translations image]
    end

    def allergen_includes
      %i[text_translations image]
    end

    def ingredient_includes
      %i[text_translations image]
    end

    def dishes_includes
      [
        :text_translations, :images,
        { visible_menu_tags: tags_includes, visible_menu_allergens: allergen_includes, visible_menu_ingredients: ingredient_includes }
      ]
    end

    def categories_includes
      [:text_translations,
       :images,
       { visible_menu_dishes: dishes_includes }]
    end
  end
end
