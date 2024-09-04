# frozen_string_literal: true

require "sidekiq_admin_constraint"
require "sidekiq/web"

Rails.application.routes.draw do
  mount Sidekiq::Web => "/sidekiq", :constraints => SidekiqAdminConstraint
  require "sidekiq/cron/web"
  require "sidekiq-status/web"

  defaults format: :json do
    scope module: :v1, path: "v1" do
      get "public_data", to: "public_data#index", as: :public_data

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
          get "valid_times"

          get ":secret", action: :show

          # Two alternative ways to cancel a reservation.
          # First one is safer: secret is in the body of the request.
          # Second one is "cleaner": secret is in the URL.
          patch "cancel", action: :cancel
          patch ":secret/cancel", action: :cancel

          post "cancel", action: :cancel
          post ":secret/cancel", action: :cancel

          post ":secret/resend_confirmation_email", action: :resend_confirmation_email
        end
      end

      # v1/profile
      # resource :profile, controller: "profile", only: %i[index]
      get "profile", to: "profile#index"

      # v1/auth
      resource :auth, controller: "auth", only: [] do
        post "login"
        post "refresh_token"
        post "logout"
        # post "require_otp"
        # post "verify_email"
        # post "change_password"
        post "reset_password"
        post "require_reset_password"
      end

      scope module: :menu, path: "menu" do
        resources :categories, only: %w[index show]
        resources :ingredients, only: %w[index show]
        resources :tags, only: %w[index show]
        resources :allergens, only: %w[index show]
        resources :dishes, only: %w[index show]
      end

      scope module: :admin, path: "admin" do
        resources :users, only: %i[index show create destroy]
        resources :reservation_turns
        resources :reservation_tags
        resources :public_messages, only: %i[index create update show], param: :key

        resources :reservations do
          collection do
            get "tables_summary"
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
            get "hash"
            get ":key", action: :show
            patch ":key", action: :update
          end
        end

        resources :settings, only: %i[index] do
          collection do
            get "hash"
            get ":key", action: :show
            get ":key/value", action: :value
            patch ":key", action: :update
          end
        end

        scope module: :menu, path: "menu" do
          get "export", action: :export, controller: :export

          resources :categories, only: %i[index show create update destroy] do
            member do
              post "copy"
              patch "visibility"
              patch "move/:to_index", action: :move
              patch "order_dishes"

              post "dishes/:dish_id", action: :add_dish
              delete "dishes/:dish_id", action: :remove_dish
              post "add_category/:category_child_id", action: :add_category
              get "dashboard_data"
            end
          end

          resources :ingredients do
            member do
              post "copy"
            end
          end

          resources :tags do
            member do
              post "copy"
            end
          end

          resources :allergens do
            member do
              post "copy"
            end
          end

          resources :dishes do
            member do
              post "copy"

              get "references"

              post "suggestions/:suggestion_id", action: :add_suggestion
              delete "suggestions/:suggestion_id", action: :remove_suggestion

              # Providing params for "move" in request body.
              patch "move"

              delete "remove_from_category/:category_id", action: :remove_from_category
              delete "remove_from_category", action: :remove_from_category

              patch "status/:status", action: :update_status

              post "ingredients/:ingredient_id", action: :add_ingredient
              patch "ingredients/:ingredient_id/move", action: :move_ingredient
              delete "ingredients/:ingredient_id", action: :remove_ingredient

              post "tags/:tag_id", action: :add_tag
              patch "tags/:tag_id/move", action: :move_tag
              delete "tags/:tag_id", action: :remove_tag

              post "allergens/:allergen_id", action: :add_allergen
              patch "allergens/:allergen_id/move", action: :move_allergen
              delete "allergens/:allergen_id", action: :remove_allergen

              post "images/:image_id", action: :add_image
              delete "images/:image_id", action: :remove_image
            end
          end
        end
      end
    end
  end

  match "*unmatched", to: "application#render_endpoint_not_found", via: :all
end
