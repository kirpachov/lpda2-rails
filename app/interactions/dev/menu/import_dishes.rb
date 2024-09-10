# frozen_string_literal: true

require "csv"

module Dev::Menu
  class ImportDishes < ActiveInteraction::Base
    DEFAULT_FILE = Rails.root.join("migration/menu/dishes.csv").to_s

    string :file, default: DEFAULT_FILE

    def execute
      CSV.foreach(file, headers: true, col_sep: ";", liberal_parsing: true) do |row|
        dish = Menu::Dish.find_or_initialize_by(member_id: row["id"])
        Mobility.with_locale(:it) do
          dish.name = row["name.it"]
          dish.description = row["description.it"]
        end

        Mobility.with_locale(:en) do
          dish.name = row["name.en"]
          dish.description = row["description.en"]
        end

        dish.status = row["enabled"] == 1 ? "active" : "inactive"
        dish.price = row["price"].to_f

        dish.save!

        if (category = Menu::Category.find_by(member_id: "lpda-category-#{menu_ids[row["id"]]}")) && !dish.categories.include?(category)
          dish.categories << category
        end

        if row["imageId"].present? && (image = Image.find_by(member_id: row["imageId"])) && !dish.images.include?(image)
          dish.images << image
        end

        Menu::Tag.where(member_id: tag_ids[row["id"]]).each do |tag|
          dish.tags << tag unless dish.tags.include?(tag)
        end

        Menu::Allergen.where(member_id: allergen_ids[row["id"]]).each do |allergen|
          dish.allergens << allergen unless dish.allergens.include?(allergen)
        end

        Menu::Ingredient.where(member_id: ingredient_ids[row["id"]]).each do |ingredient|
          dish.ingredients << ingredient unless dish.ingredients.include?(ingredient)
        end

        dish.save!

        # puts "Added dish ##{dish.id} (#{dish.name}) to category #{category&.id.inspect} (#{category&.name.inspect})"
      end
    end

    # Returns a hash of { foodItemId => categoryId } where foodItem is the dish
    def menu_ids
      return @menu_ids if @menu_ids

      data = CSV.open(Rails.root.join("migration/menu/categoryItemAssociation.csv"), headers: true, col_sep: ";", liberal_parsing: true).to_a.map(&:to_h)

      @menu_ids = data.map { |j| [j["foodItemId"], j["categoryId"]] }.to_h
    end

    # Returns a hash of { foodItemId => tagsId[] }
    def tag_ids
      return @tag_ids if @tag_ids

      data = CSV.open(Rails.root.join("migration/menu/foodTagsAssociation.csv"), headers: true, col_sep: ";", liberal_parsing: true).to_a.map(&:to_h)

      @tag_ids = data.group_by { |j| j["foodItemId"] }.map { |k, v| [k, v.map { |j| j["tagId"] }] }.to_h
    end

    def allergen_ids
      return @allergen_ids if @allergen_ids

      data = CSV.open(Rails.root.join("migration/menu/foodAllergensAssociation.csv"), headers: true, col_sep: ";", liberal_parsing: true).to_a.map(&:to_h)

      @allergen_ids = data.group_by { |j| j["foodItemId"] }.map { |k, v| [k, v.map { |j| j["allergenId"] }] }.to_h
    end

    def ingredient_ids
      return @ingredient_ids if @ingredient_ids

      data = CSV.open(Rails.root.join("migration/menu/foodIngredientsAssociation.csv"), headers: true, col_sep: ";", liberal_parsing: true).to_a.map(&:to_h)

      @ingredient_ids = data.group_by { |j| j["foodItemId"] }.map { |k, v| [k, v.map { |j| j["ingredientId"] }] }.to_h
    end
  end
end
