# frozen_string_literal: true

require 'sidekiq_admin_constraint'
require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq', :constraints => SidekiqAdminConstraint
  require 'sidekiq/cron/web'
  require 'sidekiq-status/web'

  defaults format: :json do
    scope module: :v1, path: 'v1' do
      scope module: :admin, path: 'admin' do
        resources :preferences, only: %i[index] do
          collection do
            get ':key', action: :show
            get ':key/value', action: :value
            patch ':key', action: :update
          end
        end

        resources :settings, only: %i[index] do
          collection do
            get ':key', action: :show
            get ':key/value', action: :value
            patch ':key', action: :update
          end
        end

        scope module: :menu, path: 'menu' do
          resources :categories, only: %i[index show create update destroy]
          resources :ingredients, only: %i[index show create update destroy]
        end
      end
    end
  end
end
