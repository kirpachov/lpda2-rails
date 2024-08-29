# frozen_string_literal: true

module Dev::Menu
  # Will generate some categories and dishes.
  # Meant to be run in development, in an empty database.
  # You can run, inside rails console:
  # Dev::Menu::GenerateFakeMenu.run!
  # If you want to clean database before running, you can run:
  # reload!; Menu::DishesInCategory.delete_all; Menu::IngredientsInDish.delete_all; Menu::TagsInDish.delete_all; Menu::AllergensInDish.delete_all; Menu::DishSuggestion.delete_all; Menu::Dish.delete_all; Menu::Category.delete_all; Dev::Menu::GenerateFakeMenu.run!
  class GenerateFakeMenu < ActiveInteraction::Base
    integer :menu_count, default: 5
    integer :categories_per_menu, default: 5
    integer :dishes_per_category, default: 5
    array :languages, default: %w[it en]

    def execute
      raise "You can't run this in production" if Rails.env.production?

      require "faker"

      menu_count.times do
        menu = Menu::Category.create!(visibility: Menu::Visibility.create!)
        menu.images = Image.random_order.sample(rand(1..3))
        languages.each do |lang|
          menu.update!(
            name: "#{Faker::Lorem.word} (Menu ##{menu.id} #{lang} name)",
            description: "#{Faker::Lorem.paragraph} (Menu ##{menu.id} #{lang} description)"
          )
        end

        categories_per_menu.times do
          category = menu.children.create!
          category.images = Image.random_order.sample(rand(1..3))
          languages.each do |lang|
            category.update!(
              name: "#{Faker::Lorem.word} (Category ##{category.id} #{lang} name)",
              description: "#{Faker::Lorem.paragraph} (Category ##{category.id} #{lang} description)"
            )
          end

          dishes_per_category.times do
            dish = category.dishes.create!
            dish.images = Image.random_order.sample(rand(1..3))

            languages.each do |lang|
              dish.update!(
                name: "#{Faker::Food.dish} (Dish ##{dish.id} #{lang})",
                description: Faker::Food.description
              )
            end

            dish.update!(price: Faker::Commerce.price)
            dish.allergens = ::Menu::Allergen.random_order.sample(rand(0..3))
            dish.tags = ::Menu::Tag.random_order.sample(rand(0..3))
            dish.ingredients = ::Menu::Ingredient.random_order.sample(rand(0..3))
            dish.save!
          end
        end
      end
    end
  end
end
