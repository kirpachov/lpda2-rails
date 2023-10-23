Rails.application.routes.draw do
  defaults format: :json do
    scope module: :v1, path: 'v1' do
      resources :preferences, only: %i[index] do
        collection do
          get ':key', action: :show
          get ':key/value', action: :value
          patch ':key', action: :update
        end
      end

      resources :settings, only: %i[index] do
        collection do
          get   ':key',       action: :show
          get   ':key/value', action: :value
          patch ':key',       action: :update
        end
      end
    end
  end
end
