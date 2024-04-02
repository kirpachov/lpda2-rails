# frozen_string_literal: true

require "sidekiq_admin_constraint"
require "sidekiq/web"

Rails.application.routes.draw do
  mount Sidekiq::Web => "/sidekiq", :constraints => SidekiqAdminConstraint
  require "sidekiq/cron/web"
  require "sidekiq-status/web"

  defaults format: :json do
    scope module: :v1, path: "v1" do
      resources :images, only: %w[index show create] do
        member do
          get "download", action: :download
          get "download/:variant", action: :download_variant
          patch "remove_from_record"
        end

        collection do
          patch "record", action: :update_record
          get "key/:key", action: :download_by_key, as: :download_by_key
          get "p/:secret", action: :download_by_pixel_secret, as: :download_by_pixel_secret
        end
      end

      resources :reservations, only: %i[create] do
        collection do
          get ":secret", action: :show
          patch "cancel", action: :cancel
        end
      end

      scope module: :admin, path: "admin" do
        resources :reservation_turns
        resources :reservation_tags
        resources :reservations do
          collection do
            get "valid_times"
          end

          member do
            patch "status/:status", action: :update_status
            post "add_tag/:tag_id", action: :add_tag
            delete "remove_tag/:tag_id", action: :remove_tag
            post "deliver_confirmation_email"
          end
        end

        resources :preferences, only: %i[index] do
          collection do
            get ":key", action: :show
            get ":key/value", action: :value
            patch ":key", action: :update
          end
        end

        resources :settings, only: %i[index] do
          collection do
            get ":key", action: :show
            get ":key/value", action: :value
            patch ":key", action: :update
          end
        end

        scope module: :menu, path: "menu" do
          resources :categories, only: %i[index show create update destroy] do
            member do
              post "copy"
              patch "visibility"
              patch "move/:to_index", action: :move

              post "dishes/:dish_id", action: :add_dish
              delete "dishes/:dish_id", action: :remove_dish
              post "add_category/:category_child_id", action: :add_category
              get "dashboard_data"
            end
          end

          resources :ingredients, only: %i[index show create update destroy] do
            member do
              post "copy"
            end
          end

          resources :tags, only: %i[index show create update destroy] do
            member do
              post "copy"
            end
          end

          resources :allergens, only: %i[index show create update destroy] do
            member do
              post "copy"
            end
          end

          resources :dishes, only: %i[index show create update destroy] do
            member do
              post "copy"

              # Providing params for "move" in request body.
              patch "move"

              delete "remove_from_category/:category_id", action: :remove_from_category
              delete "remove_from_category", action: :remove_from_category

              patch "status/:status", action: :update_status

              post "ingredients/:ingredient_id", action: :add_ingredient
              delete "ingredients/:ingredient_id", action: :remove_ingredient

              post "tags/:tag_id", action: :add_tag
              delete "tags/:tag_id", action: :remove_tag

              post "allergens/:allergen_id", action: :add_allergen
              delete "allergens/:allergen_id", action: :remove_allergen

              post "images/:image_id", action: :add_image
              delete "images/:image_id", action: :remove_image
            end
          end
        end
      end
    end
  end
end
