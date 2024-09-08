# frozen_string_literal: true

module Dev::Menu
  # Will generate some categories and dishes.
  # Meant to be run in development, in an empty database.
  # You can run, inside rails console:
  # Dev::Menu::GenerateFakeMenu.run!
  # If you want to clean database before running, you can run:
  # Dev::Menu::GenerateFakeMenu.run!(clean_before: true)
  class GenerateFakeMenu < ActiveInteraction::Base
    integer :menu_count, default: 7
    integer :categories_per_menu, default: 5
    integer :dishes_per_category, default: 5
    array :languages, default: %w[it en]

    boolean :clean_before, default: false

    def execute
      clean if clean_before

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

        add_children_to(menu, count: categories_per_menu, dishes_per_category:)
      end

      # Creating a fixed price menu
      fixed_price_menu = Menu::Category.without_parent.sample
      fixed_price_menu.update!(price: Random.rand(30.2..80.1))
      puts "Fixed price menu: ##{fixed_price_menu.id} #{fixed_price_menu.name} #{fixed_price_menu.price}€"

      # Creating a category that has other categories inside.
      Menu::Category.with_parent.sample(3).each do |category|
        add_children_to(category, count: Random.rand(1..3), dishes_per_category: Random.rand(2..10))
        puts "Category ##{category.id} #{category.name} has #{category.children.count} children (is both parent and children)"
      end

      # Creating a menu that is private.
      private_menu = Menu::Category.without_parent.where(price: nil).sample
      private_menu.visibility.update!(public_visible: false, private_visible: true, public_from: nil, public_to: nil,
                                      private_from: nil, private_to: nil, daily_from: nil, daily_to: nil)
      private_menu.assign_translation(:name, { it: "Menu privato", en: "Private menu" })
      private_menu.save!
      puts "Private menu: ##{private_menu.id} #{private_menu.name}"

      # Creating a menu that is public but visible only for lunch.
      public_daily_menu = Menu::Category.without_parent.where(price: nil).where.not(id: private_menu.id).sample
      public_daily_menu.assign_translation(:name,
                                           { it: "Menu pubblico solo a pranzo", en: "Public menu only for lunch" })
      public_daily_menu.save!
      public_daily_menu.visibility.update!(public_visible: true, private_visible: false, public_from: nil,
                                           public_to: nil, private_from: nil, private_to: nil, daily_from: "11:00", daily_to: "14:00")
      puts "Public daily menu, only for lunch time: ##{public_daily_menu.id} #{public_daily_menu.name}"

      Menu::Dish.all.sample((Menu::Dish.count / 3).to_i).each do |dish|
        dish.suggestions = Menu::Dish.all.where.not(id: dish.id).sample(rand(1..3))
        puts "Dish ##{dish.id} #{dish.name} has #{dish.suggestions.count} suggestions"
      end
    end

    def clean
      Menu::DishesInCategory.delete_all
      Menu::IngredientsInDish.delete_all
      Menu::TagsInDish.delete_all
      Menu::AllergensInDish.delete_all
      Menu::DishSuggestion.delete_all
      Menu::Dish.delete_all
      Menu::Category.delete_all
    end

    def add_children_to(menu, count:, dishes_per_category:)
      count.times do
        category = menu.children.create!
        category.images = Image.random_order.sample(rand(1..3))
        languages.each do |lang|
          category.update!(
            name: "#{Faker::Lorem.word} (Category ##{category.id} #{lang} name)",
            description: "#{Faker::Lorem.paragraph} (Category ##{category.id} #{lang} description)"
          )
        end

        add_dishes_to(category:, count: dishes_per_category)
      end
    end

    def add_dishes_to(category:, count:)
      count.times do
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

    def add_images_to(model)
      model.images = Image.random_order.sample(rand(1..3))
    end

    def add_image_to(model)
      model.image = Image.random_order.sample
    end
  end
end
