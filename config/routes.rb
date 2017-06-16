Rails.application.routes.draw do

  devise_for :users

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      get '/status', to: 'status#all'
      get '/status/protected', to: 'status#protected'
      post '/users', to: 'users#create'
      get '/code_schools', to: 'code_schools#index'
      get '/events', to: 'events#index'

      get '/services', to: 'services#index'

      resources :mentors, only: [:index, :create, :show]
      resources :requests, only: [:index, :create, :show, :update]
      resources :squads, only: [:index, :create, :show] do
        member do
          post 'join'
        end
      end

      devise_scope :user do
        post '/sessions', to: 'sessions#create'
      end
    end
  end
end
