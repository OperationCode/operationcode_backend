Rails.application.routes.draw do

  devise_for :users #, controllers: { sessions: 'api/v1/sessions', registrations: 'api/v1/users' }

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      get '/status', to: 'status#all'
      get '/status/protected', to: 'status#protected'
      post '/users', to: 'users#create'
      get '/code_schools', to: 'code_schools#index'

      get '/services', to: 'services#index'

      resources :mentors, only: [:index, :create]
      resources :requests, only: [:index, :create, :show]
      resources :squads, only: [:index, :create, :show]

      devise_scope :user do
        post '/sessions', to: 'sessions#create'
      end
    end
  end
end
