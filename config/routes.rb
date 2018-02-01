Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      get 'git_hub_statistics/averages', to: 'git_hub_statistics#oc_averages'
      get 'git_hub_statistics/totals', to: 'git_hub_statistics#oc_totals'
      get 'git_hub_statistics/by_repository', to: 'git_hub_statistics#totals_by_repository'
      get 'git_hub_statistics/for_user', to: 'git_hub_statistics#totals_for_user'
      get 'git_hub_statistics/user_in_repository', to: 'git_hub_statistics#totals_for_user_in_repository'

      get '/status', to: 'status#all'
      get '/status/protected', to: 'status#protected'

      get '/users/by_location', to: 'users#by_location'
      post '/users/profile/verify', to: 'users#verify'

      resources :code_schools do
        resources :locations
      end
      resources :email_list_recipients, only: :create
      resources :events, only: :index
      resources :mentors, only: [:index, :create, :show]
      resources :requests, only: [:index, :create, :show, :update]
      resources :resources, only: [:index, :create, :show, :update, :destroy] do
        resources :votes, only: [:create, :destroy]
      end
      resources :scholarships, only: [:index, :show]
      resources :scholarship_applications, only: :create
      resources :services, only: :index
      resources :slack_users, only: :create
      resources :tags, only: :index
      resources :team_members, only: [:index, :create, :update, :destroy]
      resources :users, only: [:index, :create]
      patch '/users', to: 'users#update'

      devise_scope :user do
        post '/sessions', to: 'sessions#create'
        get '/sessions/sso', to: 'sessions#sso'
      end

      namespace :users do
        post '/passwords/reset', to: 'passwords#reset'
      end
    end
  end
end
