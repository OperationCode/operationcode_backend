Rails.application.routes.draw do

  devise_for :users

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      get '/status', to: 'status#all'
      get '/status/protected', to: 'status#protected'

      post '/users', to: 'users#create'
      post '/users/profile/verify', to: 'users#verify'

      resources :code_schools, only: :index
      resources :events, only: :index
      resources :mentors, only: [:index, :create, :show]
      resources :requests, only: [:index, :create, :show, :update]
      resources :resources, only: [:index, :create, :show, :update, :destroy] do
        resources :votes, only: [:create, :destroy]
      end
      resources :services, only: :index
      resources :squads, only: [:index, :create, :show] do
        member do
          post 'join'
        end
      end
      resources :tags, only: :index
      resources :team_members, only: [:index, :create, :update, :destroy]

      devise_scope :user do
        post '/sessions', to: 'sessions#create'
      end
    end
  end
end
